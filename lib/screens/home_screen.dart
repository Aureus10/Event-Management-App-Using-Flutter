import 'package:assignment/models/event_model.dart';
import 'package:assignment/screens/event_calendar_screen.dart';
import 'package:assignment/screens/profile_screen.dart';
import 'package:assignment/theme/colors.dart';
import 'package:assignment/theme/fonts.dart';
import 'package:assignment/widgets/components/custom_buttons.dart';
import 'package:assignment/widgets/event_preview.dart';
import 'package:assignment/widgets/header_bar.dart';
import 'package:flutter/material.dart';
import 'package:assignment/data/event_sample.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final List<Widget> _widgetList = <Widget>[
    HomeBody(),
    const EventCalendarScreen(),
    const ProfileScreen()
  ];

  void _onSelected(int index) => setState(() {
        _selectedIndex = index;
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const HeaderBar(headerTitle: 'GesT EMS'),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 28,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.calendar_month,
                size: 28,
              ),
              label: 'Event Calendar',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.account_circle,
                size: 28,
              ),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: CustomizedColors.selectedColor,
          unselectedItemColor: CustomizedColors.unselectedColor,
          onTap: _onSelected,
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
          child: _widgetList[_selectedIndex],
        ));
  }
}

class HomeBody extends StatelessWidget {
  HomeBody({super.key});
  final List<EventModel> eventList = sampleEvents;
  @override
  Widget build(BuildContext context) {
    Widget eventsPreview;
    if (eventList.isNotEmpty) {
      eventsPreview = ListView.builder(
          itemCount: eventList.length,
          itemBuilder: (ctx, index) => EventPreview(event: eventList[index]));
    } else {
      eventsPreview = const Text("No events found");
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IntrinsicHeight(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Text(
                  "title",
                  style: titleTextStyle,
                ),
                Text(
                  "header text",
                  style: headerTextStyle,
                ),
                Text(
                  "large text",
                  style: largeTextStyle,
                ),
                Text(
                  "medium text",
                  style: mediumTextStyle,
                ),
                Text(
                  "small text",
                  style: smallTextStyle,
                ),
                Text(
                  "link text",
                  style: linkTextStyle,
                ),
                CustomActionButton(displayText: "Testing", actionOnPressed: () {
                  Navigator.of(context).pushNamed('/');
                })
                // Flexible(child: CustomLogoutButtonText()),
                // Flexible(child: CustomLogoutButton()),
              ],
            ),
          ),
        ),
        Flexible(child: eventsPreview),
      ],
    );
  }
}
