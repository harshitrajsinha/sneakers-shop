from flask import Flask, jsonify
from flask_cors import CORS
from database.connection import db
from datetime import datetime, timedelta

app = Flask(__name__)
CORS(app)

@app.route('/api/analytics/purchases/10min', methods=['GET'])
def get_purchases_10min():
    return get_purchases_by_timeframe(10)

@app.route('/api/analytics/purchases/30min', methods=['GET'])
def get_purchases_30min():
    return get_purchases_by_timeframe(30)

def get_purchases_by_timeframe(minutes):
    try:
        cursor = db.get_cursor()
        
        time_threshold = datetime.now() - timedelta(minutes=minutes)
        
        cursor.execute("""
            SELECT p.name as product_name
            FROM payment_logs pl
            JOIN products p ON pl.product_id = p.id
            WHERE pl.status = 'success'
            GROUP BY pl.product_id, p.name
            LIMIT 10
        """)
        
        results = cursor.fetchall()
        cursor.close()
        
        return jsonify({
            'timeframe': f'{minutes} minutes',
            'data': [dict(row) for row in results]
        }), 200
        
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@app.route('/api/analytics/dashboard', methods=['GET'])
def get_dashboard():
    try:
        purchases_10min = get_purchases_by_timeframe(10)
        purchases_30min = get_purchases_by_timeframe(30)
        
        return jsonify({
            '10_minutes': purchases_10min[0].get_json()['data'],
            '30_minutes': purchases_30min[0].get_json()['data']
        }), 200
        
    except Exception as e:
        return jsonify({'error': str(e)}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8083)