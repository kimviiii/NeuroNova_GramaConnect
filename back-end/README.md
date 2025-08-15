# 🏛️ GramaConnect Backend API

> *Powering Sri Lankan government services with modern technology* ✨

Welcome to the **GramaConnect Backend** - a Flask-powered API that serves as the digital bridge between citizens and their local government services! 🌟

## 🚀 Quick Start Guide

### Prerequisites 📋
- Python 3.8+ 🐍
- pip package manager 📦
- A cup of tea ☕ (optional but recommended)

### Setup Instructions 🛠️

1. **Navigate to the back-end directory:**
   ```bash
   cd back-end
   ```

2. **Create a virtual environment:**
   ```bash
   python -m venv venv
   ```

3. **Activate your virtual environment:**
   ```bash
   # Windows 🪟
   venv\Scripts\activate
   
   # Mac/Linux 🐧
   source venv/bin/activate
   ```

4. **Install all the magical dependencies:**
   ```bash
   pip install -r requirements.txt
   ```

5. **Launch the server:** 🚀
   ```bash
   python app.py
   ```

## 🎯 API Endpoints

### Core Endpoints
- `GET /` - Welcome message 👋
- `GET /health` - Server health check 💚

### Authentication 🔐
- `POST /api/auth/login` - User login
- `POST /api/auth/register` - New user registration

### Government Services 📄
- `POST /api/services/marriage-certificate` - Marriage certificate application
- `POST /api/services/character-certificate` - Character certificate application
- `POST /api/services/voter-registration` - Voter registration application
- `GET /api/services/applications` - User's application history

### Grama Niladhari Directory 👥
- `GET /api/grama-niladhari/district/{district}` - Get officials by district
- `GET /api/grama-niladhari/search` - Search officials

### Community Features 🏘️
- `GET /announcements` - Public announcements
- `POST /complaints` - Submit complaints
- `GET /complaints/user/{userId}` - User's complaint history

## 🌐 Server Information

**Default URL:** `http://localhost:5000` 🏠

**CORS Enabled:** Ready for cross-origin requests from your Flutter app! 📱

## 🎨 Features

- **Multi-language Support** 🌍 (Sinhala, Tamil, English)
- **JWT Authentication** 🔒 
- **RESTful API Design** 📐
- **Error Handling** ⚠️
- **Input Validation** ✅

## 🔧 Development Tips

- Use `python run.py` for development mode with auto-reload
- Check `debug_routes.py` for testing endpoints
- API responses include helpful error messages 💡

## 📁 Project Structure

```
back-end/
├── app/                 # Application modules
│   ├── models/         # Database models
│   ├── routes/         # API route handlers
│   └── utils/          # Helper utilities
├── config/             # Configuration files
├── app.py              # Main application entry
└── requirements.txt    # Python dependencies
```

---

*Made with ❤️ for the people of Sri Lanka* 🇱🇰
