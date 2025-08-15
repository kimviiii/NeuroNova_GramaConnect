"""
Sample data script to populate Grama Niladhari officials in MongoDB

Run this script to add test data for the Contact Grama Niladhari feature
"""

import os
from pymongo import MongoClient
from datetime import datetime
from bson.objectid import ObjectId

# Load environment variables
from dotenv import load_dotenv
load_dotenv()

# MongoDB connection
MONGODB_URI = os.getenv('MONGODB_URI')
DATABASE_NAME = 'gramaconnect'

if not MONGODB_URI:
    print("❌ MONGODB_URI not found in environment variables")
    exit(1)

# Connect to MongoDB
try:
    client = MongoClient(MONGODB_URI)
    db = client[DATABASE_NAME]
    gn_collection = db.grama_niladhari
    print("✅ Connected to MongoDB successfully!")
except Exception as e:
    print(f"❌ MongoDB connection failed: {e}")
    exit(1)

# Sample Grama Niladhari officials data
sample_officials = [
    # Colombo District
    {
        "name": "Mr. K.A. Silva",
        "designation": "Grama Niladhari",
        "employee_id": "GN2024001",
        "district": "Colombo",
        "divisional_secretariat": "Colombo",
        "grama_niladhari_division": "Colombo 01",
        "division_code": "COL001",
        "office_phone": "0112345678",
        "mobile": "0771234567",
        "email": "gn.colombo01@gov.lk",
        "office_address": "Grama Niladhari Office, Fort, Colombo 01",
        "office_hours": "Monday to Friday: 8:00 AM - 4:00 PM",
        "lunch_break": "12:00 PM - 1:00 PM",
        "languages_spoken": ["Sinhala", "English", "Tamil"],
        "services_provided": [
            "Identity verification",
            "Residence certificates",
            "Character certificates",
            "Birth/Death certificates",
            "Marriage registration"
        ],
        "status": "active",
        "appointed_date": "2024-01-15",
        "created_at": datetime.utcnow(),
        "updated_at": datetime.utcnow()
    },
    {
        "name": "Ms. P.D. Fernando",
        "designation": "Grama Niladhari",
        "employee_id": "GN2024002",
        "district": "Colombo",
        "divisional_secretariat": "Colombo",
        "grama_niladhari_division": "Colombo 02",
        "division_code": "COL002",
        "office_phone": "0112345679",
        "mobile": "0771234568",
        "email": "gn.colombo02@gov.lk",
        "office_address": "Grama Niladhari Office, Slave Island, Colombo 02",
        "office_hours": "Monday to Friday: 8:00 AM - 4:00 PM",
        "lunch_break": "12:00 PM - 1:00 PM",
        "languages_spoken": ["Sinhala", "English"],
        "services_provided": [
            "Identity verification",
            "Residence certificates",
            "Character certificates",
            "Birth/Death certificates",
            "Welfare applications"
        ],
        "status": "active",
        "appointed_date": "2023-08-10",
        "created_at": datetime.utcnow(),
        "updated_at": datetime.utcnow()
    },
    {
        "name": "Mr. R.M. Perera",
        "designation": "Grama Niladhari",
        "employee_id": "GN2024003",
        "district": "Colombo",
        "divisional_secretariat": "Maharagama",
        "grama_niladhari_division": "Maharagama East",
        "division_code": "MAH001",
        "office_phone": "0112850123",
        "mobile": "0771234569",
        "email": "gn.maharagamaeast@gov.lk",
        "office_address": "Grama Niladhari Office, High Level Road, Maharagama",
        "office_hours": "Monday to Friday: 8:00 AM - 4:00 PM",
        "lunch_break": "12:00 PM - 1:00 PM",
        "languages_spoken": ["Sinhala", "English"],
        "services_provided": [
            "Identity verification",
            "Residence certificates",
            "Character certificates",
            "Land ownership verification",
            "Business registration support"
        ],
        "status": "active",
        "appointed_date": "2023-05-20",
        "created_at": datetime.utcnow(),
        "updated_at": datetime.utcnow()
    },
    
    # Kandy District
    {
        "name": "Mr. S.L. Jayasinghe",
        "designation": "Grama Niladhari",
        "employee_id": "GN2024004",
        "district": "Kandy",
        "divisional_secretariat": "Kandy",
        "grama_niladhari_division": "Kandy City",
        "division_code": "KAN001",
        "office_phone": "0812234567",
        "mobile": "0771234570",
        "email": "gn.kandycity@gov.lk",
        "office_address": "Grama Niladhari Office, Queens Road, Kandy",
        "office_hours": "Monday to Friday: 8:00 AM - 4:00 PM",
        "lunch_break": "12:00 PM - 1:00 PM",
        "languages_spoken": ["Sinhala", "Tamil", "English"],
        "services_provided": [
            "Identity verification",
            "Residence certificates",
            "Character certificates",
            "Birth/Death certificates",
            "School admission support"
        ],
        "status": "active",
        "appointed_date": "2022-11-15",
        "created_at": datetime.utcnow(),
        "updated_at": datetime.utcnow()
    },
    {
        "name": "Ms. N.K. Wijesinghe",
        "designation": "Grama Niladhari",
        "employee_id": "GN2024005",
        "district": "Kandy",
        "divisional_secretariat": "Gampola",
        "grama_niladhari_division": "Gampola Town",
        "division_code": "GAM001",
        "office_phone": "0812234568",
        "mobile": "0771234571",
        "email": "gn.gampolatown@gov.lk",
        "office_address": "Grama Niladhari Office, Main Street, Gampola",
        "office_hours": "Monday to Friday: 8:00 AM - 4:00 PM",
        "lunch_break": "12:00 PM - 1:00 PM",
        "languages_spoken": ["Sinhala", "English"],
        "services_provided": [
            "Identity verification",
            "Residence certificates",
            "Character certificates",
            "Agricultural support",
            "Disaster relief applications"
        ],
        "status": "active",
        "appointed_date": "2023-03-08",
        "created_at": datetime.utcnow(),
        "updated_at": datetime.utcnow()
    },
    
    # Galle District
    {
        "name": "Mr. A.H. Rodrigo",
        "designation": "Grama Niladhari",
        "employee_id": "GN2024006",
        "district": "Galle",
        "divisional_secretariat": "Galle",
        "grama_niladhari_division": "Galle Fort",
        "division_code": "GAL001",
        "office_phone": "0912234567",
        "mobile": "0771234572",
        "email": "gn.gallefort@gov.lk",
        "office_address": "Grama Niladhari Office, Church Street, Galle Fort",
        "office_hours": "Monday to Friday: 8:00 AM - 4:00 PM",
        "lunch_break": "12:00 PM - 1:00 PM",
        "languages_spoken": ["Sinhala", "English", "Tamil"],
        "services_provided": [
            "Identity verification",
            "Residence certificates",
            "Character certificates",
            "Tourism business registration",
            "Fisheries support"
        ],
        "status": "active",
        "appointed_date": "2022-09-12",
        "created_at": datetime.utcnow(),
        "updated_at": datetime.utcnow()
    },
    {
        "name": "Mrs. M.S. Wickramasinghe",
        "designation": "Grama Niladhari",
        "employee_id": "GN2024007",
        "district": "Galle",
        "divisional_secretariat": "Hikkaduwa",
        "grama_niladhari_division": "Hikkaduwa Beach",
        "division_code": "HIK001",
        "office_phone": "0912234568",
        "mobile": "0771234573",
        "email": "gn.hikkaduwbeach@gov.lk",
        "office_address": "Grama Niladhari Office, Galle Road, Hikkaduwa",
        "office_hours": "Monday to Friday: 8:00 AM - 4:00 PM",
        "lunch_break": "12:00 PM - 1:00 PM",
        "languages_spoken": ["Sinhala", "English"],
        "services_provided": [
            "Identity verification",
            "Residence certificates",
            "Character certificates",
            "Coastal development permits",
            "Environmental clearances"
        ],
        "status": "active",
        "appointed_date": "2023-07-25",
        "created_at": datetime.utcnow(),
        "updated_at": datetime.utcnow()
    },
]

# Insert sample data
try:
    # Clear existing data (for testing)
    result = gn_collection.delete_many({})
    print(f"🗑️ Cleared {result.deleted_count} existing records")
    
    # Insert new sample data
    result = gn_collection.insert_many(sample_officials)
    print(f"✅ Inserted {len(result.inserted_ids)} Grama Niladhari officials")
    
    # Verify insertion
    count = gn_collection.count_documents({})
    print(f"📊 Total officials in database: {count}")
    
    # Show sample data by district
    print("\n📍 Officials by District:")
    pipeline = [
        {"$group": {"_id": "$district", "count": {"$sum": 1}}},
        {"$sort": {"_id": 1}}
    ]
    
    for district_data in gn_collection.aggregate(pipeline):
        print(f"   {district_data['_id']}: {district_data['count']} officials")
    
    print("\n🎉 Sample data insertion completed successfully!")
    
except Exception as e:
    print(f"❌ Error inserting sample data: {e}")

finally:
    client.close()
    print("🔗 MongoDB connection closed")
