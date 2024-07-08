import 'package:assignment/models/event_model.dart';
import 'package:assignment/models/profile_model.dart';
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
        appBar: const HeaderBar(headerTitle: 'GesT EMS', menuRequired: true,),
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
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
          child: _widgetList[_selectedIndex],
        ));
  }
}

class HomeBody extends StatelessWidget {
  HomeBody({super.key});
  final UserType userType = UserType.administrator;

  
  final List<EventModel> _eventList = sampleEvents;
  @override
  Widget build(BuildContext context) {
    Widget eventsPreview;
    if (_eventList.isNotEmpty) {
      eventsPreview = ListView.builder(
          itemCount: _eventList.length,
          itemBuilder: (ctx, index) => EventPreview(event: _eventList[index]));
    } else {
      eventsPreview = const Text("No events found");
    }
    return Column(
      children: [
        IntrinsicHeight(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    const Text(
                      "title",
                      style: titleTextStyle,
                    ),
                    const Text(
                      "header text",
                      style: headerTextStyle,
                    ),
                    const Text(
                      "large text",
                      style: largeTextStyle,
                    ),
                    // const Text(
                    //   "medium text",
                    //   style: mediumTextStyle,
                    // ),
                    // const Text(
                    //   "small text",
                    //   style: smallTextStyle,
                    // ),
                    // const Text(
                    //   "link text",
                    //   style: linkTextStyle,
                    // ),
                    CustomActionButton(
                        displayText: "Testing",
                        actionOnPressed: () {
                          Navigator.of(context).pushNamed('/');
                        })
                    // Flexible(child: CustomLogoutButtonText()),
                    // Flexible(child: CustomLogoutButton()),
                  ],
                ),
              ),
            ],
          ),
        ),
        Flexible(
            child: userType == UserType.organizer ? HomeBodyDisplay(eventsPreview: eventsPreview) : eventsPreview),
      ],
    );
  }
}

class HomeBodyDisplay extends StatelessWidget {
  const HomeBodyDisplay({super.key, required this.eventsPreview});

  final Widget eventsPreview;

  @override
  Widget build(BuildContext context) {
    return Stack(
          children: [
            eventsPreview,
            Align(
              alignment: Alignment.bottomCenter,
              child: ColoredBox(
                color:
                    const Color.fromARGB(255, 216, 216, 216).withOpacity(0.6),
                child: SizedBox(
                  height: 90,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: CustomActionButton(
                      displayText: 'Organize Events', actionOnPressed: () {}),
                ))
          ],
        );
  }
}