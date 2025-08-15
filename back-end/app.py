from flask import Flask, jsonify, request
from flask_cors import CORS
from pymongo import MongoClient
from dotenv import load_dotenv
import os
import bcrypt
import jwt
from datetime import datetime, timedelta

# Load environment variables from .env file
load_dotenv()

# Create Flask app instance
app = Flask(__name__)

# Enable CORS for all routes (allows Flutter to call this API)
CORS(app)

# MongoDB connection
try:
    # Get MongoDB URI from environment variables
    mongodb_uri = os.getenv('MONGODB_URI')
    database_name = os.getenv('DATABASE_NAME', 'gramaconnect')
    
    print(f"🔍 Debug: MongoDB URI loaded: {mongodb_uri is not None}")
    print(f"🔍 Debug: Database name: {database_name}")
    
    # Create MongoDB client
    client = MongoClient(mongodb_uri, serverSelectionTimeoutMS=5000)
    
    # Get database
    db = client[database_name]
    
    # Test connection
    client.admin.command('ping')
    print("✅ Connected to MongoDB Atlas successfully!")
    
except Exception as e:
    print(f"❌ MongoDB connection failed: {e}")
    db = None

# Basic route - Hello World
@app.route('/')
def hello_world():
    # Check database connection
    db_status = 'disconnected'
    try:
        if db is not None:
            # Test if we can actually use the database
            db.command('ping')
            db_status = 'connected'
    except:
        db_status = 'disconnected'
    
    return jsonify({
        'message': 'Hello World from GramaConnect Backend!', 
        'status': 'success',
        'database': db_status
    })

# Health check route
@app.route('/health')
def health_check():
    # Check database connection
    db_status = 'disconnected'
    try:
        if db is not None:
            # Test if we can actually use the database
            db.command('ping')
            db_status = 'connected'
    except:
        db_status = 'disconnected'
    
    return jsonify({
        'message': 'Backend is running!', 
        'status': 'healthy',
        'database': db_status
    })

# Test MongoDB connection route
@app.route('/api/test-db')
def test_database():
    if db is None:
        return jsonify({'error': 'Database not connected'}), 500
    
    try:
        # Insert a test document
        test_collection = db.test_collection
        test_doc = {'message': 'Hello from MongoDB!', 'type': 'test'}
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

# Helper function to generate JWT token
def generate_token(user_id):
    try:
        payload = {
            'user_id': str(user_id),
            'exp': datetime.utcnow() + timedelta(days=7)  # Token expires in 7 days
        }
        secret_key = os.getenv('SECRET_KEY', 'your-secret-key-gramaconnect-2025')
        return jwt.encode(payload, secret_key, algorithm='HS256')
    except Exception as e:
        return None

# Helper function to hash password
def hash_password(password):
    return bcrypt.hashpw(password.encode('utf-8'), bcrypt.gensalt())

# Helper function to check password
def check_password(password, hashed):
    return bcrypt.checkpw(password.encode('utf-8'), hashed)

# User Registration Endpoint
@app.route('/api/auth/register', methods=['POST'])
def register():
    if db is None:
        return jsonify({'error': 'Database not connected'}), 500
    
    try:
        # Get request data
        data = request.get_json()
        
        # Validate required fields
        if not data or not data.get('name') or not data.get('email') or not data.get('password'):
            return jsonify({'error': 'Name, email, and password are required'}), 400
        
        name = data.get('name').strip()
        email = data.get('email').strip().lower()
        password = data.get('password')
        phone = data.get('phone', '').strip()
        address = data.get('address', '').strip()
        nic = data.get('nic', '').strip()
        
        # Check if user already exists
        users_collection = db.users
        if users_collection.find_one({'email': email}):
            return jsonify({'error': 'User with this email already exists'}), 409
        
        # Hash password
        hashed_password = hash_password(password)
        
        # Create user document
        user_doc = {
            'name': name,
            'email': email,
            'password': hashed_password,
            'phone': phone,
            'address': address,
            'nic': nic,
            'role': 'citizen',
            'created_at': datetime.utcnow()
        }
        
        # Insert user into database
        result = users_collection.insert_one(user_doc)
        
        # Generate JWT token
        token = generate_token(result.inserted_id)
        
        # Return user data (without password)
        user_response = {
            'id': str(result.inserted_id),
            'name': name,
            'email': email,
            'phone': phone,
            'address': address,
            'nic': nic,
            'role': 'citizen',
            'created_at': user_doc['created_at'].isoformat()
        }
        
        return jsonify({
            'message': 'User registered successfully',
            'user': user_response,
            'token': token
        }), 201
        
    except Exception as e:
        return jsonify({'error': f'Registration failed: {str(e)}'}), 500

# User Login Endpoint
@app.route('/api/auth/login', methods=['POST'])
def login():
    if db is None:
        return jsonify({'error': 'Database not connected'}), 500
    
    try:
        # Get request data
        data = request.get_json()
        
        # Validate required fields
        if not data or not data.get('email') or not data.get('password'):
            return jsonify({'error': 'Email and password are required'}), 400
        
        email = data.get('email').strip().lower()
        password = data.get('password')
        
        # Find user in database
        users_collection = db.users
        user = users_collection.find_one({'email': email})
        
        if not user or not check_password(password, user['password']):
            return jsonify({'error': 'Invalid email or password'}), 401
        
        # Generate JWT token
        token = generate_token(user['_id'])
        
        # Return user data (without password)
        user_response = {
            'id': str(user['_id']),
            'name': user['name'],
            'email': user['email'],
            'phone': user.get('phone', ''),
            'address': user.get('address', ''),
            'nic': user.get('nic', ''),
            'role': user.get('role', 'citizen'),
            'created_at': user['created_at'].isoformat() if user.get('created_at') else None
        }
        
        return jsonify({
            'message': 'Login successful',
            'user': user_response,
            'token': token
        }), 200
        
    except Exception as e:
        return jsonify({'error': f'Login failed: {str(e)}'}), 500

# Helper function to verify JWT token
def verify_token(token):
    try:
        secret_key = os.getenv('SECRET_KEY', 'your-secret-key-gramaconnect-2025')
        payload = jwt.decode(token, secret_key, algorithms=['HS256'])
        return payload.get('user_id')
    except jwt.ExpiredSignatureError:
        return None
    except jwt.InvalidTokenError:
        return None

# Marriage Certificate Service Endpoint
@app.route('/api/services/marriage-certificate', methods=['POST'])
def submit_marriage_certificate():
    if db is None:
        return jsonify({'error': 'Database not connected'}), 500
    
    try:
        # Get authorization header
        auth_header = request.headers.get('Authorization')
        if not auth_header or not auth_header.startswith('Bearer '):
            return jsonify({'error': 'Authorization token required'}), 401
        
        # Extract token
        token = auth_header.split(' ')[1]
        user_id = verify_token(token)
        
        if not user_id:
            return jsonify({'error': 'Invalid or expired token'}), 401
        
        # Get request data
        data = request.get_json()
        
        # Validate required fields
        required_fields = [
            'applicantName', 'spouseName', 'marriageDate', 
            'marriagePlace', 'applicantNIC', 'spouseNIC'
        ]
        
        for field in required_fields:
            if not data or not data.get(field):
                return jsonify({'error': f'{field} is required'}), 400
        
        # Create application document
        application_doc = {
            'user_id': user_id,
            'service_type': 'marriage_certificate',
            'applicant_name': data.get('applicantName').strip(),
            'spouse_name': data.get('spouseName').strip(),
            'marriage_date': data.get('marriageDate'),
            'marriage_place': data.get('marriagePlace').strip(),
            'applicant_nic': data.get('applicantNIC').strip(),
            'spouse_nic': data.get('spouseNIC').strip(),
            'contact_number': data.get('contactNumber', '').strip(),
            'address': data.get('address', '').strip(),
            'status': 'pending',
            'created_at': datetime.utcnow(),
            'updated_at': datetime.utcnow()
        }
        
        # Insert application into database
        applications_collection = db.applications
        result = applications_collection.insert_one(application_doc)
        
        # Return success response
        return jsonify({
            'message': 'Marriage certificate application submitted successfully',
            'application_id': str(result.inserted_id),
            'status': 'pending'
        }), 201
        
    except Exception as e:
        return jsonify({'error': f'Marriage certificate application failed: {str(e)}'}), 500

# Get Applications Endpoint (for user to view their applications)
@app.route('/api/applications', methods=['GET'])
def get_applications():
    if db is None:
        return jsonify({'error': 'Database not connected'}), 500
    
    try:
        # Get authorization header
        auth_header = request.headers.get('Authorization')
        if not auth_header or not auth_header.startswith('Bearer '):
            return jsonify({'error': 'Authorization token required'}), 401
        
        # Extract token
        token = auth_header.split(' ')[1]
        user_id = verify_token(token)
        
        if not user_id:
            return jsonify({'error': 'Invalid or expired token'}), 401
        
        # Get user's applications
        applications_collection = db.applications
        applications = list(applications_collection.find({'user_id': user_id}))
        
        # Convert ObjectIds to strings
        for app in applications:
            app['_id'] = str(app['_id'])
            if app.get('created_at'):
                app['created_at'] = app['created_at'].isoformat()
            if app.get('updated_at'):
                app['updated_at'] = app['updated_at'].isoformat()
        
        return jsonify({
            'message': 'Applications retrieved successfully',
            'applications': applications
        }), 200
        
    except Exception as e:
        return jsonify({'error': f'Failed to retrieve applications: {str(e)}'}), 500

# Character Certificate Service Endpoint
@app.route('/api/services/character-certificate', methods=['POST'])
def submit_character_certificate():
    if db is None:
        return jsonify({'error': 'Database not connected'}), 500
    
    try:
        # Get authorization header
        auth_header = request.headers.get('Authorization')
        if not auth_header or not auth_header.startswith('Bearer '):
            return jsonify({'error': 'Authorization token required'}), 401
        
        # Extract token
        token = auth_header.split(' ')[1]
        user_id = verify_token(token)
        
        if not user_id:
            return jsonify({'error': 'Invalid or expired token'}), 401
        
        # Get request data
        data = request.get_json()
        
        # Validate required fields
        required_fields = [
            'applicantName', 'nicNumber', 'purpose'
        ]
        
        for field in required_fields:
            if not data or not data.get(field):
                return jsonify({'error': f'{field} is required'}), 400
        
        # Create application document
        application_doc = {
            'user_id': user_id,
            'service_type': 'character_certificate',
            'applicant_name': data.get('applicantName').strip(),
            'nic_number': data.get('nicNumber').strip(),
            'purpose': data.get('purpose').strip(),
            'employment_details': data.get('employmentDetails', '').strip(),
            'residence_address': data.get('residenceAddress', '').strip(),
            'contact_number': data.get('contactNumber', '').strip(),
            'period_of_residence': data.get('periodOfResidence', '').strip(),
            'previous_residences': data.get('previousResidences', []),
            'references': data.get('references', []),
            'status': 'pending',
            'created_at': datetime.utcnow(),
            'updated_at': datetime.utcnow(),
            'reference_number': f"CC{datetime.utcnow().strftime('%Y%m%d%H%M%S')}"
        }
        
        # Insert application into database
        applications_collection = db.applications
        result = applications_collection.insert_one(application_doc)
        
        # Return success response
        return jsonify({
            'message': 'Character certificate application submitted successfully',
            'application_id': str(result.inserted_id),
            'reference_number': application_doc['reference_number'],
            'status': 'pending',
            'estimated_processing_time': '14-21 working days'
        }), 201
        
    except Exception as e:
        return jsonify({'error': f'Character certificate application failed: {str(e)}'}), 500

# Run the app
if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)