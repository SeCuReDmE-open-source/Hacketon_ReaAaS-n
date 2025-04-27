# Base image with core dependencies
FROM python:3.10-slim as deps
WORKDIR /app
COPY requirements*.txt ./
COPY setup.py default_handlers.txt README.md ./
COPY neutrosophic/__about__.py neutrosophic/

# Development image with additional tools
FROM python:3.10 as build
WORKDIR /app
ARG EXTRAS

# Install uv package manager
COPY --from=ghcr.io/astral-sh/uv:0.4.23 /uv /usr/local/bin/uv
COPY --from=deps /app .

COPY install.sh install.bat ./
RUN chmod +x install.sh
RUN ./install.sh

ENV UV_LINK_MODE=copy \
    UV_COMPILE_BYTECODE=1 \
    UV_PYTHON_DOWNLOADS=never \
    UV_PYTHON=python3.10 \
    UV_PROJECT_ENVIRONMENT=/app \
    VIRTUAL_ENV=/venv \
    PATH=/venv/bin:$PATH

# Install dependencies
RUN --mount=type=cache,target=/root/.cache \
    uv venv /venv && \
    uv pip install "." && \
    if [ -n "$EXTRAS" ]; then uv pip install $EXTRAS; fi

# Development environment
FROM build as dev
RUN pip install pytest black mypy

# Testing image with pytest
FROM dev as test
COPY tests/ /app/tests/
CMD ["pytest", "/app/tests"]

# Neutrosophic core image
FROM build as neutrosophic
COPY neutrosophic%20quantum%20FfeD%20enhancement/core.py /app/
RUN pip install \
    tensorflow-gpu \
    pytorch \
    scikit-learn \
    numpy \
    pandas \
    scipy

# Full featured image with all integrations
FROM neutrosophic as cloud
RUN pip install \
    mindsdb[writer,statsforecast,neuralforecast] \
    chromadb \
    sentence-transformers \
    impyla

# Production environment 
FROM python:3.10-slim as prod
WORKDIR /app
COPY --from=build /venv /venv
COPY --from=build /app /app
ENV PYTHONUNBUFFERED=1 \
    VIRTUAL_ENV=/venv \
    PATH=/venv/bin:$PATH

EXPOSE 47334/tcp 47335/tcp 47336/tcp

ENTRYPOINT ["python", "-m", "neutrosophic"]

# Build configuration matrix
target "images" {
  name = item.name
  dockerfile = "docker/neutrosophic.Dockerfile"
  platforms = ["linux/amd64", "linux/arm64"]
  matrix = {
    item = [
      {
        name = "base"
        target = ""
      },
      {
        name = "dev" 
        target = "dev"
      },
      {
        name = "neutrosophic"
        target = "neutrosophic"
      },
      {
        name = "cloud"
        target = "cloud" 
      }
    ]
  }
  tags = [
    "neutrosophic:${VERSION}-${item.name}",
    "neutrosophic:${item.name}"
  ]
}