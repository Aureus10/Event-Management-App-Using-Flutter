import 'package:assignment/models/event_model.dart';
import 'package:assignment/models/profile_model.dart';
import 'package:assignment/providers/event_provider.dart';
import 'package:assignment/providers/profile_provider.dart';
import 'package:assignment/repositories/profile_repository.dart';
import 'package:assignment/screens/event_calendar_screen.dart';
import 'package:assignment/screens/profile_screen.dart';
import 'package:assignment/theme/colors.dart';
import 'package:assignment/theme/fonts.dart';
import 'package:assignment/widgets/components/custom_buttons.dart';
import 'package:assignment/widgets/event_preview.dart';
import 'package:assignment/widgets/header_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:assignment/data/event_sample.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final List<Widget> _widgetList = <Widget>[
    const HomeBody(),
    const EventCalendarScreen(),
    const ProfileScreen()
  ];

  void _onSelected(int index) => setState(() {
        _selectedIndex = index;
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const HeaderBar(
          headerTitle: 'GesT EMS',
          menuRequired: true,
        ),
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
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: _widgetList[_selectedIndex],
        ));
  }
}

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  final UserType userType = UserType.administrator;

  // late EventProvider _eventProvider;

  List<EventModel> _searchResults = sampleEvents;

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   _eventProvider = Provider.of<EventProvider>(context);
  // }

  void onQueryChanged(String query) {
    setState(() {
      // searchResults = eventProvider.events.where((item) {
      _searchResults = sampleEvents.where((item) {
        bool matchesTitle =
            item.title.toLowerCase().contains(query.toLowerCase());
        bool matchesDescription =
            item.description.toLowerCase().contains(query.toLowerCase());
        return matchesTitle || matchesDescription;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget eventsPreview;
    if (_searchResults.isNotEmpty) {
      eventsPreview = ListView.builder(
          itemCount: _searchResults.length,
          itemBuilder: (ctx, index) =>
              EventPreview(event: _searchResults[index]));
    } else {
      eventsPreview = const Text("No events found");
    }
    return Column(
      children: [
        IntrinsicHeight(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(10, 28, 10, 18),
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 234, 234, 234),
                  border: Border(bottom: BorderSide(width: 2)),
                ),
                child: Column(
                  children: [
                    Container(
                      // color: Colors.white,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFF444CB4), width: 2),
                        borderRadius: const BorderRadius.all(Radius.circular(8)),
                        color: Colors.white,
                      ),
                      child: TextField(
                        onChanged: onQueryChanged,
                        decoration: const InputDecoration(
                          labelText: 'Search',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.search),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Flexible(
            child: userType == UserType.organizer
                ? HomeBodyDisplay(eventsPreview: eventsPreview)
                : eventsPreview),
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
            color: const Color.fromARGB(255, 216, 216, 216).withOpacity(0.6),
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

// class SearchEvent extends StatefulWidget {
//   const SearchEvent({super.key});

//   @override
//   State<SearchEvent> createState() => _SearchEventState();
// }

// class _SearchEventState extends State<SearchEvent> {
//   late EventProvider eventProvider;

//   List<EventModel> searchResults = [];

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     eventProvider = Provider.of<EventProvider>(context);
//   }

//   void onQueryChanged(String query) {
//     setState(() {
//       // searchResults = eventProvider.events.where((item) {
//       searchResults = sampleEvents.where((item) {
//         bool matchesTitle =
//             item.title.toLowerCase().contains(query.toLowerCase());
//         bool matchesDescription =
//             item.description.toLowerCase().contains(query.toLowerCase());
//         return matchesTitle || matchesDescription;
//       }).toList();
//     });
//   }



//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Row(
//           children: [],
//         ),
//         EventPreview(event: )
//       ],
//     );
//   }
// }
