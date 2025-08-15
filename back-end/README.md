# GramaConnect Backend

Flask backend API for the GramaConnect mobile application.

## Setup

1. Navigate to the back-end directory:
   ```
   cd back-end
   ```

2. Create a virtual environment:
   ```
   python -m venv venv
   ```

3. Activate the virtual environment:
   ```
   # Windows
   venv\Scripts\activate
   
   # Mac/Linux
   source venv/bin/activate
   ```

4. Install dependencies:
   ```
   pip install -r requirements.txt
   ```

5. Run the Flask app:
   ```
   python app.py
   ```

## API Endpoints

- `GET /` - Hello World message
- `GET /health` - Health check

The server will run on `http://localhost:5000`
