from flask import Flask,jsonify,request
import mysql.connector

app = Flask(__name__)
db_config = {"host": "localhost", "user": "root", "password": "", "database": "railway"}


def get_mysql_connection():
    return mysql.connector.connect(**db_config)
@app.route("/train_update",methods=["POST"])
def train_update():
    connection=get_mysql_connection()
    cursor=connection.cursor()
    data=request.get_json()
    train_id=data['id']
    train_name=data['name']
    source=data['source']
    destination=data['destination']
    train_type=data['type']
    try:
        if connection.is_connected():
            cursor=connection.cursor()
            create_train=""" CREATE TABLE IF NOT EXISTS train (
            Train_ID INT NOT NULL PRIMARY KEY,
            train_name varchar(20) NOT NULL,
            source_id INT NOT NULL,
            destination_id INT NOT NULL,
            train_type INT NOT NULL,
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
            FOREIGN KEY (source_id) REFERENCES stations (ID),
            FOREIGN KEY (destination_id) REFERENCES stations (ID),
            FOREIGN KEY (train_type) REFERENCES train_type (ID)
            );"""
            cursor.execute(create_train)
            insert=""" INSERT INTO train(Train_ID,train_name,source_id,destination_id,train_type) VALUES(%s,%s,%s,%s,%s);"""
            cursor.execute(insert,(train_id,train_name,source,destination,train_type))
            connection.commit()
            return jsonify({"message": "Train updated successfully"}), 200
        else:
            print("MySQL connection failed")
            return jsonify({"error": "Unable to connect to MySQL database"}), 500
    except Exception as e:
        print("Error:", e)
        return jsonify({"error": "Internal server error"}), 500
    finally:
        # Close the connection in the finally block to ensure it's always closed
        if connection.is_connected():
            connection.close()
            print("MySQL connection closed")

# @app.route('/train_serach',methods=['GET'])
# def train_serach():


if __name__ == "__main__":
    app.run(host="0.0.0.0", debug=True, port=5000)