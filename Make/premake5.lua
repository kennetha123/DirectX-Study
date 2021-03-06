workspace "DirectX-Study"
	location ".."
	architecture "x64"
	startproject "Game"
	
	configurations
	{
		"Debug",
		"Develop",
		"Release"
	}

trunk = "../"

-- output name for bin / obj
outputName = "%{cfg.system}/%{cfg.buildcfg}/%{cfg.architecture}"

-------------------------------------------------------------------------------------
------------------------ Engine project ---------------------------------------------	
-------------------------------------------------------------------------------------

project "DxStudy"
	location (trunk .. "Project")
	kind "WindowedApp"
	language "C++"
	cppdialect "C++17"
	staticruntime "on"
	
	targetdir 	(trunk .. "Output/bin/" .. outputName)
	objdir		(trunk .. "Output/obj/" .. outputName)
	
	-- use precompile header
	pchheader "dxpch.h"
	pchsource (trunk .. "Project/Source/dxpch.cpp")
	
	files
	{
		(trunk .. "Project/Source/**.h"),
		(trunk .. "Project/Source/**.cpp"),
	}
	
	defines
	{
		"_CRT_SECURE_NO_WARNINGS"
	}

	
	includedirs
	{
		(trunk .. "%Project/Source"),
	}
		
	filter "system:windows"
		systemversion "latest"
		
		-- preprocessor definition
	defines
	{
		
	}
	
	filter "configurations:Debug"
		defines "DX_DEBUG"
		runtime "Debug"
		symbols "on"
	
	filter "configurations:Develop"
		defines "DX_DEV"
		runtime "Release"
		optimize "on"	

	filter "configurations:Release"
		defines "DX_RELEASE"
		runtime "Release"
		optimize "on"