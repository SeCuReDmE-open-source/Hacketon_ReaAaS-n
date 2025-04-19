
#!/bin/bash

# Detect the current environment
echo "Detecting environment..."
OS=$(uname)
ARCH=$(uname -m)
echo "OS: $OS, Architecture: $ARCH"

# Read modulesettings.json
echo "Loading module settings..."
MODULE_SETTINGS=$(cat modulesettings.json)
echo "Settings: $MODULE_SETTINGS"

# Setup Python environment
echo "Setting up Python environment..."
python3 -m venv venv
source venv/bin/activate

# Run module's install script
echo "Running module install scripts..."
./install_dependencies.sh

# Install requirements
echo "Installing Python packages..."
pip install -r requirements.txt

# Run post-install scripts
echo "Running post-install scripts..."
./post_install.sh

echo "Installation completed successfully."