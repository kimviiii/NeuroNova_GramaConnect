"""
Services routes for handling government service applications.
"""
import sys
import os
sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__)))))

from flask import Blueprint, request, jsonify
from datetime import datetime
from app.database import database_manager
from app.utils.auth_utils import jwt_required, get_current_user
from bson import ObjectId

# Create blueprint for services
services_bp = Blueprint('services', __name__)

@services_bp.route('/api/services/marriage-certificate', methods=['POST'])
@jwt_required
def apply_marriage_certificate():
    """Submit marriage certificate application."""
    try:
        current_user = get_current_user()
        if not current_user:
            return jsonify({'error': 'User not authenticated'}), 401
        
        data = request.get_json()
        if not data:
            return jsonify({'error': 'No data provided'}), 400
        
        # Validate required fields
        required_fields = ['groom_name', 'bride_name', 'marriage_date', 'marriage_place', 'groom_nic']
        missing_fields = [field for field in required_fields if not data.get(field)]
        
        if missing_fields:
            return jsonify({'error': f'Missing required fields: {", ".join(missing_fields)}'}), 400
        
        if not database_manager.is_connected():
            return jsonify({'error': 'Database connection failed'}), 500
        
        db = database_manager.get_database()
        
        # Generate reference number
        reference_number = f"MC{datetime.now().strftime('%Y%m%d%H%M%S')}"
        
        # Create application
        application = {
            'user_id': ObjectId(current_user['_id']),
            'service_type': 'marriage_certificate',
            'status': 'pending',
            'application_data': {
                'groom_name': data.get('groom_name'),
                'bride_name': data.get('bride_name'),
                'marriage_date': data.get('marriage_date'),
                'marriage_place': data.get('marriage_place'),
                'groom_nic': data.get('groom_nic'),
                'bride_nic': data.get('bride_nic', ''),
                'witnesses': data.get('witnesses', [])
            },
            'submitted_date': datetime.utcnow(),
            'reference_number': reference_number,
            'notes': ''
        }
        
        result = db.applications.insert_one(application)
        application['_id'] = str(result.inserted_id)
        application['user_id'] = str(application['user_id'])
        
        return jsonify({
            'status': 'success',
            'message': 'Marriage certificate application submitted successfully',
            'application': application
        }), 201
        
    except Exception as e:
        print(f"Error: {str(e)}")
        return jsonify({'error': 'Internal server error'}), 500

@services_bp.route('/api/services/applications', methods=['GET'])
@jwt_required
def get_user_applications():
    """Get all applications for the current user."""
    try:
        current_user = get_current_user()
        if not current_user:
            return jsonify({'error': 'User not authenticated'}), 401
        
        if not database_manager.is_connected():
            return jsonify({'error': 'Database connection failed'}), 500
        
        db = database_manager.get_database()
        
        applications = list(db.applications.find({
            'user_id': ObjectId(current_user['_id'])
        }).sort('submitted_date', -1))
        
        # Convert ObjectIds to strings
        for app in applications:
            app['_id'] = str(app['_id'])
            app['user_id'] = str(app['user_id'])
        
        return jsonify({
            'status': 'success',
            'applications': applications
        }), 200
        
    except Exception as e:
        print(f"Error: {str(e)}")
        return jsonify({'error': 'Internal server error'}), 500

@services_bp.route('/api/services/character-certificate', methods=['POST'])
@jwt_required
def apply_character_certificate():
    """Submit character certificate application."""
    try:
        current_user = get_current_user()
        if not current_user:
            return jsonify({'error': 'User not authenticated'}), 401
        
        data = request.get_json()
        if not data:
            return jsonify({'error': 'No data provided'}), 400
        
        # Validate required fields
        required_fields = ['purpose', 'residence_period']
        missing_fields = [field for field in required_fields if not data.get(field)]
        
        if missing_fields:
            return jsonify({'error': f'Missing required fields: {", ".join(missing_fields)}'}), 400
        
        if not database_manager.is_connected():
            return jsonify({'error': 'Database connection failed'}), 500
        
        db = database_manager.get_database()
        
        # Generate reference number
        reference_number = f"CC{datetime.now().strftime('%Y%m%d%H%M%S')}"
        
        # Create application
        application = {
            'user_id': ObjectId(current_user['_id']),
            'service_type': 'character_certificate',
            'status': 'pending',
            'application_data': {
                'purpose': data.get('purpose'),
                'residence_period': data.get('residence_period'),
                'employment_details': data.get('employment_details', ''),
                'character_references': data.get('character_references', [])
            },
            'submitted_date': datetime.utcnow(),
            'reference_number': reference_number,
            'notes': ''
        }
        
        result = db.applications.insert_one(application)
        application['_id'] = str(result.inserted_id)
        application['user_id'] = str(application['user_id'])
        
        return jsonify({
            'status': 'success',
            'message': 'Character certificate application submitted successfully',
            'application': application
        }), 201
        
    except Exception as e:
        print(f"Error: {str(e)}")
        return jsonify({'error': 'Internal server error'}), 500

@services_bp.route('/api/services/voter-registration', methods=['POST'])
@jwt_required
def apply_voter_registration():
    """Submit voter registration update application."""
    try:
        current_user = get_current_user()
        if not current_user:
            return jsonify({'error': 'User not authenticated'}), 401
        
        data = request.get_json()
        if not data:
            return jsonify({'error': 'No data provided'}), 400
        
        # Validate required fields
        required_fields = ['update_type', 'reason_for_change']
        missing_fields = [field for field in required_fields if not data.get(field)]
        
        if missing_fields:
            return jsonify({'error': f'Missing required fields: {", ".join(missing_fields)}'}), 400
        
        if not database_manager.is_connected():
            return jsonify({'error': 'Database connection failed'}), 500
        
        db = database_manager.get_database()
        
        # Generate reference number
        reference_number = f"VR{datetime.now().strftime('%Y%m%d%H%M%S')}"
        
        # Create application
        application = {
            'user_id': ObjectId(current_user['_id']),
            'service_type': 'voter_registration',
            'status': 'pending',
            'application_data': {
                'update_type': data.get('update_type'),  # 'address_change', 'name_change', 'new_registration'
                'current_address': data.get('current_address', ''),
                'new_address': data.get('new_address', ''),
                'reason_for_change': data.get('reason_for_change'),
                'supporting_documents': data.get('supporting_documents', [])
            },
            'submitted_date': datetime.utcnow(),
            'reference_number': reference_number,
            'notes': ''
        }
        
        result = db.applications.insert_one(application)
        application['_id'] = str(result.inserted_id)
        application['user_id'] = str(application['user_id'])
        
        return jsonify({
            'status': 'success',
            'message': 'Voter registration update submitted successfully',
            'application': application
        }), 201
        
    except Exception as e:
        print(f"Error: {str(e)}")
        return jsonify({'error': 'Internal server error'}), 500
