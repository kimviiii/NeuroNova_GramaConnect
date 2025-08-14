"""
Main Flask application factory and configuration.
"""
from flask import Flask
from flask_cors import CORS
from config.config import DevelopmentConfig
from app.database import database_manager

def create_app(config_class=DevelopmentConfig):
    """
    Application factory pattern for creating Flask app instance.
    """
    # Create Flask app instance
    app = Flask(__name__)
    
    # Load configuration
    app.config.from_object(config_class)
    
    # Initialize CORS
    CORS(app)
    
    # Initialize database connection
    database_manager.connect()
    
    # Register blueprints
    from app.routes.main import main_bp
    from app.routes.auth import auth_bp
    from app.routes.services import services_bp
    
    app.register_blueprint(main_bp)
    app.register_blueprint(auth_bp)
    app.register_blueprint(services_bp)
    
    return app

# Initialize user model after database connection
def init_models():
    """Initialize models after database connection is established."""
    from app.models.user import user_model
    return user_model

# Create application instance
app = create_app()

# Initialize models
init_models()
