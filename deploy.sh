#!/bin/bash

# ============================================================================
# Deploy script for Rewriting application
# Compiles the project and deploys to Tomcat
# ============================================================================

echo ""
echo "========================================"
echo " Rewriting Deploy Script"
echo "========================================"
echo ""

# Check if Tomcat directory is specified
if [ -z "$1" ]; then
    echo "Usage: ./deploy.sh [TOMCAT_PATH]"
    echo ""
    echo "Example:"
    echo "  ./deploy.sh /opt/tomcat"
    echo "  ./deploy.sh"
    echo ""
    echo "If TOMCAT_PATH is not provided, the script will use CATALINA_HOME environment variable."
    echo ""

    if [ -z "$CATALINA_HOME" ]; then
        echo "ERROR: CATALINA_HOME environment variable is not set!"
        echo "Please set it or provide Tomcat path as argument."
        echo ""
        exit 1
    fi
    TOMCAT_PATH="$CATALINA_HOME"
else
    TOMCAT_PATH="$1"
fi

# Verify Tomcat directory exists
if [ ! -d "$TOMCAT_PATH" ]; then
    echo "ERROR: Tomcat directory not found: $TOMCAT_PATH"
    echo "Please check the path and try again."
    echo ""
    exit 1
fi

echo "[1/4] Tomcat path: $TOMCAT_PATH"
echo ""

# Navigate to source directory
cd "$(dirname "$0")/source" || exit 1
echo "[2/4] Compiling with Maven..."
echo ""

# Run Maven clean package
mvn clean package
if [ $? -ne 0 ]; then
    echo ""
    echo "ERROR: Maven build failed!"
    echo ""
    exit 1
fi

echo ""
echo "[3/4] Build successful! WAR file created."
echo ""

# Stop Tomcat (optional but recommended)
echo "[4/4] Deploying to Tomcat..."
echo ""

# Check if Tomcat is running and stop it
if [ -f "$TOMCAT_PATH/bin/shutdown.sh" ]; then
    echo "Stopping Tomcat..."
    "$TOMCAT_PATH/bin/shutdown.sh"
    sleep 3
fi

# Remove old WAR file
if [ -f "$TOMCAT_PATH/webapps/rewriting.war" ]; then
    echo "Removing old WAR file..."
    rm "$TOMCAT_PATH/webapps/rewriting.war"
fi

# Remove old extracted directory
if [ -d "$TOMCAT_PATH/webapps/rewriting" ]; then
    echo "Removing old application directory..."
    rm -rf "$TOMCAT_PATH/webapps/rewriting"
fi

# Copy new WAR file
echo "Copying new WAR file to Tomcat..."
cp "target/rewriting.war" "$TOMCAT_PATH/webapps/" || {
    echo ""
    echo "ERROR: Failed to copy WAR file!"
    echo ""
    exit 1
}

echo ""
echo "========================================"
echo " Deployment Complete!"
echo "========================================"
echo ""
echo "Application: http://localhost:8080/rewriting"
echo ""
echo "Next step: Start Tomcat with:"
echo "   $TOMCAT_PATH/bin/startup.sh"
echo ""
