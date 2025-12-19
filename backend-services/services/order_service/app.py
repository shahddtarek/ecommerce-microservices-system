from flask import Flask, request, jsonify
from datetime import datetime
import uuid

app = Flask(__name__)

ORDERS = {}

@app.route('/api/orders/create', methods=['POST'])
def create_order():
    try:
        data = request.get_json()

        if not data:
            raise ValueError("JSON body is missing")

        customer_id = int(data['customer_id'])
        products = data['products']
        total_amount = float(data.get('total_amount', 0))

        if not isinstance(products, list) or len(products) == 0:
            raise ValueError("Products list is required")

        for product in products:
            product_id = int(product['product_id'])
            quantity = int(product['quantity'])

            if quantity <= 0:
                raise ValueError("Quantity must be greater than zero")

        order_id = str(uuid.uuid4())
        timestamp = datetime.now().isoformat()

        return jsonify({
            "status": "success",
            "order_id": order_id,
            "customer_id": customer_id,
            "products": products,
            "total_amount": total_amount,
            "timestamp": timestamp
        }), 200

    except KeyError as e:
        return jsonify({
            "status": "error",
            "message": f"Missing parameter: {str(e)}"
        }), 400

    except ValueError as e:
        return jsonify({
            "status": "error",
            "message": str(e)
        }), 400

    except Exception as e:
        return jsonify({
            "status": "error",
            "message": "Invalid request"
        }), 400


@app.route('/api/orders/<order_id>', methods=['GET'])
def get_order(order_id):
    order = ORDERS.get(order_id)

    if not order:
        return jsonify({
            "status": "error",
            "message": "Order not found"
        }), 404

    return jsonify(order), 200


if __name__ == '__main__':
    app.run(port=5001, debug=True)
