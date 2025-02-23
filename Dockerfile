Dockerfile
# Use official Python image
FROM python:3.9

WORKDIR /app

# Install dependencies
COPY requirements.txt ./
RUN pip install --upgrade pip && \
    pip install --no-cache-dir --no-input -r requirements.txt

# Copy project files
COPY . .

# Expose API port
EXPOSE 9000

# Health check to ensure the API is responsive
HEALTHCHECK --interval=30s --timeout=10s --retries=3 CMD curl --fail http://localhost:9000 || exit 1

# Run FastAPI with explicit host
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "9000", "--proxy-headers", "--forwarded-allow-ips", "*"]
