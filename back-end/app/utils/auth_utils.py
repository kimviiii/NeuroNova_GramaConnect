"""
Authentication utility functions.
"""
import jwt
import bcrypt
from datetime import datetime, timedelta
from functools import wraps
from flask import request, jsonify, g
from config.config import Config
from app.database import database_manager
from bson import ObjectId

def hash_password(password: str) -> bytes:
    """
    Hash a password using bcrypt.
    
    Args:
        password (str): Plain text password
        
    Returns:
        bytes: Hashed password
    """
    return bcrypt.hashpw(password.encode('utf-8'), bcrypt.gensalt())

def check_password(password: str, hashed: bytes) -> bool:
    """
    Check if password matches hash.
    
    Args:
        password (str): Plain text password
        hashed (bytes): Hashed password
        
    Returns:
        bool: True if password matches, False otherwise
    """
    return bcrypt.checkpw(password.encode('utf-8'), hashed)

def generate_jwt_token(user_id: str) -> str:
    """
    Generate JWT token for user.
    
    Args:
        user_id (str): User ID
        
    Returns:
        str: JWT token or None if failed
    """
    try:
        payload = {
            'user_id': str(user_id),
            'exp': datetime.utcnow() + timedelta(days=Config.JWT_EXPIRATION_DAYS),
            'iat': datetime.utcnow()
        }
        
        return jwt.encode(payload, Config.SECRET_KEY, algorithm='HS256')
    except Exception as e:
        print(f"❌ Token generation failed: {e}")
        return None

def decode_jwt_token(token: str) -> dict:
    """
    Decode and validate JWT token.
    
    Args:
        token (str): JWT token
        
    Returns:
        dict: Decoded payload or None if invalid
    """
    try:
        payload = jwt.decode(token, Config.SECRET_KEY, algorithms=['HS256'])
        return payload
    except jwt.ExpiredSignatureError:
        print("❌ Token expired")
        return None
    except jwt.InvalidTokenError:
        print("❌ Invalid token")
        return None

def jwt_required(f):
    """
    Decorator to protect routes that require authentication.
    
    Usage:
        @jwt_required
        def protected_route():
            user = get_current_user()
            return f"Hello {user['name']}"
    """
    @wraps(f)
    def decorated_function(*args, **kwargs):
        # Get token from Authorization header
        auth_header = request.headers.get('Authorization')
        if not auth_header:
            return jsonify({'error': 'Authorization header is missing'}), 401
        
        try:
            # Extract token from "Bearer <token>"
            token = auth_header.split(' ')[1]
        except IndexError:
            return jsonify({'error': 'Invalid authorization header format'}), 401
        
        # Decode token
        payload = decode_jwt_token(token)
        if not payload:
            return jsonify({'error': 'Invalid or expired token'}), 401
        
        # Store user info in Flask's g object for access in route functions
        g.current_user_id = payload['user_id']
        
        return f(*args, **kwargs)
    
    return decorated_function

def get_current_user():
    """
    Get the current authenticated user from database.
    
    Returns:
        dict: User document from database or None if not found
    """
    try:
        if not hasattr(g, 'current_user_id'):
            return None
        
        if not database_manager.is_connected():
            print("❌ Database not connected")
            return None
        
        db = database_manager.get_database()
        user = db.users.find_one({'_id': ObjectId(g.current_user_id)})
        
        if user:
            # Convert ObjectId to string for JSON serialization
            user['_id'] = str(user['_id'])
        
        return user
        
    except Exception as e:
        print(f"❌ Error getting current user: {e}")
        return None
