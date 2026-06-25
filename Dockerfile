# Multi-stage build for minimal final image size and security
FROM python:3.11-slim AS builder
WORKDIR /app
COPY src/requirements.txt .
RUN pip install --no-cache-dir --user -r requirements.txt

FROM python:3.11-slim AS runner
WORKDIR /app
# Copy installed dependencies from builder stage
COPY --from=builder /root/.local /root/.local
COPY src/ ./src/

ENV PATH=/root/.local/bin:$PATH
ENV APP_VERSION=${APP_VERSION}

CMD ["python", "src/hello_world.py"]