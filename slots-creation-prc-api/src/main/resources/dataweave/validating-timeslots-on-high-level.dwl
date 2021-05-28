%dw 2.0
import * from dw::Runtime
output application/json
---
if(sizeOf(payload.timeslots.start_time) == sizeOf(payload.timeslots.hours)) payload
else 
    fail("Timeslots section is not correct")