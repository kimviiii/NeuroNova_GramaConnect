# 🔧 GramaConnect Backend

<div align="center">
  
  ![Flask](https://img.shields.io/badge/Flask-000000?style=for-the-badge&logo=flask&logoColor=white)
  ![MongoDB](https://img.shields.io/badge/MongoDB-4EA94B?style=for-the-badge&logo=mongodb&logoColor=white)
  ![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white)
  
</div>

The backend for GramaConnect, built with Flask and MongoDB, providing a robust API for the Grama Niladhari certificate application system.

## 📚 API Endpoints

### Authentication
- `POST /api/auth/register` - Register new user
- `POST /api/auth/login` - User login
  
### Applications
- `POST /api/applications` - Submit new application
- `GET /api/applications` - Get user's applications
- `GET /api/applications/:id` - Get application details

### Grama Niladhari
- `GET /api/gn/applications` - Get applications for GN
- `PUT /api/gn/applications/:id` - Update application status

## ⚙️ Development Setup

### With Docker (Recommended)

Follow the instructions in the main README to run with Docker.

### Local Development

1. **Create a virtual environment**:
   ```bash
   python -m venv venv
   source venv/bin/activate  # On Windows: venv\Scripts\activate

2. **Install dependencies**:
   pip install -r requirements.txt

3. **Set up environment variables**:
# Create a .env file with:
   MONGODB_URI=mongodb://localhost:27017/gramaconnect
   JWT_SECRET_KEY=your_secret_key

4. **Import the database (if MongoDB is installed locally)**:
   mongorestore --db gramaconnect /path/to/database_dump/gramaconnect

5. **Run the development server**:
   python app.py

## 🧪 Testing
pytest

## 📦 API Response Examples

### User Registration Response
{
  "success": true,
  "message": "User registered successfully",
  "user": {
    "id": "60d21b4667d0d8992e610c85",
    "name": "John Doe",
    "email": "john.doe@example.com",
    "nic": "982750163V",
    "role": "citizen",
    "created_at": "2025-08-16T07:30:22Z"
  }
}

### User Login Response
{
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "user": {
    "id": "60d21b4667d0d8992e610c85",
    "name": "John Doe",
    "role": "citizen"
  }
}

### Submit Application Response
{
  "success": true,
  "message": "Application submitted successfully",
  "application": {
    "id": "60d21c5067d0d8992e610c86",
    "type": "ADDRESS_VERIFICATION",
    "status": "PENDING",
    "user_id": "60d21b4667d0d8992e610c85",
    "created_at": "2025-08-16T07:31:15Z",
    "reference_number": "GC-20250816-12345"
  }
}

### Get Applications Response
{
  "applications": [
    {
      "id": "60d21c5067d0d8992e610c86",
      "type": "ADDRESS_VERIFICATION",
      "status": "PENDING",
      "created_at": "2025-08-16T07:31:15Z",
      "reference_number": "GC-20250816-12345"
    },
    {
      "id": "60d31d6067d0d8992e610c87",
      "type": "CHARACTER_CERTIFICATE",
      "status": "APPROVED",
      "created_at": "2025-08-15T14:22:30Z",
      "reference_number": "GC-20250815-54321"
    }
  ],
  "count": 2
}

### Get Application Details Response
{
  "application": {
    "id": "60d21c5067d0d8992e610c86",
    "type": "ADDRESS_VERIFICATION",
    "status": "PENDING",
    "user_id": "60d21b4667d0d8992e610c85",
    "created_at": "2025-08-16T07:31:15Z",
    "updated_at": "2025-08-16T07:31:15Z",
    "reference_number": "GC-20250816-12345",
    "applicant": {
      "name": "John Doe",
      "nic": "982750163V",
      "address": "123 Main St, Colombo 05",
      "contact_number": "+94771234567"
    },
    "grama_niladhari": {
      "id": "60d21a3067d0d8992e610c84",
      "name": "Saman Perera",
      "division": "Colombo 05 East"
    },
    "status_history": [
      {
        "status": "PENDING",
        "timestamp": "2025-08-16T07:31:15Z",
        "comment": "Application received"
      }
    ]
  }
}

### Update Application Status Response
{
  "success": true,
  "message": "Application status updated successfully",
  "application": {
    "id": "60d21c5067d0d8992e610c86",
    "status": "IN_PROGRESS",
    "updated_at": "2025-08-16T07:32:47Z",
    "status_history": [
      {
        "status": "PENDING",
        "timestamp": "2025-08-16T07:31:15Z",
        "comment": "Application received"
      },
      {
        "status": "IN_PROGRESS",
        "timestamp": "2025-08-16T07:32:47Z",
        "comment": "Document verification started"
      }
    ]
  }
}






