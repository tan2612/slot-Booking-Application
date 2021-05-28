%dw 2.0
output application/json
---
{
    end: vars.initialPayload.end,
    start: vars.initialPayload.start,
    attendees: (vars.initialPayload.attendees.required.email map()->{
        email: $,
        optional: false
    }) ++ (vars.initialPayload.attendees.optional.email map()->{
        email: $,
        optional: true
    }),
    summary: vars.initialPayload.summary,
    description: vars.initialPayload.description,
    guestCanSeeOtherGuests: vars.initialPayload.guestsCanSeeOtherGuests,
    attachments: vars.initialPayload.attachments
        
}