# Use Python 3.9 as the base image
FROM python:3.9-slim

# Set working directory in the container
WORKDIR /app

# Copy requirements file first (for better caching)
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application code (excluding .env file)
COPY . .

# Make sure .env isn't included in the image
RUN rm -f .env || true

# Expose the port the app runs on
EXPOSE 5000

# Command to run the application
CMD ["python", "app.py"]