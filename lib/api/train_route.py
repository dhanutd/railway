from flask import Flask,jsonify,request
import mysql.connector
app=Flask(__name__)
db_config={"host":"localhost","user":"root","password":"","database":"railway"}
def get_connecton():
    return mysql.connector.connect(**db_config)
@app.route('/route_update',methods=['POST'])
def route_update():
    connection=get_connecton()
    data=request.get_json()
    train_id=data['train_id']
    intermediate=data['intermediate']
    sort_order=data['sortorder']
    arrival_time=data['arrivaltime']
    try:
        if connection.is_connected():
            cursor=connection.cursor()
            create_table="""CREATE TABLE IF NOT EXISTS train_route(ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,train_id INT NOT NULL,intermediate INT NOT NULL,sort_order INT,arrival_time Varchar(30),
            FOREIGN KEY (train_id) REFERENCES train (Train_ID));"""
            cursor.execute(create_table)
            insert="""INSERT INTO train_route(train_id,intermediate,sort_order,arrival_time)VALUES(%s,%s,%s,%s);"""
            cursor.execute(insert,(train_id,intermediate,sort_order,arrival_time))
            connection.commit()
            return jsonify({"message":"train route update suceefull"}),200
        else:
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