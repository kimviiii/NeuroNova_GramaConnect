import requests
import json

# Test character certificate API endpoint
url = "http://localhost:5000/api/character-certificate"

# Test data
test_data = {
    "applicantFullName": "John Doe",
    "applicantAddress": "123 Test Street, Colombo",
    "applicantPhone": "0701234567",
    "applicantNIC": "123456789V",
    "purpose": "Employment verification",
    "residencePeriodFrom": "2020-01-01",
    "residencePeriodTo": "2024-01-01",
    "policeArea": "Colombo Central",
    "gramaNiladhariDivision": "Colombo 01"
}

# Test headers (you'll need a valid token for this to work)
headers = {
    "Content-Type": "application/json",
    "Authorization": "Bearer your-jwt-token-here"
}

try:
    response = requests.post(url, json=test_data, headers=headers)
    print(f"Status Code: {response.status_code}")
    print(f"Response: {response.json()}")
except requests.exceptions.RequestException as e:
    print(f"Error: {e}")
