 
#!/bin/bash

# Create the docker container for PostgreSQL
docker run --name exercise-postgres -e POSTGRES_PASSWORD=123456 -p 5432:5432 -d postgres

# Check if the container is running successfully
docker ps | grep exercise-postgres >/dev/null 2>&1

if [ $? -eq 0 ]; then
  echo "PostgreSQL container 'exercise-postgres' started successfully."
else
  echo "Error: Failed to start the PostgreSQL container."
fi
