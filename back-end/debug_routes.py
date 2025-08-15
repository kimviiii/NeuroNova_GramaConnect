"""
Quick test to list all available routes.
"""
import sys
import os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

from app.app_factory import create_app
from config.config import DevelopmentConfig

def list_routes():
    app = create_app(DevelopmentConfig)
    
    print("🔍 Available Routes:")
    print("=" * 50)
    
    routes = []
    for rule in app.url_map.iter_rules():
        methods = [m for m in rule.methods if m not in ['HEAD', 'OPTIONS']]
        route_info = {
            'endpoint': rule.endpoint,
            'methods': methods,
            'path': str(rule.rule)
        }
        routes.append(route_info)
        print(f"{'/'.join(methods):10} {rule.rule:40} -> {rule.endpoint}")
    
    print("=" * 50)
    print(f"Total routes: {len(routes)}")
    
    # Check specifically for our marriage certificate route
    marriage_route = [r for r in routes if 'marriage-certificate' in r['path']]
    if marriage_route:
        print(f"✅ Marriage certificate route found: {marriage_route[0]}")
    else:
        print("❌ Marriage certificate route NOT found!")
        
    # Check services routes
    service_routes = [r for r in routes if 'services' in r['path']]
    if service_routes:
        print(f"✅ Services routes found: {len(service_routes)}")
        for route in service_routes:
            print(f"   {route['methods']} {route['path']}")
    else:
        print("❌ No services routes found!")

if __name__ == "__main__":
    list_routes()
