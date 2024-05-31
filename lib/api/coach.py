from flask import Flask,jsonify,request
import mysql.connector
app=Flask(__name__)
db_config={"host":"localhost","user":"root","password":"","database":"railway"}
def get_connection():
    return mysql.connector.connect(**db_config)
@app.route('/coach_update',methods=['POST'])
def coach_update():
    connection=get_connection()
    data=request.get_json()
    train_id=data['trainid']
    coach=data['coach']
    seat_type=data['seattype']
    total_seat=data['totalseat']
    try:
        if connection.is_connected():
            cursor=connection.cursor()
            create_table="""CREATE TABLE IF NOT EXISTS coach_details(ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,train_id INT NOT NULL,coach varchar(10)NOT NULL,seattype INT NOT NULL,toatalseat INT NOT NULL,
            FOREIGN KEY (train_id) REFERENCES train (Train_ID),FOREIGN KEY (seattype) REFERENCES train_seat_types (seat_id));"""
            cursor.execute(create_table)
            insert="""INSERT INTO coach_details(train_id,coach,seattype,toatalseat)VALUES(%s,%s,%s,%s);"""
            cursor.execute(insert,(train_id,coach,seat_type,total_seat))
            connection.commit()
            return jsonify({"message": "coach deatails updated successfully"}), 200
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