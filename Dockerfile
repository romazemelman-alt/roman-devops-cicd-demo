# Stage 1: Build dependencies
FROM python:3.11-slim AS builder
WORKDIR /app
COPY src/requirements.txt .
RUN pip install --no-cache-dir --user -r requirements.txt

# Stage 2: Final minimal execution runner
FROM python:3.11-slim AS runner
WORKDIR /app

# Explicitly pull the Build Argument from the pipeline (--build-arg APP_VERSION=...)
ARG APP_VERSION
# Bake it into the container environment variables
ENV APP_VERSION=${APP_VERSION}

# Copy installed dependencies from the builder stage
COPY --from=builder /root/.local /root/.local
COPY src/ ./src/

# Update PATH to prioritize local pip installations
ENV PATH=/root/.local/bin:$PATH

CMD ["python", "src/hello_world.py"]