# 🏡 GramaConnect

<div align="center">
  <h3>Streamlining Grama Niladhari Certificate Applications in Sri Lanka</h3>
  
  ![Flask](https://img.shields.io/badge/Flask-000000?style=for-the-badge&logo=flask&logoColor=white)
  ![MongoDB](https://img.shields.io/badge/MongoDB-4EA94B?style=for-the-badge&logo=mongodb&logoColor=white)
  ![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)
</div>

## 📋 Overview

GramaConnect is a digital platform that streamlines the Grama Niladhari certificate application process in Sri Lanka, making it more accessible, efficient, and transparent for citizens.

## ✨ Features

- 🔐 User registration and authentication
- 📝 Digital application submission for Grama Certificates
- 🔍 Application tracking and status updates
- 📊 Grama Niladhari dashboard for managing applications
- 📱 SMS notifications for status updates

## 🚀 Setup Instructions

### Prerequisites
- Docker and Docker Compose

### Installation Steps

1. **Clone the repository**:
   ```bash
   git clone https://github.com/kimviiii/GramaConnect.git
   cd GramaConnect

2. **Download and Extract the Database**:

Download the database dump: <a href="https://drive.google.com/file/d/1trWZRmY6p7G4oTb6U2G9-T0pB0liViHm/view?usp=sharing" target="_blank">GramaConnect Database Dump</a>
Extract the zip file to create a database_dump folder in the project root directory

3. **Start the Docker Containers**:
docker-compose up -d

4. **Import the Database**:
docker exec -it gramaconnect_mongodb mongorestore /database_dump

5. **Access the Application**:
- The backend API will be available at: http://localhost:5000
- The frontend will be available at: http://localhost:3000 (if applicable)

## 🛠️ Technologies Used
- Backend: Flask (Python)
- Database: MongoDB
- Containerization: Docker
- Authentication: JWT (JSON Web Tokens)

## 📂 Project Structure
GramaConnect/
├── back-end/       # Flask backend API
├── front-end/      # Frontend application (if applicable)
├── database_dump/  # MongoDB database dump (extracted from zip)
└── docker-compose.yml
