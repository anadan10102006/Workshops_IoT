
import os
import psycopg
from flask import Flask, jsonify, request

app = Flask(__name__)

INSTANCE = os.getenv("INSTANCE", "api-local")

DB_HOST = os.getenv("DB_HOST", "db")
DB_NAME = os.getenv("DB_NAME", "shop")
DB_USER = os.getenv("DB_USER", "postgres")
DB_PASSWORD = os.getenv("DB_PASSWORD", "postgres")


def get_connection():
    return psycopg.connect(
        host=DB_HOST,
        dbname=DB_NAME,
        user=DB_USER,
        password=DB_PASSWORD
    )


@app.route("/products", methods=["GET"])
def get_products():
    try:
        with get_connection() as conn:
            with conn.cursor() as cursor:
                cursor.execute(
                    "SELECT id, name, price FROM products ORDER BY id"
                )
                rows = cursor.fetchall()

        products = [
            {
                "id": row[0],
                "name": row[1],
                "price": float(row[2])
            }
            for row in rows
        ]

        return jsonify({
            "served_by": INSTANCE,
            "products": products
        })

    except Exception as e:
        return jsonify({"error": str(e)}), 500


@app.route("/products/<int:product_id>", methods=["GET"])
def get_product(product_id):
    try:
        with get_connection() as conn:
            with conn.cursor() as cursor:
                cursor.execute(
                    "SELECT id, name, price FROM products WHERE id = %s",
                    (product_id,)
                )
                row = cursor.fetchone()

        if row is None:
            return jsonify({"error": "Producto no encontrado"}), 404

        return jsonify({
            "served_by": INSTANCE,
            "product": {
                "id": row[0],
                "name": row[1],
                "price": float(row[2])
            }
        })

    except Exception as e:
        return jsonify({"error": str(e)}), 500


@app.route("/products", methods=["POST"])
def create_product():
    try:
        data = request.get_json()

        if not data or "name" not in data or "price" not in data:
            return jsonify({"error": "Faltan datos"}), 400

        with get_connection() as conn:
            with conn.cursor() as cursor:
                cursor.execute(
                    """
                    INSERT INTO products (name, price)
                    VALUES (%s, %s)
                    RETURNING id, name, price
                    """,
                    (data["name"], data["price"])
                )
                row = cursor.fetchone()

        return jsonify({
            "served_by": INSTANCE,
            "product": {
                "id": row[0],
                "name": row[1],
                "price": float(row[2])
            }
        }), 201

    except Exception as e:
        return jsonify({"error": str(e)}), 500


@app.route("/products/<int:product_id>", methods=["PUT"])
def update_product(product_id):
    try:
        data = request.get_json()

        if not data or "name" not in data or "price" not in data:
            return jsonify({"error": "Faltan datos"}), 400

        with get_connection() as conn:
            with conn.cursor() as cursor:
                cursor.execute(
                    """
                    UPDATE products
                    SET name = %s, price = %s
                    WHERE id = %s
                    RETURNING id, name, price
                    """,
                    (data["name"], data["price"], product_id)
                )
                row = cursor.fetchone()

        if row is None:
            return jsonify({"error": "Producto no encontrado"}), 404

        return jsonify({
            "served_by": INSTANCE,
            "product": {
                "id": row[0],
                "name": row[1],
                "price": float(row[2])
            }
        })

    except Exception as e:
        return jsonify({"error": str(e)}), 500


@app.route("/products/<int:product_id>", methods=["DELETE"])
def delete_product(product_id):
    try:
        with get_connection() as conn:
            with conn.cursor() as cursor:
                cursor.execute(
                    "DELETE FROM products WHERE id = %s RETURNING id",
                    (product_id,)
                )
                row = cursor.fetchone()

        if row is None:
            return jsonify({"error": "Producto no encontrado"}), 404

        return jsonify({
            "served_by": INSTANCE,
            "message": "Producto eliminado",
            "id": row[0]
        })

    except Exception as e:
        return jsonify({"error": str(e)}), 500


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)

