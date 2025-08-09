from flask import Flask, request, jsonify
from flask_cors import CORS
from database.connection import db
import json
from datetime import datetime

app = Flask(__name__)
CORS(app)

@app.route('/api/log', methods=['POST'])
def log_event():
    try:
        data = request.get_json()
        
        cursor = db.get_cursor()
        cursor.execute("""
            INSERT INTO event_logs (event_type, data, timestamp)
            VALUES (%s, %s, %s)
        """, (data.get('event_type'), json.dumps(data), datetime.now()))
        
        db.connection.commit()
        cursor.close()
        
        return jsonify({'status': 'logged'}), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8082)