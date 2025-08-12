"""
Authentication routes for user registration and login.
"""
import sys
import os
sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__)))))

from flask import Blueprint, request, jsonify
from app.models.user import user_model
from app.utils.auth_utils import generate_jwt_token

# Create blueprint
auth_bp = Blueprint('auth', __name__, url_prefix='/api/auth')

@auth_bp.route('/register', methods=['POST'])
def register():
    """User registration endpoint."""
    try:
        # Get request data
        data = request.get_json()
        
        # Validate required fields
        if not data or not data.get('name') or not data.get('email') or not data.get('password'):
            return jsonify({'error': 'Name, email, and password are required'}), 400
        
        # Prepare user data
        user_data = {
            'name': data.get('name').strip(),
            'email': data.get('email').strip().lower(),
            'password': data.get('password'),
            'phone': data.get('phone', '').strip(),
            'address': data.get('address', '').strip(),
            'nic': data.get('nic', '').strip()
        }
        
        # Create user
        user_id = user_model.create_user(user_data)
        
        if not user_id:
            return jsonify({'error': 'User registration failed'}), 500
        
        # Get created user (without password)
        created_user = user_model.find_by_id(user_id)
        user_response = user_model.to_dict(created_user)
        
        # Generate JWT token
        token = generate_jwt_token(user_id)
        
        return jsonify({
            'message': 'User registered successfully',
            'user': user_response,
            'token': token
        }), 201
        
    except Exception as e:
        return jsonify({'error': f'Registration failed: {str(e)}'}), 500

@auth_bp.route('/login', methods=['POST'])
def login():
    """User login endpoint."""
    try:
        # Get request data
        data = request.get_json()
        
        # Validate required fields
        if not data or not data.get('email') or not data.get('password'):
            return jsonify({'error': 'Email and password are required'}), 400
        
        email = data.get('email').strip().lower()
        password = data.get('password')
        
        # Authenticate user
        user = user_model.authenticate_user(email, password)
        
        if not user:
            return jsonify({'error': 'Invalid email or password'}), 401
        
        # Convert to response format
        user_response = user_model.to_dict(user)
        
        # Generate JWT token
        token = generate_jwt_token(user_response['id'])
        
        return jsonify({
            'message': 'Login successful',
            'user': user_response,
            'token': token
        }), 200
        
    except Exception as e:
        return jsonify({'error': f'Login failed: {str(e)}'}), 500
