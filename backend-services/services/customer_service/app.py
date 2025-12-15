from flask import Flask, jsonify
import mysql.connector

app = Flask(__name__)

# ---------------------- Database Connection ----------------------
def get_db_connection():
    return mysql.connector.connect(
        host="localhost",
        user="root",
        password="admin", 
        database="ecommerce_system"
    )

# ---------------------- Routes ----------------------

@app.route('/')
def home():
    return jsonify({"message": "Customer Service running!"})

# ---- Fetch all customers ----
@app.route('/customers')
def get_customers():
    try:
        db = get_db_connection()
        cursor = db.cursor(dictionary=True)

        cursor.execute("SELECT * FROM customers")
        data = cursor.fetchall()

        cursor.close()
        db.close()
        return jsonify({"customers": data})

    except Exception as e:
        return jsonify({"error": str(e)}), 500


if __name__ == '__main__':
    app.run(port=5004)  # نفس البورت عادي
