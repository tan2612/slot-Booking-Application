%dw 2.0
output application/json
---
payload map{
	(($$)+1) : $.timeslot_start as Time as String{format: "HH:mm"}
}