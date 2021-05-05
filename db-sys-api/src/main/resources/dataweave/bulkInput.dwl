%dw 2.0
output application/json
---
payload map {
	slot_date: $.slot_date,
	timeslot_start: $.timeslot_start ,
	timeslot_end: $.timeslot_end,
	emp_id: $.emp_id
}