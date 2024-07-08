import 'package:assignment/models/event_model.dart';
import 'package:flutter/material.dart';

class EventPreview extends StatelessWidget {
  const EventPreview({super.key, required this.event});

  final EventModel event;
  static const Map<EventStatus, Color> displayColor = {
    EventStatus.cancelled: Color.fromARGB(255, 255, 66, 66),
    EventStatus.completed: Color.fromARGB(255, 199, 194, 194),
    EventStatus.ongoing: Color.fromARGB(255, 120, 255, 125),
    EventStatus.postponed: Color.fromARGB(255, 255, 238, 86),
    EventStatus.scheduled: Color.fromARGB(255, 113, 191, 255)
  };

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        clipBehavior: Clip.hardEdge,
        color: displayColor[event.status]!.withAlpha(180),
        child: InkWell(
          onTap: () {},
          splashColor: displayColor[event.status],
          child: const Column(
            children: [
              ListTile(
                leading: Image(
                  image: AssetImage('assets/images/logo.png'),
                  width: 288,
                  height: 288,
                ),
                title: Text("testing123"),
                subtitle: Text("texting234"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
