CREATE TABLE IF NOT EXISTS t_VMs (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) UNIQUE,
    image_id INT,
    flavor_id INT,
    status VARCHAR(20) CHECK (status IN ('pending', 'running', 'stopped', 'deleted')),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS t_Images (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) UNIQUE,
  size INT,
  checksum VARCHAR(255),
  description TEXT
);

CREATE TABLE IF NOT EXISTS t_Flavors (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) UNIQUE,
  cpu INT,
  memory INT,
  storage INT
);
