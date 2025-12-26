from flask import Flask, request, jsonify
from common.db import get_db_connection
import requests

app = Flask(__name__)

@app.route('/api/notifications/send', methods=['POST'])
def send_notification():
    data = request.get_json()
    order_id = data['order_id']
    customer_id = data['customer_id']


    customer_res = requests.get(
        f"http://localhost:5004/api/customers/{customer_id}"
    )
    customer = customer_res.json()


    inventory_res = requests.get(
        "http://localhost:5002/api/inventory/check/1"
    )
    inventory = inventory_res.json()

    message = (
        f"Order #{order_id} confirmed.\n"
        f"Product: {inventory['product_name']}\n"
        f"Estimated Delivery: 3 days"
    )


    print(f"EMAIL SENT TO: {customer['email']}")
    print(f"Subject: Order #{order_id} Confirmed")
    print(f"Body: {message}")

    # 5️⃣ Log to database
    conn = get_db_connection()
    cursor = conn.cursor()

    cursor.execute(
        """
        INSERT INTO notification_log
        (order_id, customer_id, notification_type, message)
        VALUES (%s, %s, %s, %s)
        """,
        (order_id, customer_id, "EMAIL", message)
    )
    conn.commit()

    cursor.close()
    conn.close()

    return jsonify({
        "status": "success",
        "message": "Notification sent and logged"
    })


if __name__ == '__main__':
    app.run(port=5005)
