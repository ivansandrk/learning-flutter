# Learning Flutter/Dart by isandrk

Experimenting with Flutter concepts. Drawing, handling input, moving stuff around.

## Notes

### TODOs

* Tests
  * Some unittests, some integration tests (Flutter framework)

### Event system (vs message system?)

Event system is pull based, message system is push based. They change the order of dependence. Example:

Event system:
* Graphics subsystem would need to listen for events coming from the Logic subsystem which seems wonky?
  * Events are public on the Logic
  * ... or Logic sends an Event defined on the Graphics?
  * ... what is really the difference between Event and Message here? Maybe just semantics and how we call them?

Message system:
* Logic subsystem sends a message to the Graphics subsystem
  * Messages are public on the Graphics

Conclusion:
* Event and Message ideas are complimentary, use them both.
* Events defined in the current system and broadcast by it;
* Messages defined in the target system and sent by someone else.
* EventMessageSystem / MessageEventBus

Notes for events:
* Event bus
* Input events
* Vsync event (used for running the game loop)
