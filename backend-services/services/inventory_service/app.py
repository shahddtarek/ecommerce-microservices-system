from flask import Flask, jsonify
from common.db import get_db_connection

app = Flask(__name__)



@app.route('/api/inventory/check/<int:product_id>', methods=['GET'])
def check_inventory(product_id):
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    cursor.execute(
        "SELECT product_id, product_name, quantity_available, unit_price FROM inventory WHERE product_id = %s",
        (product_id,)
    )
    product = cursor.fetchone()

    cursor.close()
    conn.close()

    if product:
        return jsonify(product)
    else:
        return jsonify({"error": "Product not found"}), 404

if __name__ == '__main__':
    app.run(port=5002)
