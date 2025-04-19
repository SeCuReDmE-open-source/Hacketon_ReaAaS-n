
#!/bin/bash

# Detect the mode based on the current directory
CURRENT_DIR=$(pwd)
if [[ "$CURRENT_DIR" == *"/src"* ]]; then
    MODE="development"
else
    MODE="install_module"
fi

echo "Setup Mode: $MODE"

# Read global settings if any
# ...existing code...

# Iterate through each module and run its install script
for module in src/modules/*; do
    if [ -f "$module/install.sh" ]; then
        echo "Installing module: $(basename $module)"
        cd "$module"
        ./install.sh
        cd -
    fi
done

echo "Setup completed."