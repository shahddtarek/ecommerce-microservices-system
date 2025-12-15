from flask import Flask, request, jsonify
import requests

app = Flask(__name__)

PRICING_SERVICE_URL = "http://localhost:5003/api/pricing/calculate"

@app.route('/api/orders/create', methods=['POST'])
def create_order():
    try:
        data = request.get_json()

        customer_id = int(data['customer_id'])
        products = data['products']

        pricing_response = requests.post(
            PRICING_SERVICE_URL,
            json={"products": products}
        )

        pricing_data = pricing_response.json()

        order_response = {
            "status": "success",
            "order_id": 1234,
            "customer_id": customer_id,
            "items": pricing_data["items"],
            "total_amount": pricing_data["total_amount"]
        }

        return jsonify(order_response), 200

    except Exception as e:
        return jsonify({
            "status": "error",
            "message": str(e)
        }), 400

if __name__ == '__main__':
    app.run(port=5001)
