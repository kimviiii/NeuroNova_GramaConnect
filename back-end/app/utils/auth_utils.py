"""
Authentication utility functions.
"""
import jwt
import bcrypt
from datetime import datetime, timedelta
from config.config import Config

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
