from flask import Flask, request, jsonify
from common.db import get_db_connection
import requests

app = Flask(__name__)

INVENTORY_SERVICE_URL = "http://localhost:5002/api/inventory/check"

@app.route('/api/pricing/calculate', methods=['POST'])
def calculate_price():
    try:
        data = request.get_json()

        if not data or 'products' not in data:
            return jsonify({
                "status": "error",
                "message": "Products list is required"
            }), 400

        products = data['products']

        conn = get_db_connection()
        cursor = conn.cursor(dictionary=True)

        total = 0
        items = []

        for item in products:
            product_id = int(item['product_id'])
            quantity = int(item['quantity'])

            # 1️⃣ Base price from Inventory Service
            inv_res = requests.get(f"{INVENTORY_SERVICE_URL}/{product_id}")

            if inv_res.status_code != 200:
                return jsonify({
                    "status": "error",
                    "message": f"Product {product_id} not found in inventory"
                }), 404

            product = inv_res.json()
            unit_price = float(product['unit_price'])

            subtotal = unit_price * quantity


            cursor.execute("""
                SELECT discount_percentage
                FROM pricing_rules
                WHERE product_id = %s AND min_quantity <= %s
                ORDER BY min_quantity DESC
                LIMIT 1
            """, (product_id, quantity))

            rule = cursor.fetchone()
            discount = float(rule['discount_percentage']) if rule else 0.0

            discount_amount = subtotal * (discount / 100)
            price_after_discount = subtotal - discount_amount

            total += price_after_discount

            items.append({
                "product_id": product_id,
                "unit_price": unit_price,
                "quantity": quantity,
                "discount_percentage": discount,
                "final_price": price_after_discount
            })


        cursor.execute(
            "SELECT tax_rate FROM tax_rates WHERE region = %s",
            ("default",)
        )
        tax = cursor.fetchone()
        tax_rate = float(tax['tax_rate']) if tax else 0.0

        tax_amount = total * (tax_rate / 100)
        grand_total = total + tax_amount

        cursor.close()
        conn.close()

        return jsonify({
            "status": "success",
            "items": items,
            "subtotal": total,
            "tax_rate": tax_rate,
            "tax_amount": tax_amount,
            "total_amount": grand_total
        }), 200

    except Exception as e:
        return jsonify({
            "status": "error",
            "message": str(e)
        }), 400


if __name__ == '__main__':
    app.run(port=5003, debug=True)
