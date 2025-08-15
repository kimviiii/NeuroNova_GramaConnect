"""
Database connection and initialization module.
"""
from pymongo import MongoClient
from pymongo.database import Database
from config.config import Config

class DatabaseManager:
    """Manages MongoDB connection and operations."""
    
    def __init__(self):
        self.client = None
        self.db = None
    
    def connect(self) -> Database:
        """
        Establish connection to MongoDB.
        
        Returns:
            Database: MongoDB database instance
            
        Raises:
            Exception: If connection fails
        """
        try:
            # Validate configuration
            Config.validate()
            
            # Create MongoDB client with timeout
            self.client = MongoClient(
                Config.MONGODB_URI, 
                serverSelectionTimeoutMS=5000
            )
            
            # Get database
            self.db = self.client[Config.DATABASE_NAME]
            
            # Test connection
            self.client.admin.command('ping')
            
            print(f"✅ Connected to MongoDB: {Config.DATABASE_NAME}")
            return self.db
            
        except Exception as e:
            print(f"❌ MongoDB connection failed: {e}")
            self.db = None
            raise e
    
    def get_database(self) -> Database:
        """
        Get the database instance.
        
        Returns:
            Database: MongoDB database instance or None
        """
        return self.db
    
    def is_connected(self) -> bool:
        """
        Check if database is connected.
        
        Returns:
            bool: True if connected, False otherwise
        """
        if self.db is None:
            return False
        
        try:
            self.db.command('ping')
            return True
        except:
            return False
    
    def close_connection(self):
        """Close the database connection."""
        if self.client:
            self.client.close()
            print("🔌 Database connection closed")

# Global database manager instance
database_manager = DatabaseManager()
