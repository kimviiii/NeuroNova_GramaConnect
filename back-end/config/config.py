"""
Configuration settings for the Flask application.
"""
import os
from dotenv import load_dotenv

# Load environment variables
load_dotenv()

class Config:
    """Base configuration class."""
    
    # Flask Configuration
    SECRET_KEY = os.getenv('SECRET_KEY', 'your-secret-key-gramaconnect-2025')
    DEBUG = os.getenv('FLASK_ENV') == 'development'
    
    # MongoDB Configuration
    MONGODB_URI = os.getenv('MONGODB_URI')
    DATABASE_NAME = os.getenv('DATABASE_NAME', 'gramaconnect')
    
    # JWT Configuration
    JWT_EXPIRATION_DAYS = 7
    
    @staticmethod
    def validate():
        """Validate that required configuration is present."""
        if not Config.MONGODB_URI:
            raise ValueError("MONGODB_URI environment variable is required")
        return True

class DevelopmentConfig(Config):
    """Development configuration."""
    DEBUG = True

class ProductionConfig(Config):
    """Production configuration."""
    DEBUG = False

# Configuration dictionary
config = {
    'development': DevelopmentConfig,
    'production': ProductionConfig,
    'default': DevelopmentConfig
}
