# ReaAaS-n (Hackathon Project)

## Overview

ReaAaS-n is a multifaceted project developed for a hackathon. It appears to integrate several advanced concepts, including:

* **AI Toolkit:** Functionality for fine-tuning and running inference on AI models (specifically mentioning Phi-3) using techniques like QLoRA. It provides interfaces for interaction via console and web (Gradio).
* **Data Processing Pipeline:** Utilizes tools like Airbyte for data synchronization, PostgreSQL for database storage, and MindsDB for in-database machine learning and time series forecasting[cite: 1, 3, 5].
* **FfeD Framework & Neutrosophic/Quantum Enhancements:** Incorporates custom logic potentially involving the FfeD framework, Neutrosophic data processing (handling uncertainty/missing data), and Quantum concepts.
* **Dockerized Environment:** Leverages Docker and Docker Compose for managing various services like the core server, MindsDB, PostgreSQL, Redis, and potentially Airbyte[cite: 3].

## Technologies Used

* **Backend:** Python [cite: 1, 4, 5]
* **AI/ML:** MindsDB, PyTorch, Transformers, Qiskit, ONNXRuntime, bitsandbytes, peft, accelerate, olive-ai
* **Data:** Airbyte, PostgreSQL, Redis, Pandas, Numpy, tsfresh [cite: 1, 3]
* **Containerization:** Docker, Docker Compose [cite: 3]
* **Environment:** Conda
* **Frontend/Interface:** Gradio, FastAPI
* **CI/CD:** Azure Pipelines [cite: 1]
* **Other:** Vercel Analytics

## Setup

*(Note: Setup might vary depending on the component you are focusing on. These are general steps based on the AI Toolkit part)*

1.  **Clone the Repository:**
    ```bash
    git clone [https://github.com/SeCuReDmE-open-source/Hacketon_ReaAaS-n.git](https://github.com/SeCuReDmE-open-source/Hacketon_ReaAaS-n.git)
    cd Hacketon_ReaAaS-n
    ```
2.  **Set up Conda Environment:** (Referencing the AI Toolkit setup)
    * Ensure Conda is installed.
    * Run the setup script (adjust path if needed):
        ```bash
        ./ReaAaS-n/setup/first_time_setup.sh
        ```
    * Activate the environment (check `conda-environment.yml` for the exact name, e.g., `phi-3-env`):
        ```bash
        conda activate <conda_env_name>
        ```
3.  **Install Dependencies:** The Conda environment setup should handle this based on `requirements.txt` files. If not, install manually:
    ```bash
    pip install -r requirements.txt
    # Potentially install requirements from ReaAaS-n/setup/requirements.txt as well
    pip install -r ReaAaS-n/setup/requirements.txt
    ```
4.  **Docker Services (Optional):** If using the Dockerized components (like FfeD server, MindsDB, DB):
    ```bash
    docker-compose build # Optional, if images need building [cite: 3]
    docker-compose up -d # Start services in detached mode [cite: 3]
    ```

## Basic Usage (AI Toolkit - Fine-tuning & Inference)

*(Ensure the Conda environment is activated)*

1.  **Fine-tuning:**
    * Navigate to the project root if needed.
    * Run the Olive fine-tuning script:
        ```bash
        python ReaAaS-n/finetuning/invoke_olive.py
        ```
    * Checkpoints and the final adapter model should be saved in the `models` directory.

2.  **Inference (After Fine-tuning):**
    * Navigate to the inference directory:
        ```bash
        cd ReaAaS-n/inference
        ```
    * **Console Chat:**
        ```bash
        python console_chat.py
        ```
    * **Web UI Chat (Gradio):**
        ```bash
        python gradio_chat.py
        ```
        Then open the provided URL (e.g., `http://127.0.0.1:7860`) in your browser.

## Project Components

The repository contains several components:

* **`Hacketon_ReaAaS-n/` (Root):** Contains core setup (`docker-compose.yml`, `requirements.txt`), potentially the FfeD server logic, MindsDB integration (`model.py`, `modulesettings.json`), Airbyte pipeline scripts (`airbyte_pipeline.py`), tests, and documentation[cite: 1, 3, 5].
* **`Hacketon_ReaAaS-n/ReaAaS-n/`:** Seems to contain the AI Toolkit specific parts, including setup scripts, fine-tuning configuration (`olive-config.json`), inference scripts (`chat.py`, `console_chat.py`, `gradio_chat.py`), and datasets.
* **`Hacketon_ReaAaS-n/neutrosophic quantum FfeD enhancement/`:** Contains Python modules likely implementing the enhanced Neutrosophic Quantum FfeD logic.
* **`Hacketon_ReaAaS-n/docs/`:** Contains module documentation, including details on the Neutrosophic enhancements and MCP subrepo integrations.
