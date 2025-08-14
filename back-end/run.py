"""
Main entry point for the GramaConnect Flask application.
This file runs the modular Flask application.
"""
import os
import sys

# Add the project root to Python path
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

from app.app_factory import create_app
from config.config import DevelopmentConfig, ProductionConfig

def main():
    """Main function to run the Flask application."""
    # Determine environment
    env = os.getenv('FLASK_ENV', 'development')
    
    if env == 'production':
        config = ProductionConfig()
    else:
        config = DevelopmentConfig()
    
    # Create app instance
    app = create_app(config)
    
    # Run the application
    app.run(
        debug=True,
        host='127.0.0.1',
        port=5000,
        use_reloader=False
    )

if __name__ == '__main__':
    main()
