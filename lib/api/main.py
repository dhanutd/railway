from flask import Flask, jsonify, request
import mysql.connector

app = Flask(__name__)

# MySQL Configuration
db_config = {"host": "localhost", "user": "root", "password": "", "database": "railway"}


def get_mysql_connection():
    return mysql.connector.connect(**db_config)
# Update station information 
@app.route("/Station_update", methods=["POST"])
def Station_upadate():
    connection = get_mysql_connection()
    data = request.get_json()

    code=data['stationcode']
    name=data['stationname']
    platform=data['noplatform']
    ticket=data['noticketcounter']
    try:
        if connection.is_connected():
            print("Connected to MySQL database")

            
            cursor=connection.cursor()
            create_table = """CREATE TABLE IF NOT EXISTS stations(
            ID INT AUTO_INCREMENT PRIMARY KEY, 
            stationcode varchar(10) NOT NULL, 
            stationname varchar(20) NOT NULL, 
            noplatform INT, 
            ticketcounter INT,
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
            );"""

            cursor.execute(create_table)
            insert="INSERT INTO stations(stationcode,stationname,noplatform,ticketcounter) VALUES (%s,%s,%s,%s);"
            cursor.execute(insert,(code,name,platform,ticket))
            connection.commit()
            return jsonify({"message": "Station updated successfully"}), 200

            
        
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




if __name__ == "__main__":
    app.run(host="0.0.0.0", debug=True, port=5000)