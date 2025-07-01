FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Build arguments to allow UID/GID mapping
ARG UID=1000
ARG GID=1000

# Install dependencies and create non-root user
RUN apt-get update && apt-get install -y \
    curl \
    bash \
    && addgroup --gid $GID appuser \
    && adduser --disabled-password --gecos '' --uid $UID --gid $GID appuser

# Install Python packages
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the project
COPY . .

# Set execute permission on entrypoint while still root
RUN chmod +x /app/entrypoint.sh

# Switch to non-root user
USER appuser

# Define Django settings explicitly
ENV DJANGO_SETTINGS_MODULE=mysite.settings

# Entrypoint script waits for Vue build, then starts Django
ENTRYPOINT ["/app/entrypoint.sh"]

