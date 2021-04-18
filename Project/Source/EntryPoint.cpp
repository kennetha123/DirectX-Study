#include "dxpch.h"
#include <thread>

LRESULT CALLBACK WindowProc(HWND hWnd, UINT uMsg, WPARAM wParam, LPARAM lParam);
void OnSize(HWND hWnd, UINT flag, int width, int height);

struct StateInfo
{

};

int WINAPI wWinMain(HINSTANCE hInstance, HINSTANCE prevInstance, PWSTR pCmdLine, int cmdShow)
{
	const WCHAR CLASS_NAME[] = L"Directx Learn";

	WNDCLASS windowClass = {};

	windowClass.lpfnWndProc		= WindowProc;
	windowClass.hInstance		= hInstance;
	windowClass.lpszClassName	= CLASS_NAME;

	RegisterClass(&windowClass);

	HWND hWnd = CreateWindowEx(
		WS_EX_TRANSPARENT,		// Optional windows style.
		CLASS_NAME,				// Window class.
		L"Direct X Learn",		// Window name.
		WS_OVERLAPPEDWINDOW,	// Window style (can use AND OR)

		CW_USEDEFAULT, CW_USEDEFAULT, CW_USEDEFAULT, CW_USEDEFAULT,

		NULL,					// Parent Window
		NULL,					// Menu
		hInstance,				// Handle Instance
		prevInstance			// Additional application data
		);

	if (hWnd == NULL)
	{
		return 0;
	}

	ShowWindow(hWnd, cmdShow);

	MSG msg = { };
	while (GetMessage(&msg, NULL, 0, 0))
	{
		TranslateMessage(&msg);
		DispatchMessage(&msg);
	}

	return 0;
}

inline StateInfo* GetAppState(HWND hwnd)
{
	LONG_PTR ptr = GetWindowLongPtr(hwnd, GWLP_USERDATA);
	StateInfo* pState = reinterpret_cast<StateInfo*>(ptr);
	return pState;
}

LRESULT CALLBACK WindowProc(HWND hwnd, UINT uMsg, WPARAM wParam, LPARAM lParam)
{
	StateInfo* pState = new (std::nothrow) StateInfo;

	if (pState == NULL)
	{
		return 0;
	}

	if(uMsg == WM_CREATE)
	{
		CREATESTRUCT* pCreate = reinterpret_cast<CREATESTRUCT*>(lParam);
		pState = reinterpret_cast<StateInfo*>(pCreate->lpCreateParams);
		SetWindowLongPtr(hwnd, GWLP_USERDATA, (LONG_PTR)pState);
	}
	else
	{
		pState = GetAppState(hwnd);
	}

	switch (uMsg)
	{
	case WM_DESTROY:
		PostQuitMessage(0);
		return 0;
	case WM_CLOSE:
		if (MessageBox(hwnd, L"Really want to Quit?", L"Direct X Learn", MB_OKCANCEL) == IDOK)
		{
			DestroyWindow(hwnd);
		}
		return 0;

	case WM_PAINT:
		{
		PAINTSTRUCT ps;
		HDC hdc = BeginPaint(hwnd, &ps);

		FillRect(hdc, &ps.rcPaint, (HBRUSH)(COLOR_WINDOW));

		EndPaint(hwnd, &ps);
		}
		return 0;
	case WM_SIZE:
		{
			int width = LOWORD(lParam);
			int height = HIWORD(lParam);

			OnSize(hwnd, (UINT)wParam, width, height);
		}
		break;
	}
	return DefWindowProc(hwnd, uMsg, wParam, lParam);
}

void OnSize(HWND hWnd, UINT flag, int width, int height)
{

}