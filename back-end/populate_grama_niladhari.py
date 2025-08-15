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

# Sample Grama Niladhari officials data - Comprehensive coverage across Sri Lanka
sample_officials = [
    # WESTERN PROVINCE
    
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
    {
        "name": "Mrs. S.N. Wickramasinghe",
        "designation": "Grama Niladhari",
        "employee_id": "GN2024004",
        "district": "Colombo",
        "divisional_secretariat": "Kesbewa",
        "grama_niladhari_division": "Piliyandala",
        "division_code": "PIL001",
        "office_phone": "0112850456",
        "mobile": "0771234570",
        "email": "gn.piliyandala@gov.lk",
        "office_address": "Grama Niladhari Office, Piliyandala Junction",
        "office_hours": "Monday to Friday: 8:00 AM - 4:00 PM",
        "lunch_break": "12:00 PM - 1:00 PM",
        "languages_spoken": ["Sinhala", "English"],
        "services_provided": [
            "Identity verification",
            "Residence certificates",
            "Character certificates",
            "School admission support",
            "Welfare applications"
        ],
        "status": "active",
        "appointed_date": "2023-03-12",
        "created_at": datetime.utcnow(),
        "updated_at": datetime.utcnow()
    },
    
    # Gampaha District
    {
        "name": "Mr. D.M. Jayawardana",
        "designation": "Grama Niladhari",
        "employee_id": "GN2024005",
        "district": "Gampaha",
        "divisional_secretariat": "Gampaha",
        "grama_niladhari_division": "Gampaha Town",
        "division_code": "GAM001",
        "office_phone": "0332222345",
        "mobile": "0771234571",
        "email": "gn.gampahatown@gov.lk",
        "office_address": "Grama Niladhari Office, Main Street, Gampaha",
        "office_hours": "Monday to Friday: 8:00 AM - 4:00 PM",
        "lunch_break": "12:00 PM - 1:00 PM",
        "languages_spoken": ["Sinhala", "English"],
        "services_provided": [
            "Identity verification",
            "Residence certificates",
            "Character certificates",
            "Agricultural support",
            "Land documentation"
        ],
        "status": "active",
        "appointed_date": "2022-11-08",
        "created_at": datetime.utcnow(),
        "updated_at": datetime.utcnow()
    },
    {
        "name": "Ms. A.K. Dissanayake",
        "designation": "Grama Niladhari",
        "employee_id": "GN2024006",
        "district": "Gampaha",
        "divisional_secretariat": "Negombo",
        "grama_niladhari_division": "Negombo South",
        "division_code": "NEG001",
        "office_phone": "0312222789",
        "mobile": "0771234572",
        "email": "gn.negombosouth@gov.lk",
        "office_address": "Grama Niladhari Office, Sea Street, Negombo",
        "office_hours": "Monday to Friday: 8:00 AM - 4:00 PM",
        "lunch_break": "12:00 PM - 1:00 PM",
        "languages_spoken": ["Sinhala", "English", "Tamil"],
        "services_provided": [
            "Identity verification",
            "Residence certificates",
            "Character certificates",
            "Fisheries support",
            "Tourism business permits"
        ],
        "status": "active",
        "appointed_date": "2023-06-15",
        "created_at": datetime.utcnow(),
        "updated_at": datetime.utcnow()
    },
    {
        "name": "Mr. L.P. Gunaratne",
        "designation": "Grama Niladhari",
        "employee_id": "GN2024007",
        "district": "Gampaha",
        "divisional_secretariat": "Katunayake",
        "grama_niladhari_division": "Seeduwa",
        "division_code": "SEE001",
        "office_phone": "0112234567",
        "mobile": "0771234573",
        "email": "gn.seeduwa@gov.lk",
        "office_address": "Grama Niladhari Office, Airport Road, Seeduwa",
        "office_hours": "Monday to Friday: 8:00 AM - 4:00 PM",
        "lunch_break": "12:00 PM - 1:00 PM",
        "languages_spoken": ["Sinhala", "English"],
        "services_provided": [
            "Identity verification",
            "Residence certificates",
            "Character certificates",
            "Employment verification",
            "Business registration"
        ],
        "status": "active",
        "appointed_date": "2023-01-20",
        "created_at": datetime.utcnow(),
        "updated_at": datetime.utcnow()
    },
    
    # Kalutara District
    {
        "name": "Mrs. M.H. Ranasinghe",
        "designation": "Grama Niladhari",
        "employee_id": "GN2024008",
        "district": "Kalutara",
        "divisional_secretariat": "Kalutara",
        "grama_niladhari_division": "Kalutara North",
        "division_code": "KAL001",
        "office_phone": "0342234567",
        "mobile": "0771234574",
        "email": "gn.kalutaranorth@gov.lk",
        "office_address": "Grama Niladhari Office, Main Road, Kalutara",
        "office_hours": "Monday to Friday: 8:00 AM - 4:00 PM",
        "lunch_break": "12:00 PM - 1:00 PM",
        "languages_spoken": ["Sinhala", "English"],
        "services_provided": [
            "Identity verification",
            "Residence certificates",
            "Character certificates",
            "Coastal development permits",
            "Tourism support"
        ],
        "status": "active",
        "appointed_date": "2022-09-18",
        "created_at": datetime.utcnow(),
        "updated_at": datetime.utcnow()
    },
    
    # CENTRAL PROVINCE
    
    # Kandy District
    {
        "name": "Mr. S.L. Jayasinghe",
        "designation": "Grama Niladhari",
        "employee_id": "GN2024009",
        "district": "Kandy",
        "divisional_secretariat": "Kandy",
        "grama_niladhari_division": "Kandy City",
        "division_code": "KAN001",
        "office_phone": "0812234567",
        "mobile": "0771234575",
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
        "employee_id": "GN2024010",
        "district": "Kandy",
        "divisional_secretariat": "Gampola",
        "grama_niladhari_division": "Gampola Town",
        "division_code": "GAM002",
        "office_phone": "0812234568",
        "mobile": "0771234576",
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
    {
        "name": "Mr. K.B. Rathnayake",
        "designation": "Grama Niladhari",
        "employee_id": "GN2024011",
        "district": "Kandy",
        "divisional_secretariat": "Peradeniya",
        "grama_niladhari_division": "Peradeniya",
        "division_code": "PER001",
        "office_phone": "0812234569",
        "mobile": "0771234577",
        "email": "gn.peradeniya@gov.lk",
        "office_address": "Grama Niladhari Office, University Road, Peradeniya",
        "office_hours": "Monday to Friday: 8:00 AM - 4:00 PM",
        "lunch_break": "12:00 PM - 1:00 PM",
        "languages_spoken": ["Sinhala", "English", "Tamil"],
        "services_provided": [
            "Identity verification",
            "Residence certificates",
            "Character certificates",
            "Educational support",
            "Research permits"
        ],
        "status": "active",
        "appointed_date": "2023-07-10",
        "created_at": datetime.utcnow(),
        "updated_at": datetime.utcnow()
    },
    
    # Matale District
    {
        "name": "Mrs. R.D. Kumari",
        "designation": "Grama Niladhari",
        "employee_id": "GN2024012",
        "district": "Matale",
        "divisional_secretariat": "Matale",
        "grama_niladhari_division": "Matale Town",
        "division_code": "MAT001",
        "office_phone": "0662234567",
        "mobile": "0771234578",
        "email": "gn.mataletown@gov.lk",
        "office_address": "Grama Niladhari Office, King Street, Matale",
        "office_hours": "Monday to Friday: 8:00 AM - 4:00 PM",
        "lunch_break": "12:00 PM - 1:00 PM",
        "languages_spoken": ["Sinhala", "English"],
        "services_provided": [
            "Identity verification",
            "Residence certificates",
            "Character certificates",
            "Agricultural support",
            "Spice cultivation permits"
        ],
        "status": "active",
        "appointed_date": "2022-12-05",
        "created_at": datetime.utcnow(),
        "updated_at": datetime.utcnow()
    },
    
    # Nuwara Eliya District
    {
        "name": "Mr. P.K. Chandrasiri",
        "designation": "Grama Niladhari",
        "employee_id": "GN2024013",
        "district": "Nuwara Eliya",
        "divisional_secretariat": "Nuwara Eliya",
        "grama_niladhari_division": "Nuwara Eliya Town",
        "division_code": "NUW001",
        "office_phone": "0522234567",
        "mobile": "0771234579",
        "email": "gn.nuwaraeliyatown@gov.lk",
        "office_address": "Grama Niladhari Office, Queen Elizabeth Drive, Nuwara Eliya",
        "office_hours": "Monday to Friday: 8:00 AM - 4:00 PM",
        "lunch_break": "12:00 PM - 1:00 PM",
        "languages_spoken": ["Sinhala", "English", "Tamil"],
        "services_provided": [
            "Identity verification",
            "Residence certificates",
            "Character certificates",
            "Tea estate documentation",
            "Tourism permits"
        ],
        "status": "active",
        "appointed_date": "2023-04-22",
        "created_at": datetime.utcnow(),
        "updated_at": datetime.utcnow()
    },
    
    # SOUTHERN PROVINCE
    
    # Galle District
    {
        "name": "Mr. A.H. Rodrigo",
        "designation": "Grama Niladhari",
        "employee_id": "GN2024014",
        "district": "Galle",
        "divisional_secretariat": "Galle",
        "grama_niladhari_division": "Galle Fort",
        "division_code": "GAL001",
        "office_phone": "0912234567",
        "mobile": "0771234580",
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
        "employee_id": "GN2024015",
        "district": "Galle",
        "divisional_secretariat": "Hikkaduwa",
        "grama_niladhari_division": "Hikkaduwa Beach",
        "division_code": "HIK001",
        "office_phone": "0912234568",
        "mobile": "0771234581",
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
    {
        "name": "Mr. T.G. Silva",
        "designation": "Grama Niladhari",
        "employee_id": "GN2024016",
        "district": "Galle",
        "divisional_secretariat": "Bentota",
        "grama_niladhari_division": "Bentota South",
        "division_code": "BEN001",
        "office_phone": "0912234569",
        "mobile": "0771234582",
        "email": "gn.bentotasouth@gov.lk",
        "office_address": "Grama Niladhari Office, River Road, Bentota",
        "office_hours": "Monday to Friday: 8:00 AM - 4:00 PM",
        "lunch_break": "12:00 PM - 1:00 PM",
        "languages_spoken": ["Sinhala", "English"],
        "services_provided": [
            "Identity verification",
            "Residence certificates",
            "Character certificates",
            "Tourism permits",
            "Water sports licensing"
        ],
        "status": "active",
        "appointed_date": "2023-02-14",
        "created_at": datetime.utcnow(),
        "updated_at": datetime.utcnow()
    },
    
    # Matara District
    {
        "name": "Mrs. S.P. Jayawardana",
        "designation": "Grama Niladhari",
        "employee_id": "GN2024017",
        "district": "Matara",
        "divisional_secretariat": "Matara",
        "grama_niladhari_division": "Matara Town",
        "division_code": "MAT002",
        "office_phone": "0412234567",
        "mobile": "0771234583",
        "email": "gn.mataratown@gov.lk",
        "office_address": "Grama Niladhari Office, Main Street, Matara",
        "office_hours": "Monday to Friday: 8:00 AM - 4:00 PM",
        "lunch_break": "12:00 PM - 1:00 PM",
        "languages_spoken": ["Sinhala", "English"],
        "services_provided": [
            "Identity verification",
            "Residence certificates",
            "Character certificates",
            "Fisheries documentation",
            "Coconut cultivation support"
        ],
        "status": "active",
        "appointed_date": "2022-10-30",
        "created_at": datetime.utcnow(),
        "updated_at": datetime.utcnow()
    },
    
    # Hambantota District
    {
        "name": "Mr. D.K. Perera",
        "designation": "Grama Niladhari",
        "employee_id": "GN2024018",
        "district": "Hambantota",
        "divisional_secretariat": "Hambantota",
        "grama_niladhari_division": "Hambantota Port",
        "division_code": "HAM001",
        "office_phone": "0472234567",
        "mobile": "0771234584",
        "email": "gn.hambantotaport@gov.lk",
        "office_address": "Grama Niladhari Office, Port Access Road, Hambantota",
        "office_hours": "Monday to Friday: 8:00 AM - 4:00 PM",
        "lunch_break": "12:00 PM - 1:00 PM",
        "languages_spoken": ["Sinhala", "English"],
        "services_provided": [
            "Identity verification",
            "Residence certificates",
            "Character certificates",
            "Port area permits",
            "Development project support"
        ],
        "status": "active",
        "appointed_date": "2023-05-16",
        "created_at": datetime.utcnow(),
        "updated_at": datetime.utcnow()
    },
    
    # NORTHERN PROVINCE
    
    # Jaffna District
    {
        "name": "Mr. K. Sivakumar",
        "designation": "Grama Niladhari",
        "employee_id": "GN2024019",
        "district": "Jaffna",
        "divisional_secretariat": "Jaffna",
        "grama_niladhari_division": "Jaffna Town",
        "division_code": "JAF001",
        "office_phone": "0212234567",
        "mobile": "0771234585",
        "email": "gn.jaffnatown@gov.lk",
        "office_address": "Grama Niladhari Office, Hospital Road, Jaffna",
        "office_hours": "Monday to Friday: 8:00 AM - 4:00 PM",
        "lunch_break": "12:00 PM - 1:00 PM",
        "languages_spoken": ["Tamil", "Sinhala", "English"],
        "services_provided": [
            "Identity verification",
            "Residence certificates",
            "Character certificates",
            "Reconstruction support",
            "Educational documentation"
        ],
        "status": "active",
        "appointed_date": "2023-01-28",
        "created_at": datetime.utcnow(),
        "updated_at": datetime.utcnow()
    },
    
    # Kilinochchi District
    {
        "name": "Mrs. M. Priya",
        "designation": "Grama Niladhari",
        "employee_id": "GN2024020",
        "district": "Kilinochchi",
        "divisional_secretariat": "Kilinochchi",
        "grama_niladhari_division": "Kilinochchi Central",
        "division_code": "KIL001",
        "office_phone": "0212234568",
        "mobile": "0771234586",
        "email": "gn.kilinocentral@gov.lk",
        "office_address": "Grama Niladhari Office, Main Road, Kilinochchi",
        "office_hours": "Monday to Friday: 8:00 AM - 4:00 PM",
        "lunch_break": "12:00 PM - 1:00 PM",
        "languages_spoken": ["Tamil", "Sinhala", "English"],
        "services_provided": [
            "Identity verification",
            "Residence certificates",
            "Character certificates",
            "Resettlement support",
            "Agricultural assistance"
        ],
        "status": "active",
        "appointed_date": "2023-08-14",
        "created_at": datetime.utcnow(),
        "updated_at": datetime.utcnow()
    },
    
    # EASTERN PROVINCE
    
    # Batticaloa District
    {
        "name": "Mr. A. Rahman",
        "designation": "Grama Niladhari",
        "employee_id": "GN2024021",
        "district": "Batticaloa",
        "divisional_secretariat": "Batticaloa",
        "grama_niladhari_division": "Batticaloa Town",
        "division_code": "BAT001",
        "office_phone": "0652234567",
        "mobile": "0771234587",
        "email": "gn.batticaloatown@gov.lk",
        "office_address": "Grama Niladhari Office, Main Street, Batticaloa",
        "office_hours": "Monday to Friday: 8:00 AM - 4:00 PM",
        "lunch_break": "12:00 PM - 1:00 PM",
        "languages_spoken": ["Tamil", "Sinhala", "English"],
        "services_provided": [
            "Identity verification",
            "Residence certificates",
            "Character certificates",
            "Fisheries support",
            "Community development"
        ],
        "status": "active",
        "appointed_date": "2022-11-20",
        "created_at": datetime.utcnow(),
        "updated_at": datetime.utcnow()
    },
    
    # Ampara District
    {
        "name": "Mrs. N.S. Peiris",
        "designation": "Grama Niladhari",
        "employee_id": "GN2024022",
        "district": "Ampara",
        "divisional_secretariat": "Ampara",
        "grama_niladhari_division": "Ampara Central",
        "division_code": "AMP001",
        "office_phone": "0632234567",
        "mobile": "0771234588",
        "email": "gn.amparacentral@gov.lk",
        "office_address": "Grama Niladhari Office, D.S. Senanayake Street, Ampara",
        "office_hours": "Monday to Friday: 8:00 AM - 4:00 PM",
        "lunch_break": "12:00 PM - 1:00 PM",
        "languages_spoken": ["Sinhala", "Tamil", "English"],
        "services_provided": [
            "Identity verification",
            "Residence certificates",
            "Character certificates",
            "Agricultural support",
            "Irrigation documentation"
        ],
        "status": "active",
        "appointed_date": "2023-04-17",
        "created_at": datetime.utcnow(),
        "updated_at": datetime.utcnow()
    },
    
    # Trincomalee District
    {
        "name": "Mr. V. Krishnan",
        "designation": "Grama Niladhari",
        "employee_id": "GN2024023",
        "district": "Trincomalee",
        "divisional_secretariat": "Trincomalee",
        "grama_niladhari_division": "Trinco Town",
        "division_code": "TRI001",
        "office_phone": "0262234567",
        "mobile": "0771234589",
        "email": "gn.trincotown@gov.lk",
        "office_address": "Grama Niladhari Office, Court Road, Trincomalee",
        "office_hours": "Monday to Friday: 8:00 AM - 4:00 PM",
        "lunch_break": "12:00 PM - 1:00 PM",
        "languages_spoken": ["Tamil", "Sinhala", "English"],
        "services_provided": [
            "Identity verification",
            "Residence certificates",
            "Character certificates",
            "Harbor area permits",
            "Tourism support"
        ],
        "status": "active",
        "appointed_date": "2023-06-03",
        "created_at": datetime.utcnow(),
        "updated_at": datetime.utcnow()
    },
    
    # NORTH WESTERN PROVINCE
    
    # Kurunegala District
    {
        "name": "Mr. H.K. Bandara",
        "designation": "Grama Niladhari",
        "employee_id": "GN2024024",
        "district": "Kurunegala",
        "divisional_secretariat": "Kurunegala",
        "grama_niladhari_division": "Kurunegala Town",
        "division_code": "KUR001",
        "office_phone": "0372234567",
        "mobile": "0771234590",
        "email": "gn.kurunegaltown@gov.lk",
        "office_address": "Grama Niladhari Office, Colombo Road, Kurunegala",
        "office_hours": "Monday to Friday: 8:00 AM - 4:00 PM",
        "lunch_break": "12:00 PM - 1:00 PM",
        "languages_spoken": ["Sinhala", "English"],
        "services_provided": [
            "Identity verification",
            "Residence certificates",
            "Character certificates",
            "Coconut cultivation support",
            "Small business permits"
        ],
        "status": "active",
        "appointed_date": "2022-08-25",
        "created_at": datetime.utcnow(),
        "updated_at": datetime.utcnow()
    },
    
    # Puttalam District
    {
        "name": "Mrs. F.N. Silva",
        "designation": "Grama Niladhari",
        "employee_id": "GN2024025",
        "district": "Puttalam",
        "divisional_secretariat": "Puttalam",
        "grama_niladhari_division": "Puttalam Town",
        "division_code": "PUT001",
        "office_phone": "0322234567",
        "mobile": "0771234591",
        "email": "gn.puttalamtown@gov.lk",
        "office_address": "Grama Niladhari Office, Main Street, Puttalam",
        "office_hours": "Monday to Friday: 8:00 AM - 4:00 PM",
        "lunch_break": "12:00 PM - 1:00 PM",
        "languages_spoken": ["Sinhala", "Tamil", "English"],
        "services_provided": [
            "Identity verification",
            "Residence certificates",
            "Character certificates",
            "Fisheries documentation",
            "Salt production permits"
        ],
        "status": "active",
        "appointed_date": "2023-09-12",
        "created_at": datetime.utcnow(),
        "updated_at": datetime.utcnow()
    },
    
    # NORTH CENTRAL PROVINCE
    
    # Anuradhapura District
    {
        "name": "Mr. W.A. Gunasekera",
        "designation": "Grama Niladhari",
        "employee_id": "GN2024026",
        "district": "Anuradhapura",
        "divisional_secretariat": "Anuradhapura",
        "grama_niladhari_division": "Anuradhapura Sacred City",
        "division_code": "ANU001",
        "office_phone": "0252234567",
        "mobile": "0771234592",
        "email": "gn.anuradhapurasacred@gov.lk",
        "office_address": "Grama Niladhari Office, Sacred City Road, Anuradhapura",
        "office_hours": "Monday to Friday: 8:00 AM - 4:00 PM",
        "lunch_break": "12:00 PM - 1:00 PM",
        "languages_spoken": ["Sinhala", "English"],
        "services_provided": [
            "Identity verification",
            "Residence certificates",
            "Character certificates",
            "Archaeological site permits",
            "Cultural heritage documentation"
        ],
        "status": "active",
        "appointed_date": "2022-12-18",
        "created_at": datetime.utcnow(),
        "updated_at": datetime.utcnow()
    },
    
    # Polonnaruwa District
    {
        "name": "Mrs. D.M. Kumari",
        "designation": "Grama Niladhari",
        "employee_id": "GN2024027",
        "district": "Polonnaruwa",
        "divisional_secretariat": "Polonnaruwa",
        "grama_niladhari_division": "Polonnaruwa Ancient City",
        "division_code": "POL001",
        "office_phone": "0272234567",
        "mobile": "0771234593",
        "email": "gn.polonnaruwaancient@gov.lk",
        "office_address": "Grama Niladhari Office, Ancient City Road, Polonnaruwa",
        "office_hours": "Monday to Friday: 8:00 AM - 4:00 PM",
        "lunch_break": "12:00 PM - 1:00 PM",
        "languages_spoken": ["Sinhala", "English"],
        "services_provided": [
            "Identity verification",
            "Residence certificates",
            "Character certificates",
            "Archaeological permits",
            "Tourism development"
        ],
        "status": "active",
        "appointed_date": "2023-03-25",
        "created_at": datetime.utcnow(),
        "updated_at": datetime.utcnow()
    },
    
    # UVA PROVINCE
    
    # Badulla District
    {
        "name": "Mr. S.K. Ranatunga",
        "designation": "Grama Niladhari",
        "employee_id": "GN2024028",
        "district": "Badulla",
        "divisional_secretariat": "Badulla",
        "grama_niladhari_division": "Badulla Town",
        "division_code": "BAD001",
        "office_phone": "0552234567",
        "mobile": "0771234594",
        "email": "gn.badullatown@gov.lk",
        "office_address": "Grama Niladhari Office, Lower Street, Badulla",
        "office_hours": "Monday to Friday: 8:00 AM - 4:00 PM",
        "lunch_break": "12:00 PM - 1:00 PM",
        "languages_spoken": ["Sinhala", "Tamil", "English"],
        "services_provided": [
            "Identity verification",
            "Residence certificates",
            "Character certificates",
            "Tea estate documentation",
            "Hill country development"
        ],
        "status": "active",
        "appointed_date": "2022-10-14",
        "created_at": datetime.utcnow(),
        "updated_at": datetime.utcnow()
    },
    
    # Monaragala District
    {
        "name": "Mrs. P.H. Dissanayake",
        "designation": "Grama Niladhari",
        "employee_id": "GN2024029",
        "district": "Monaragala",
        "divisional_secretariat": "Monaragala",
        "grama_niladhari_division": "Monaragala Central",
        "division_code": "MON001",
        "office_phone": "0552234568",
        "mobile": "0771234595",
        "email": "gn.monaragalacentral@gov.lk",
        "office_address": "Grama Niladhari Office, Main Street, Monaragala",
        "office_hours": "Monday to Friday: 8:00 AM - 4:00 PM",
        "lunch_break": "12:00 PM - 1:00 PM",
        "languages_spoken": ["Sinhala", "English"],
        "services_provided": [
            "Identity verification",
            "Residence certificates",
            "Character certificates",
            "Agricultural development",
            "Rural infrastructure"
        ],
        "status": "active",
        "appointed_date": "2023-07-08",
        "created_at": datetime.utcnow(),
        "updated_at": datetime.utcnow()
    },
    
    # SABARAGAMUWA PROVINCE
    
    # Ratnapura District
    {
        "name": "Mr. G.H. Silva",
        "designation": "Grama Niladhari",
        "employee_id": "GN2024030",
        "district": "Ratnapura",
        "divisional_secretariat": "Ratnapura",
        "grama_niladhari_division": "Ratnapura Town",
        "division_code": "RAT001",
        "office_phone": "0452234567",
        "mobile": "0771234596",
        "email": "gn.ratnapuratown@gov.lk",
        "office_address": "Grama Niladhari Office, Main Street, Ratnapura",
        "office_hours": "Monday to Friday: 8:00 AM - 4:00 PM",
        "lunch_break": "12:00 PM - 1:00 PM",
        "languages_spoken": ["Sinhala", "English"],
        "services_provided": [
            "Identity verification",
            "Residence certificates",
            "Character certificates",
            "Gem mining permits",
            "Environmental clearances"
        ],
        "status": "active",
        "appointed_date": "2022-11-05",
        "created_at": datetime.utcnow(),
        "updated_at": datetime.utcnow()
    },
    
    # Kegalle District
    {
        "name": "Mrs. L.K. Jayawardana",
        "designation": "Grama Niladhari",
        "employee_id": "GN2024031",
        "district": "Kegalle",
        "divisional_secretariat": "Kegalle",
        "grama_niladhari_division": "Kegalle Town",
        "division_code": "KEG001",
        "office_phone": "0352234567",
        "mobile": "0771234597",
        "email": "gn.kegalletown@gov.lk",
        "office_address": "Grama Niladhari Office, Colombo Road, Kegalle",
        "office_hours": "Monday to Friday: 8:00 AM - 4:00 PM",
        "lunch_break": "12:00 PM - 1:00 PM",
        "languages_spoken": ["Sinhala", "English"],
        "services_provided": [
            "Identity verification",
            "Residence certificates",
            "Character certificates",
            "Rubber cultivation support",
            "Small industry permits"
        ],
        "status": "active",
        "appointed_date": "2023-05-30",
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
