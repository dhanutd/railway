from flask import Flask,jsonify,request
import mysql.connector
app=Flask(__name__)
db_config={"host":"localhost","user":"root","password":"","database":"railway"}
def get_connectionn():
    return mysql.connector.connect(**db_config)
@app.route('/Booking_history', methods=["POST"])
def Booking_history():
    connection=get_connectionn()
    data=request.get_json()
    userid=data['uid']
    ticket_number=data['ticketnumber']
    phone=data['phone']
    trainid=data['trainid']
    trainname=data['trainname']
    booking_date=data['bookingdate']
    seattype=data['seattype']
    no_passanger=data['no_passanger']
    payment=data['payment']
    from_station=data['from_station']
    to_station=data['to_station']
    from_time=data['from_time']
    to_time=data['to_time']
    try:
        cursor=connection.cursor()
        if connection.is_connected():
            createtable="""CREATE TABLE  IF NOT EXISTS booking_histroy(ID INT AUTO_INCREMENT NOT NULL PRIMARY KEY,user_id VARCHAR(50) not null,ticket_id varchar(20) NOT NULL,
            phone int(10) NOT NULL,train_id int not null,trainname varchar(20) not null,booking_date varchar(20),
            seat_type varchar(5) not null,no_passanger int,payment varchar(50) not null,from_station varchar(20),to_station varchar(20),from_time varchar(20),to_time varchar(20));"""
            cursor.execute(createtable)
            insert="""INSERT INTO booking_histroy(user_id,ticket_id,phone,train_id,trainname,booking_date,seat_type,no_passanger,payment,from_station,to_station,from_time,to_time) VALUES(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s);"""
            cursor.execute(insert,(userid,ticket_number,phone,trainid,trainname,booking_date,seattype,no_passanger,payment,from_station,to_station,from_time,to_time))
            connection.commit()
            return jsonify({"message": "booking_deatial is  updated successfully"}), 200
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