from flask import Flask, jsonify, request
from common.db import get_db_connection

app = Flask(__name__)

@app.route('/api/inventory/all', methods=['GET'])
def get_all_products():
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT product_id, product_name, quantity_available, unit_price FROM inventory")
    products = cursor.fetchall()
    cursor.close()
    conn.close()
    return jsonify(products)

@app.route('/api/inventory/check/<int:product_id>', methods=['GET'])
def check_inventory(product_id):
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    cursor.execute(
        "SELECT product_id, product_name, quantity_available, unit_price "
        "FROM inventory WHERE product_id = %s",
        (product_id,)
    )
    product = cursor.fetchone()

    cursor.close()
    conn.close()

    if product:
        return jsonify(product), 200
    else:
        return jsonify({
            "status": "error",
            "message": "Product not found"
        }), 404



@app.route('/api/inventory/update', methods=['PUT'])
def update_inventory():
    try:
        data = request.get_json()

        if not data or 'products' not in data:
            return jsonify({
                "status": "error",
                "message": "Products list is required"
            }), 400

        conn = get_db_connection()
        cursor = conn.cursor(dictionary=True)

        for product in data['products']:
            product_id = int(product['product_id'])
            quantity = int(product['quantity'])


            cursor.execute(
                "SELECT quantity_available FROM inventory WHERE product_id = %s",
                (product_id,)
            )
            result = cursor.fetchone()

            if not result:
                conn.rollback()
                return jsonify({
                    "status": "error",
                    "message": f"Product {product_id} not found"
                }), 404

            if result['quantity_available'] < quantity:
                conn.rollback()
                return jsonify({
                    "status": "error",
                    "message": f"Insufficient stock for product {product_id}"
                }), 400

            # Update stock
            cursor.execute(
                "UPDATE inventory "
                "SET quantity_available = quantity_available - %s "
                "WHERE product_id = %s",
                (quantity, product_id)
            )

        conn.commit()
        cursor.close()
        conn.close()

        return jsonify({
            "status": "success",
            "message": "Inventory updated successfully"
        }), 200

    except Exception as e:
        return jsonify({
            "status": "error",
            "message": str(e)
        }), 400


if __name__ == '__main__':
    app.run(port=5002, debug=True)
