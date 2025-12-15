from flask import Flask, request, jsonify
from common.db import get_db_connection
import requests

app = Flask(__name__)


@app.route('/api/pricing/calculate', methods=['POST'])
def calculate_price():
    data = request.get_json()
    products = data['products']

    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    total = 0
    items = []

    for item in products:
        product_id = item['product_id']
        quantity = int(item['quantity'])

        # 1️⃣ base price من Inventory Service
        inv_res = requests.get(
            f"http://localhost:5002/api/inventory/check/{product_id}"
        )
        product = inv_res.json()
        unit_price = float(product['unit_price'])

        subtotal = unit_price * quantity

        # 2️⃣ discount من database
        cursor.execute("""
            SELECT discount_percentage
            FROM pricing_rules
            WHERE product_id = %s AND min_quantity <= %s
            ORDER BY min_quantity DESC
            LIMIT 1
        """, (product_id, quantity))

        rule = cursor.fetchone()
        discount = rule['discount_percentage'] if rule else 0

        discount_amount = subtotal * (discount / 100)
        final_price = subtotal - discount_amount

        total += final_price

        items.append({
            "product_id": product_id,
            "unit_price": unit_price,
            "quantity": quantity,
            "discount": discount,
            "final_price": final_price
        })

    cursor.close()
    conn.close()

    return jsonify({
        "items": items,
        "total_amount": total
    })

if __name__ == '__main__':
    app.run(port=5003)
