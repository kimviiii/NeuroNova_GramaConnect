from flask import Flask

# Create Flask app instance
app = Flask(__name__)

# Basic route - Hello World
@app.route('/')
def hello_world():
    return {'message': 'Hello World from GramaConnect Backend!', 'status': 'success'}

# Health check route
@app.route('/health')
def health_check():
    return {'message': 'Backend is running!', 'status': 'healthy'}

# Run the app
if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)
