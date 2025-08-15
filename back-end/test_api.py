"""
Simple test script to check our backend endpoints.
This script tests the marriage certificate endpoint.
"""
import requests
import json

# Base URL for our API
BASE_URL = "http://127.0.0.1:5001"

def test_health():
    """Test the health endpoint."""
    try:
        response = requests.get(f"{BASE_URL}/health", timeout=5)
        print("🧪 Testing Health Endpoint:")
        print(f"Status Code: {response.status_code}")
        print(f"Response: {response.json()}")
        print("✅ Health endpoint working!\n")
        return True
    except Exception as e:
        print(f"❌ Health endpoint failed: {e}\n")
        return False

def test_register_user():
    """Test user registration to get a token for testing."""
    try:
        user_data = {
            "name": "Test User",
            "email": "test@example.com",
            "password": "password123",
            "phone": "0771234567",
            "address": "123 Test Street, Colombo",
            "nic": "123456789V"
        }
        
        response = requests.post(f"{BASE_URL}/api/auth/register", json=user_data, timeout=5)
        print("🧪 Testing User Registration:")
        print(f"Status Code: {response.status_code}")
        print(f"Response: {response.json()}")
        
        if response.status_code == 201:
            print("✅ User registration working!\n")
            return response.json().get('token')
        else:
            print("ℹ️ User might already exist, trying login...\n")
            return None
            
    except Exception as e:
        print(f"❌ Registration failed: {e}\n")
        return None

def test_login_user():
    """Test user login to get a token."""
    try:
        login_data = {
            "email": "test@example.com",
            "password": "password123"
        }
        
        response = requests.post(f"{BASE_URL}/api/auth/login", json=login_data, timeout=5)
        print("🧪 Testing User Login:")
        print(f"Status Code: {response.status_code}")
        print(f"Response: {response.json()}")
        
        if response.status_code == 200:
            token = response.json().get('token')
            print("✅ User login working!\n")
            return token
        else:
            print("❌ Login failed!\n")
            return None
            
    except Exception as e:
        print(f"❌ Login failed: {e}\n")
        return None

def test_marriage_certificate(token):
    """Test the marriage certificate endpoint."""
    if not token:
        print("❌ No token available for testing marriage certificate\n")
        return False
        
    try:
        marriage_data = {
            "groom_name": "John Doe",
            "bride_name": "Jane Smith",
            "marriage_date": "2024-01-15",
            "marriage_place": "Colombo",
            "groom_nic": "123456789V",
            "bride_nic": "987654321V"
        }
        
        headers = {
            "Authorization": f"Bearer {token}",
            "Content-Type": "application/json"
        }
        
        response = requests.post(f"{BASE_URL}/api/services/marriage-certificate", 
                               json=marriage_data, headers=headers, timeout=5)
        
        print("🧪 Testing Marriage Certificate Endpoint:")
        print(f"Status Code: {response.status_code}")
        print(f"Response: {response.json()}")
        
        if response.status_code == 201:
            print("✅ Marriage certificate endpoint working!\n")
            return True
        else:
            print("❌ Marriage certificate endpoint failed!\n")
            return False
            
    except Exception as e:
        print(f"❌ Marriage certificate test failed: {e}\n")
        return False

def main():
    """Run all tests."""
    print("🚀 Starting Backend API Tests...\n")
    
    # Test 1: Health check
    if not test_health():
        print("❌ Server is not responding. Make sure backend is running on port 5001")
        return
    
    # Test 2: Try to register a user (or use existing)
    token = test_register_user()
    
    # Test 3: If registration failed, try login
    if not token:
        token = test_login_user()
    
    # Test 4: Test marriage certificate endpoint
    if token:
        test_marriage_certificate(token)
    else:
        print("❌ Could not get authentication token. Cannot test protected endpoints.")
    
    print("🏁 Tests completed!")

if __name__ == "__main__":
    main()
