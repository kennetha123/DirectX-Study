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

-- struct to easier include dir rather than using path
IncludeDir = {}
IncludeDir["ImGui"] 	= 	(trunk .. "Externals/imgui")
--IncludeDir["glm"] 		= 	(trunk .. "Externals/glm")
IncludeDir["stb_image"] = 	(trunk .. "Externals/stb_image")
IncludeDir["spdlog"] 	= 	(trunk .. "Externals/spdlog/include")


-- output name for bin / obj
outputName = "%{cfg.system}/%{cfg.buildcfg}/%{cfg.architecture}"

-- take another premake to build the project
include (trunk .. "Externals/imgui/project")

-------------------------------------------------------------------------------------
------------------------ Engine project ---------------------------------------------	
-------------------------------------------------------------------------------------

project "DxStudy"
	location (trunk .. "Project")
	kind "WindowedApp"
	language "C++"
	cppdialect "C++17"
	staticruntime "on"
	
	targetdir 	(trunk .. "Project/bin/" .. outputName)
	objdir		(trunk .. "Project/obj/" .. outputName)
	
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
		"%{IncludeDir.ImGui}",
		"%{IncludeDir.stb_image}",
		"%{IncludeDir.spdlog}"
	}
	
	links
	{
		"ImGui",
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