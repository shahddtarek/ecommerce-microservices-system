from flask import Flask, request, jsonify
from datetime import datetime
from common.db import get_db_connection
import uuid

app = Flask(__name__)



@app.route('/api/orders/create', methods=['POST'])
def create_order():
    data = request.get_json()

    customer_id = data.get('customer_id')
    products = data.get('products')
    total_amount = data.get('total_amount')
    order_items_details = []

    if not customer_id or not products:
        return jsonify({"error": "Invalid order data"}), 400

    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    try:
        cursor.execute(
            "INSERT INTO orders (customer_id, total_amount) VALUES (%s, %s)",
            (customer_id, total_amount)
        )
        order_id = cursor.lastrowid

        for item in products:
            p_id = item.get('product_id')
            qty = item.get('quantity')

            cursor.execute("SELECT product_name, unit_price FROM inventory WHERE product_id = %s", (p_id,))
            result = cursor.fetchone()

            if result:
                actual_price = result['unit_price']
                name = result['product_name']
                
                cursor.execute(
                    """
                    INSERT INTO order_items (order_id, product_id, quantity, price)
                    VALUES (%s, %s, %s, %s)
                    """,
                    (order_id, p_id, qty, actual_price)
                )
                order_items_details.append({
                "product_name": name,
                "quantity": qty,
                "price": float(actual_price)
            })
            else:
                print(f"Warning: Product {p_id} not found in inventory!")

        conn.commit()
        return jsonify({"status": "success",
                         "order_id": order_id,
                         "items": order_items_details 
                         }), 201

    except Exception as e:
        conn.rollback()
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()
        conn.close()
        
@app.route('/api/orders/<int:order_id>', methods=['GET'])
def get_order(order_id):
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    cursor.execute(
        "SELECT * FROM orders WHERE order_id = %s",
        (order_id,)
    )
    order = cursor.fetchone()

    if not order:
        return jsonify({"error": "Order not found"}), 404

    cursor.execute(
        "SELECT product_id, quantity, price FROM order_items WHERE order_id = %s",
        (order_id,)
    )
    items = cursor.fetchall()

    cursor.close()
    conn.close()

    return jsonify({
        "order_id": order['order_id'],
        "customer_id": order['customer_id'],
        "total_amount": float(order['total_amount']),
        "status": order['status'],
        "created_at": str(order['created_at']),
        "items": items
    })


if __name__ == '__main__':
    app.run(port=5001, debug=True)
