@echo off
REM ============================================================================
REM Deploy script for Rewriting application
REM Compiles the project and deploys to Tomcat
REM ============================================================================

echo.
echo ========================================
echo  Rewriting Deploy Script
echo ========================================
echo.

REM Check if Tomcat directory is specified
if "%1"=="" (
    REM Use default Tomcat path
    set TOMCAT_PATH=C:\Program Files\Tomcat\apache-tomcat-11.0.13
) else (
    set TOMCAT_PATH=%1
)

echo [1/4] Tomcat path: %TOMCAT_PATH%
echo.

REM Verify Tomcat directory exists
if not exist "%TOMCAT_PATH%" (
    echo ERROR: Tomcat directory not found: %TOMCAT_PATH%
    echo Please check the path and try again.
    echo.
    pause
    exit /b 1
)

echo [2/4] Compiling with Maven...
echo.

REM Navigate to source directory
cd /d "%~dp0source" || exit /b 1

REM Run Maven clean package
call mvn clean package -q
if errorlevel 1 (
    echo.
    echo ERROR: Maven build failed!
    echo.
    pause
    exit /b 1
)

echo.
echo [3/4] Build successful! WAR file created.
echo.

REM Stop Tomcat (optional but recommended)
echo [4/4] Deploying to Tomcat...
echo.

REM Check if Tomcat is running and stop it
if exist "%TOMCAT_PATH%\bin\shutdown.bat" (
    echo Stopping Tomcat...
    call "%TOMCAT_PATH%\bin\shutdown.bat"
    timeout /t 10 /nobreak
)

REM Remove old WAR file
if exist "%TOMCAT_PATH%\webapps\rewriting.war" (
    echo Removing old WAR file...
    del "%TOMCAT_PATH%\webapps\rewriting.war"
)

REM Remove old extracted directory
if exist "%TOMCAT_PATH%\webapps\rewriting" (
    echo Removing old application directory...
    rmdir /s /q "%TOMCAT_PATH%\webapps\rewriting"
)

REM Copy new WAR file
echo Copying new WAR file to Tomcat...
copy "target\rewriting.war" "%TOMCAT_PATH%\webapps\" || (
    echo.
    echo ERROR: Failed to copy WAR file!
    echo.
    pause
    exit /b 1
)

echo.
echo ========================================
echo  Deployment Complete!
echo ========================================
echo.
echo Application: http://localhost:8080/rewriting
echo.
echo Next step: Start Tomcat with:
echo   "%TOMCAT_PATH%\bin\startup.bat"
echo.
pause
