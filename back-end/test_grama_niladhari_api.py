"""
Test script for Grama Niladhari API endpoints

This script tests the new Contact Grama Niladhari endpoints
"""

import requests
import json

# Test endpoints
base_url = "http://localhost:5000"

# Test data - you'll need a valid JWT token from login
# For testing, you can get a token by logging in through the app
test_token = "your-jwt-token-here"  # Replace with actual token

headers = {
    "Content-Type": "application/json",
    "Authorization": f"Bearer {test_token}"
}

def test_get_officials_by_district():
    """Test getting officials by district"""
    print("🔍 Testing: Get officials by district")
    
    districts = ["Colombo", "Kandy", "Galle"]
    
    for district in districts:
        try:
            url = f"{base_url}/api/grama-niladhari/district/{district}"
            response = requests.get(url, headers=headers)
            
            print(f"📍 District: {district}")
            print(f"   Status Code: {response.status_code}")
            
            if response.status_code == 200:
                data = response.json()
                print(f"   Officials Count: {data.get('count', 0)}")
                
                if data.get('grama_niladhari_officials'):
                    for official in data['grama_niladhari_officials'][:2]:  # Show first 2
                        print(f"   - {official.get('name')} ({official.get('grama_niladhari_division')})")
            else:
                print(f"   Error: {response.text}")
            print()
            
        except requests.exceptions.RequestException as e:
            print(f"   Network Error: {e}")
            print()

def test_search_officials():
    """Test searching officials"""
    print("🔍 Testing: Search officials")
    
    search_params = [
        {"district": "Colombo", "division": "01"},
        {"district": "Kandy", "name": "Jayasinghe"},
        {"division": "Fort"}
    ]
    
    for params in search_params:
        try:
            url = f"{base_url}/api/grama-niladhari/search"
            response = requests.get(url, headers=headers, params=params)
            
            print(f"🔍 Search params: {params}")
            print(f"   Status Code: {response.status_code}")
            
            if response.status_code == 200:
                data = response.json()
                print(f"   Results Count: {data.get('count', 0)}")
                
                if data.get('grama_niladhari_officials'):
                    for official in data['grama_niladhari_officials'][:1]:  # Show first result
                        print(f"   - {official.get('name')} ({official.get('district')}, {official.get('grama_niladhari_division')})")
            else:
                print(f"   Error: {response.text}")
            print()
            
        except requests.exceptions.RequestException as e:
            print(f"   Network Error: {e}")
            print()

if __name__ == "__main__":
    print("🧪 Testing Grama Niladhari API Endpoints")
    print("=" * 50)
    
    if test_token == "your-jwt-token-here":
        print("⚠️  Please update the test_token variable with a valid JWT token")
        print("   You can get a token by logging in through the app and checking browser dev tools")
        print()
    
    print("ℹ️  Make sure the Flask backend is running on localhost:5000")
    print("ℹ️  Sample data should be populated in MongoDB")
    print()
    
    test_get_officials_by_district()
    test_search_officials()
    
    print("✅ Test script completed!")
