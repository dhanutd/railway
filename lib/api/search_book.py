from flask import Flask,jsonify,request
from datetime import datetime, timedelta
import mysql.connector
app=Flask(__name__)
db_config={"host":"localhost","user":"root","password":"","database":"railway"}
def get_connection():
    return mysql.connector.connect(**db_config)
@app.route('/Search_book', methods=["GET"])
def Search_book():
    connection=get_connection()
    cursor=connection.cursor()
    from_station=int(request.args.get('from_station'))
    to_station=int(request.args.get('to_station'))
    try:
        if connection.is_connected():
            query=f"""SELECT train.Train_ID,train.train_name,train_type.description,
            (SELECT COUNT(*) FROM train_route WHERE train_id = train.Train_ID AND sort_order BETWEEN {from_station} AND {to_station} AND {to_station}>{from_station}) AS intermediate_count,
            MAX(CASE WHEN intermediate = {from_station} THEN arrival_time END) AS from_time,
            MAX(CASE WHEN intermediate = {to_station} THEN arrival_time END) AS destination_time,
            (SELECT stationname from stations WHERE ID={from_station})AS from_station_name,(SELECT stationname from stations WHERE ID={to_station})AS to_station_name
            FROM train
            JOIN train_type ON train.train_type = train_type.ID
            LEFT JOIN train_route ON train.Train_ID = train_route.train_id
            WHERE train.Train_ID IN ( SELECT t1.train_id FROM train_route t1 JOIN train_route t2 ON t1.train_id = t2.train_id
            WHERE t1.intermediate = {from_station} AND t2.intermediate = {to_station} and t1.sort_order < t2.sort_order)
            GROUP BY train.Train_ID, train.train_name, train_type.description; 	"""
            cursor.execute(query)
            data=cursor.fetchall()
            return jsonify(data)
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
        

@app.route('/Prices_date', methods=['GET'])
def Prices_date():
    connection=get_connection()
    cursor=connection.cursor()
    intermediate_station=int(request.args.get('intermediate_station'))
    train_id=int(request.args.get('train_id'))
    coach=str(request.args.get('coach'))
    intermediate_station=intermediate_station-1
    
    try:
        if connection.is_connected():
            query=f"""SELECT DISTINCT cs.coach, cs.toatalseat, tp.prices,UPPER(st.types) as Types FROM coach_details AS cs
            JOIN train_price AS tp ON cs.seattype = tp.seattype and cs.train_type=tp.traintype join train_seat_types as st on cs.seattype=st.seat_id
            WHERE cs.train_id = {train_id};"""
            cursor.execute(query)
            data=cursor.fetchall()
            data = [list(t) for t in data]
            print(data)
            for i in range(len(data)):
                data[i][2]=data[i][2]*intermediate_station
            current_date = datetime.now().date()
            next_four_dates = [(current_date + timedelta(days=i)).strftime("%m-%d") for i in range(1, 4)] 
            date_list = [current_date.strftime("%m-%d")] + list(map(str, next_four_dates))
            final_list=[]
            for i in date_list:
                use=[]
                for j in data:
                    coach_data=str(j[0])
                    if coach == j[0]:
                        print(coach)
                        query2=f"""SELECT no_passanger FROM booking_histroy WHERE train_id={train_id} AND seat_type='{coach}' AND booking_date='{i}';"""
                        cursor.execute(query2)
                        seat_data=cursor.fetchall()
                        print(seat_data)
                        count=0
                        for s in seat_data:
                            count=count+s[0]
                        print(count)
                        use.append(i)
                        seat=j[1]-count
                        use.append(seat)
                        price=j[2]
                        use.append(price)
                        use.append(coach)
                        final_list.append(use)
            print(final_list)
            return jsonify(final_list)
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
@app.route('/My_booking',methods=['GET'])
def My_booking():
    connection=get_connection()
    cursor=connection.cursor()
    user_id=request.args.get('user_id')
    try:
        if connection.is_connected():
            query=f"""SELECT * FROM booking_histroy where user_id='{user_id}';"""
            cursor.execute(query)
            data=cursor.fetchall()
            return jsonify(data)
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
    
