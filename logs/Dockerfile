FROM python:3.12-slim

# Set working directory
WORKDIR /app

RUN apt-get update && \
    apt-get install -y --no-install-recommends gcc python3-dev libpq-dev postgresql-client && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 8082

# Default command to run the app (change as needed)
CMD ["python", "log-service.py"]
