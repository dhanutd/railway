date_list=['03-06','03-07','03-08','03-09']
final_list=[]
coach="B"
sql=3
data=[['B', 25, 100, '2S'], ['C', 25, 100, '2S'], ['D', 20, 150, 'SL'], ['E', 20, 250, 'AC']]
for i in date_list:
    use=[]
    for j in data:
        print(coach,j[0])
        if coach==j[0]:
           print(type(j[0]),type(coach))
           use.append(i)
           seat=j[1]-3
           use.append(seat)
           price=j[2]
           use.append(price)
           final_list.append(use)

print(final_list)
