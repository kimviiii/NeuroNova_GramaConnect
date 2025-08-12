"""
Basic routes for health checks and testing.
"""
import sys
import os
sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__)))))

from flask import Blueprint, jsonify
from app.database import database_manager

# Create blueprint
main_bp = Blueprint('main', __name__)

@main_bp.route('/')
def hello_world():
    """Hello world endpoint with database status."""
    db_status = 'connected' if database_manager.is_connected() else 'disconnected'
    
    return jsonify({
        'message': 'Hello World from GramaConnect Backend!',
        'status': 'success',
        'database': db_status,
        'version': '2.0.0'
    })

@main_bp.route('/health')
def health_check():
    """Health check endpoint."""
    db_status = 'connected' if database_manager.is_connected() else 'disconnected'
    
    return jsonify({
        'message': 'Backend is running!',
        'status': 'healthy',
        'database': db_status,
        'version': '2.0.0'
    })

@main_bp.route('/api/test-db')
def test_database():
    """Test database connection with read/write operation."""
    if not database_manager.is_connected():
        return jsonify({'error': 'Database not connected'}), 500
    
    try:
        db = database_manager.get_database()
        
        # Insert a test document
        test_collection = db.test_collection
        test_doc = {
            'message': 'Hello from MongoDB!', 
            'type': 'test',
            'timestamp': '2025-08-12'
        }
        result = test_collection.insert_one(test_doc)
        
        # Retrieve the document
        retrieved_doc = test_collection.find_one({'_id': result.inserted_id})
        
        # Convert ObjectId to string for JSON response
        retrieved_doc['_id'] = str(retrieved_doc['_id'])
        
        return jsonify({
            'status': 'success',
            'message': 'Database test successful!',
            'inserted_doc': retrieved_doc
        })
        
    except Exception as e:
        return jsonify({'error': f'Database test failed: {str(e)}'}), 500
