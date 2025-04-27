#!/bin/bash

# Create main project directories
mkdir -p src/{modules,SDK,runtimes}
mkdir -p src/modules/NeutrosophicDataProcessing/test
mkdir -p src/modules/NeutrosophicDataProcessing/models
mkdir -p SDK/{Python,Scripts}

# Create a .gitignore file
cat <<EOL > .gitignore
# Python
__pycache__/
*.py[cod]
*$py.class
*.so
.Python
env/
build/
develop-eggs/
dist/
downloads/
eggs/
.eggs/
lib/
lib64/
parts/
sdist/
var/
*.egg-info/
.installed.cfg
*.egg

# Virtual Environment
venv/
ENV/

# IDE
.idea/
.vscode/
*.swp
*.swo

# Logs
*.log

# Models directory (large files)
models/

# Docker
.docker/
EOL

# Create a requirements.txt file
cat <<EOL > requirements.txt
mindsdb
torch
torchquantum
pytorchquantum
qiskit
transformers
pycaret
ray[tune]
pillow
numpy
onnxruntime
EOL

# Create a Dockerfile for the main application
cat <<EOL > Dockerfile
FROM python:3.9-slim

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \\
    build-essential \\
    curl \\
    software-properties-common \\
    git \\
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
COPY requirements.txt .
RUN pip3 install --no-cache-dir -r requirements.txt

# Copy source code
COPY src/ .

# Set environment variables
ENV PYTHONPATH=/app
ENV U2NET_HOME=/app/models

# Expose ports
EXPOSE 32168
EXPOSE 32168/udp

# Command to run the application
CMD ["python3", "modules/NeutrosophicDataProcessing/data_filter_adapter.py"]
EOL

# Create a docker-compose.yml file for development
cat <<EOL > docker-compose.yml
version: '3.8'

services:
  ffed_server:
    build: .
    ports:
      - "32168:32168"
      - "32168:32168/udp"
    volumes:
      - ./src:/app/src
      - ./models:/app/models
    environment:
      - PYTHONPATH=/app
      - U2NET_HOME=/app/models
    networks:
      - ffed_network

  mindsdb:
    image: mindsdb/mindsdb
    ports:
      - "47334:47334"
    volumes:
      - mindsdb_data:/root/mindsdb_storage
    networks:
      - ffed_network

networks:
  ffed_network:
    driver: bridge

volumes:
  mindsdb_data:
EOL

# Create installation scripts for both Linux/macOS and Windows
cat <<EOL > install.sh
#!/bin/bash

# Download models
echo "Downloading models..."
./SDK/Scripts/utils.sh getFromServer "rembg-models.zip" "models" "Downloading Background Remover models..."

# Setup Python virtual environment
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt

# Build Docker images
docker-compose build

# Install MindsDB and dependencies
pip install mindsdb statsforecast neuralforecast

# Start MindsDB
mindsdb --api=http &

# Wait for MindsDB to start
sleep 10

# Create MindsDB engine for the custom model
curl -X POST "http://localhost:47334/api/handlers/byom/neuucro_engine" \
  -F "code=@model.py" \
  -F "modules=@requirements.txt"

# Verify that the engine was created
mindsdb_sql "SHOW ML_ENGINES;"
EOL

cat <<EOL > install.bat
@echo off

:: Download models
call "%sdkScriptsPath%\\utils.bat" GetFromServer "rembg-models.zip" "models" "Downloading Background Remover models..."

:: Setup Python virtual environment
python -m venv venv
call venv\\Scripts\\activate
pip install -r requirements.txt

:: Build Docker images
docker-compose build
EOL

# Create a README.md file to provide setup instructions and documentation
cat <<EOL > README.md
# FfeD Project

## Setup Instructions

1. Clone the repository:
\`\`\`bash
git clone <repository-url>
cd FfeD_project
\`\`\`

2. Install dependencies:
For Linux/macOS: \`./install.sh\`
For Windows: \`install.bat\`

3. Start the services:
\`\`\`bash
docker-compose up
\`\`\`

## Access the services:
- CodeProject.AI Server: [http://localhost:32168](http://localhost:32168)
- MindsDB: [http://localhost:47334](http://localhost:47334)

## Development
- Create new modules in \`src/modules/\`
- Add Python dependencies to \`requirements.txt\`
- Update Docker configuration as needed
- Test modules using \`explore.html\`

## Testing
- Open \`src/modules/NeutrosophicDataProcessing/explore.html\` in a browser
- Upload an image
- Click "Remove Background"
- Check results

## Building for Production
- Update version in \`modulesettings.json\`
- Package the module:
\`\`\`bash
./SDK/Scripts/create_packages.sh
\`\`\`

## License
[Your License Here]

This setup provides:
- Complete development environment
- Docker containers for isolation
- MindsDB integration
- Testing framework
- Installation scripts
- Documentation
- Version control setup

To start development:
1. Clone the repository
2. Run installation script
3. Start Docker services
4. Begin developing in \`src/modules/\`

The system will automatically handle:
- Python virtual environments
- Model downloads
- Docker container creation
- Network setup
- MindsDB integration
EOL
