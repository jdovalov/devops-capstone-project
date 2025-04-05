FROM python:3.9-slim

# Set up the software
WORKDIR /app
# Install python requirements
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
# Copy microservice application
COPY service/ ./service/

# Use new user "theia"
RUN useradd --uid 1000 theia && chown -R theia /app
USER theia

# Run the service
EXPOSE 8080
CMD ["gunicorn", "--bind=0.0.0.0:8080", "--log-level=info", "service:app"]