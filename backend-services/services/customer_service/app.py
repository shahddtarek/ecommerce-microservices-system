from flask import Flask, jsonify, request
from common.db import get_db_connection
import requests

app = Flask(__name__)


@app.route('/api/customers/<int:customer_id>', methods=['GET'])
def get_customer(customer_id):
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    cursor.execute(
        "SELECT * FROM customers WHERE customer_id = %s",
        (customer_id,)
    )
    customer = cursor.fetchone()

    cursor.close()
    conn.close()

    if not customer:
        return jsonify({"error": "Customer not found"}), 404

    return jsonify(customer)



@app.route('/api/customers/<int:customer_id>/orders', methods=['GET'])
def get_customer_orders(customer_id):
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)


    cursor.execute("SELECT 1 FROM customers WHERE customer_id = %s", (customer_id,))
    if not cursor.fetchone():
        cursor.close()
        conn.close()
        return jsonify({"error": "Customer not found"}), 404

    cursor.execute("""
        SELECT order_id, total_amount, created_at, status
        FROM orders
        WHERE customer_id = %s
        ORDER BY created_at DESC
    """, (customer_id,))
    orders = cursor.fetchall()


    for order in orders:
        cursor.execute("""
            SELECT i.product_name, oi.quantity, oi.price
            FROM order_items oi
            JOIN inventory i ON oi.product_id = i.product_id
            WHERE oi.order_id = %s
        """, (order["order_id"],))
        

        order["items"] = cursor.fetchall()

    cursor.close()
    conn.close()


    return jsonify({
        "customer_id": customer_id,
        "orders": orders
    }), 200


@app.route('/api/customers/<int:customer_id>/loyalty', methods=['PUT'])
def update_loyalty(customer_id):
    data = request.get_json()
    points = data.get("points")

    conn = get_db_connection()
    cursor = conn.cursor()

    cursor.execute(
        "UPDATE customers SET loyalty_points = loyalty_points + %s WHERE customer_id = %s",
        (points, customer_id)
    )
    conn.commit()

    cursor.close()
    conn.close()

    return jsonify({
        "status": "success",
        "customer_id": customer_id,
        "added_points": points
    })


if __name__ == '__main__':
    app.run(port=5004)
