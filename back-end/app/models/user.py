"""
User model for database operations.
"""
import sys
import os
sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__)))))

from datetime import datetime
from typing import Optional, Dict, Any
from bson import ObjectId
from app.database import database_manager
from app.utils.auth_utils import hash_password, check_password

class User:
    """User model class for handling user operations."""
    
    def __init__(self):
        self.collection = None
        self._ensure_collection()
    
    def _ensure_collection(self):
        """Ensure the users collection is available."""
        db = database_manager.get_database()
        if db is not None:
            self.collection = db.users
    
    def create_user(self, user_data: Dict[str, Any]) -> Optional[str]:
        """
        Create a new user.
        
        Args:
            user_data (dict): User data containing name, email, password, etc.
            
        Returns:
            str: User ID if successful, None otherwise
        """
        try:
            if self.collection is None:
                raise Exception("Database not connected")
            
            # Check if user already exists
            if self.find_by_email(user_data['email']):
                raise Exception("User with this email already exists")
            
            # Hash password
            hashed_password = hash_password(user_data['password'])
            
            # Create user document
            user_doc = {
                'name': user_data['name'],
                'email': user_data['email'].lower(),
                'password': hashed_password,
                'phone': user_data.get('phone', ''),
                'address': user_data.get('address', ''),
                'nic': user_data.get('nic', ''),
                'role': user_data.get('role', 'citizen'),
                'created_at': datetime.utcnow(),
                'updated_at': datetime.utcnow()
            }
            
            # Insert user
            result = self.collection.insert_one(user_doc)
            
            print(f"✅ User created: {user_data['email']}")
            return str(result.inserted_id)
            
        except Exception as e:
            print(f"❌ User creation failed: {e}")
            raise e
    
    def find_by_email(self, email: str) -> Optional[Dict[str, Any]]:
        """
        Find user by email.
        
        Args:
            email (str): User email
            
        Returns:
            dict: User document or None if not found
        """
        try:
            if self.collection is None:
                return None
            
            return self.collection.find_one({'email': email.lower()})
            
        except Exception as e:
            print(f"❌ User lookup failed: {e}")
            return None
    
    def find_by_id(self, user_id: str) -> Optional[Dict[str, Any]]:
        """
        Find user by ID.
        
        Args:
            user_id (str): User ID
            
        Returns:
            dict: User document or None if not found
        """
        try:
            if self.collection is None:
                return None
            
            return self.collection.find_one({'_id': ObjectId(user_id)})
            
        except Exception as e:
            print(f"❌ User lookup failed: {e}")
            return None
    
    def authenticate_user(self, email: str, password: str) -> Optional[Dict[str, Any]]:
        """
        Authenticate user by email and password.
        
        Args:
            email (str): User email
            password (str): Plain text password
            
        Returns:
            dict: User document (without password) or None if authentication fails
        """
        try:
            # Find user
            user = self.find_by_email(email)
            
            if user is None:
                return None
            
            # Check password
            if not check_password(password, user['password']):
                return None
            
            # Remove password from response
            user.pop('password', None)
            
            print(f"✅ User authenticated: {email}")
            return user
            
        except Exception as e:
            print(f"❌ User authentication failed: {e}")
            return None
    
    def to_dict(self, user_doc: Dict[str, Any], include_password: bool = False) -> Dict[str, Any]:
        """
        Convert user document to dictionary for API response.
        
        Args:
            user_doc (dict): User document from database
            include_password (bool): Whether to include password (default: False)
            
        Returns:
            dict: Formatted user data
        """
        if not user_doc:
            return {}
        
        result = {
            'id': str(user_doc['_id']),
            'name': user_doc['name'],
            'email': user_doc['email'],
            'phone': user_doc.get('phone', ''),
            'address': user_doc.get('address', ''),
            'nic': user_doc.get('nic', ''),
            'role': user_doc.get('role', 'citizen'),
            'created_at': user_doc.get('created_at').isoformat() if user_doc.get('created_at') else None,
            'updated_at': user_doc.get('updated_at').isoformat() if user_doc.get('updated_at') else None
        }
        
        if include_password and 'password' in user_doc:
            result['password'] = user_doc['password']
        
        return result

# Global user model instance
user_model = User()
