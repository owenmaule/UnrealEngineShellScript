@echo off

cd %~dp0
echo Running in project: %CD%

set doall=
set /p doall=Type "All" to clean all temporary files:
if "%doall%"=="all" set doall=All
rem echo DoAll = %doall%
if "%doall%"=="All" echo We're not in Kansas anymore!

echo Starting...
rem call :cleandir "Binaries\Win64" %doall%
call :cleandir Binaries %doall%
call :cleandir DerivedDataCache %doall%
call :cleandir Intermediate %doall%
call :cleandir Saved %doall%

for /d %%p in ("Plugins\*", "Plugins\Developer\RiderLink", "Plugins\GameFeatures\*") do (
call :cleanplug %%~p %doall%
)

echo Complete
pause
exit \b

:cleandir

if exist "%1" (
  if "%2"=="All" (
    rd /s /q "%1"
    echo Cleaned %1
  ) else (
    rem Prompt for %1
    rd /s "%1"
  )
) else echo Already clean: %1
exit /b

:cleanplug
call :cleandir %1\Binaries %2
call :cleandir %1\Intermediate %2
exit /b
