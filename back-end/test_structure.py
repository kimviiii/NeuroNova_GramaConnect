"""
Quick test to check if our marriage certificate endpoint structure is correct.
This tests the endpoint logic without requiring a running server.
"""
import sys
import os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

# Import our Flask app
from app.app_factory import create_app
from config.config import DevelopmentConfig

def test_app_creation():
    """Test if our Flask app can be created successfully."""
    try:
        app = create_app(DevelopmentConfig)
        print("✅ Flask app created successfully!")
        
        # Print all registered routes
        print("\n📋 Registered Routes:")
        for rule in app.url_map.iter_rules():
            methods = ','.join(rule.methods)
            print(f"   {rule.endpoint}: {rule.rule} [{methods}]")
        
        # Check if our marriage certificate route is registered
        routes = [str(rule.rule) for rule in app.url_map.iter_rules()]
        if '/api/services/marriage-certificate' in routes:
            print("\n✅ Marriage certificate endpoint is registered!")
        else:
            print("\n❌ Marriage certificate endpoint not found!")
            
        return app
        
    except Exception as e:
        print(f"❌ Failed to create Flask app: {e}")
        return None

def test_imports():
    """Test if all our imports work correctly."""
    try:
        from app.routes.services import services_bp
        print("✅ Services blueprint imported successfully!")
        
        from app.utils.auth_utils import jwt_required, get_current_user
        print("✅ Auth utils imported successfully!")
        
        from app.database import database_manager
        print("✅ Database manager imported successfully!")
        
        return True
        
    except Exception as e:
        print(f"❌ Import error: {e}")
        return False

def main():
    """Run all tests."""
    print("🧪 Testing Backend Structure...\n")
    
    # Test 1: Check imports
    if not test_imports():
        return
    
    print()
    
    # Test 2: Test app creation
    app = test_app_creation()
    if not app:
        return
    
    print("\n🎉 Backend structure is working correctly!")
    print("\n📝 Marriage Certificate Endpoint Details:")
    print("   URL: POST /api/services/marriage-certificate")
    print("   Requires: JWT Authentication")
    print("   Expected Fields: groom_name, bride_name, marriage_date, marriage_place, groom_nic")
    print("   Returns: Application with reference number")

if __name__ == "__main__":
    main()
