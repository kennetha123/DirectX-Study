@echo off


echo ===============================================
echo =============VEIN ENGINE SETUP=================
echo ===============================================

call Tools\premake\premake5.exe --file=Make/premake5.lua vs2019

pause