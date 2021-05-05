%dw 2.0
output application/json

fun getNoOfSlots(hour, duration) = 
    ((((hour as Number)*60)/duration)) as String {format: "#"} as Number

fun prepareList(list:Array, maxSize: Number) = 
	if(sizeOf(list) >= maxSize ) 
		list
	else
		prepareList(list ++ [(sizeOf(list)) as Number],maxSize)

fun noOfDays(startDate , endDate)= 
{
    y: startDate as String {format: "MM/dd/yyyy"}, 
    x: if(startDate == endDate) startDate else noOfDays(startDate + |P1D|, endDate)
}

var dates = noOfDays(payload.start_date as Date {format: "MM/dd/yyyy"}, payload.end_date as Date {format: "MM/dd/yyyy"})..y

var dur = payload.duration_in_minutes
var duration_in_period = "PT" ++ (dur as String) ++ "M"

var noOfSlots = payload.timeslots.hours map (hour, index) -> {
    a: getNoOfSlots(hour, dur)
}.a

var slot_num_list = noOfSlots map(slot, index) ->{
    a: prepareList([], slot)
}.a

var start_time = payload.timeslots.start_time
var size = prepareList([], sizeOf(start_time)) 
var slotsPerDay = flatten(size map(object, index) -> {
    a: slot_num_list[index] map(slot) ->{
        b: start_time[index] as LocalTime+ ("PT" ++ (slot*dur) as String ++ "M")  
        
    }.b
}.a)
---
//dates
//slotsPerDay
flatten(dates map(date) ->{
    a: slotsPerDay map(slot_start) ->{
        emp_id: payload.emp_id,
        slot_date: date as Date {format: "MM/dd/yyyy"} as String {format: "yyyy-MM-dd"},
        timeslot_start: slot_start,
        timeslot_end: slot_start + duration_in_period
    }
}.a)


