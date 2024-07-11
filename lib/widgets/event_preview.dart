import 'package:assignment/models/event_model.dart';
import 'package:assignment/theme/fonts.dart';
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
      child: Container(
        height: 150,
        padding: EdgeInsets.all(5),
        child: Card(
          clipBehavior: Clip.hardEdge,
          shadowColor: Colors.black,
          elevation: 5,
          shape: BeveledRectangleBorder(
            side: BorderSide(color: displayColor[event.status]!, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          // color: displayColor[event.status],
          // surfaceTintColor: displayColor[event.status],
          // surfaceTintColor: Colors.transparent,
          child: InkWell(
            onTap: () {},
            splashColor: displayColor[event.status],
            child: Row(
              children: [
                const Image(
                  image: AssetImage('assets/images/logo.png'),
                  width: 100,
                  height: 100,
                ),
                SingleChildScrollView(
                    // child: RichText(
                    //   text: TextSpan(
                    //     children: [
                    //       TextSpan(text: event.title, style: mediumTextStyle),
                    //       TextSpan(text: event.description, style: smallTextStyle)
                    //     ]
                    //   )
                    // ),
                    child: Column(
                  children: [
                    Wrap(
                      children: [
                        Text(
                          event.title,
                          style: mediumTextStyle,
                        ),
                      ],
                    ),
                    Wrap(
                      children: [
                        Text(
                          event.description,
                          style: smallTextStyle,
                        ),
                      ],
                    ),
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
