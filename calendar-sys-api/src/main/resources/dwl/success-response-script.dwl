%dw 2.0
output application/json
---
{
  "status": payload.status,
  "organizer": payload.creator.email,
  "code": attributes.statusCode,
  "message": "Request completed successfully",
  "timestamp": now()
}