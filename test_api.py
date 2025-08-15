import requests
import json

try:
    # Test the API endpoint
    response = requests.post(
        'http://127.0.0.1:5000/api/auth/login',
        json={'email': 'test@test.com', 'password': 'test123'},
        timeout=5
    )
    print(f"Status Code: {response.status_code}")
    print(f"Response: {response.text}")
except requests.exceptions.ConnectionError:
    print("❌ Connection Error: Backend server is not running or not accessible")
except requests.exceptions.Timeout:
    print("❌ Timeout Error: Backend server is taking too long to respond")
except Exception as e:
    print(f"❌ Error: {e}")
