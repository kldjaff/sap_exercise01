# Tables:

## Table Name: VMs
**This table stores the core information about your virtual machines.**

### Columns:
- id (INT PRIMARY KEY): Unique identifier for the VM. (Auto-increment is recommended for ease of use)
- name (VARCHAR(255) UNIQUE): Name of the VM. (Enforce uniqueness to avoid duplicate names)
- image_id (INT FOREIGN KEY REFERENCES Images(id)): Foreign key referencing the Images table (optional, if you store VM images separately)
- flavor_id (INT FOREIGN KEY REFERENCES Flavors(id)): Foreign key referencing the Flavors table (optional, if you define different VM configurations)
- status (ENUM('pending', 'running', 'stopped', 'deleted')): Current state of the VM.
- created_at (DATETIME DEFAULT CURRENT_TIMESTAMP): Timestamp of VM creation. (Automatically populated with the current time)
- updated_at (DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP): Timestamp of VM update. (Automatically updated on modification)

```sql
CREATE TABLE VMs (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) UNIQUE NOT NULL,
  image_id INTEGER REFERENCES Images(id) ON DELETE SET NULL,
  flavor_id INTEGER REFERENCES Flavors(id) ON DELETE SET NULL,
  status ENUM ('pending', 'running', 'stopped', 'deleted') DEFAULT 'pending' NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

```

## Table Name: Images (Optional)
**This table stores information about VM images if you're managing them separately.**

### Columns:
- id (INT PRIMARY KEY): Unique identifier for the VM image. (Auto-increment is recommended)
- name (VARCHAR(255) UNIQUE): Name of the VM image. (Enforce uniqueness to avoid duplicate names)
- size (INT): Size of the image file in bytes.
- checksum (VARCHAR(255)): Checksum of the image file for verification purposes (optional).
- description (TEXT): Description of the VM image (optional).

```sql
CREATE TABLE Images (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) UNIQUE NOT NULL,
  size BIGINT,  -- Use BIGINT for larger image sizes
  checksum VARCHAR(255),
  description TEXT
);
```

## Table Name: Flavors (Optional)
**This table stores information about different VM configurations if you offer pre-defined options.**

### Columns:
- id (INT PRIMARY KEY): Unique identifier for the VM flavor. (Auto-increment is recommended)
- name (VARCHAR(255) UNIQUE): Name of the VM flavor. (Enforce uniqueness to avoid duplicate names)
- cpu (INT): Number of CPU cores allocated to the VM.
- memory (INT): Amount of memory allocated to the VM in MB.
- storage (INT): Amount of storage allocated to the VM in GB.

```sql
CREATE TABLE Flavors (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) UNIQUE NOT NULL,
  cpu INTEGER,
  memory INTEGER,
  storage INTEGER
);
```

# Relationships
- The VMs table has a one-to-many relationship with the Images table (optional). A single VM can be based on one image.
- The VMs table has a one-to-many relationship with the Flavors table (optional). A single VM can have one flavor configuration.