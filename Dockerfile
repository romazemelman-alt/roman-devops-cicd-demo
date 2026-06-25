FROM python:3.11-slim

WORKDIR /app

# Pull the Build Argument from the pipeline (--build-arg APP_VERSION=...)
ARG APP_VERSION
ENV APP_VERSION=${APP_VERSION}

# Copy the source code directly
COPY src/ ./src/

# Run the script
CMD ["python", "src/hello_world.py"]