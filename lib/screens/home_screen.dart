import 'package:assignment/models/event_model.dart';
import 'package:assignment/models/profile_model.dart';
import 'package:assignment/providers/event_provider.dart';
import 'package:assignment/providers/profile_provider.dart';
import 'package:assignment/repositories/profile_repository.dart';
import 'package:assignment/screens/event_calendar_screen.dart';
import 'package:assignment/screens/profile_screen.dart';
import 'package:assignment/services/auth_service.dart';
import 'package:assignment/theme/colors.dart';
import 'package:assignment/theme/fonts.dart';
import 'package:assignment/widgets/components/custom_buttons.dart';
import 'package:assignment/widgets/components/empty_space.dart';
import 'package:assignment/widgets/event_preview.dart';
import 'package:assignment/widgets/header_bar.dart';
import 'package:assignment/widgets/side_bar.dart';
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

  ProfileModel? _userProfile;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    ProfileProvider profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    // await profileProvider.initializeProfile('New1234@gmail.com');
    // _userProfile = profileProvider.userProfile;
    setState(() {
      _userProfile = profileProvider.userProfile;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HeaderBar(
        headerTitle: 'GesT EMS',
        menuRequired: true,
      ),
      endDrawer: CustomSideBar(
        accountName: _userProfile?.username ?? '',
        imageUrl: _userProfile?.username ?? '',
        userType: UserType.user,
        // accountName: _userProfile.username,
        // accountEmail: _userProfile.email,
        // imageUrl: _userProfile.imageLink,
        // userType: _userProfile.type,
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
      body: _widgetList[_selectedIndex],
    );
  }
}

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  final UserType userType = UserType.organizer;

  late EventProvider _eventProvider;

  List<EventModel> _searchResults = sampleEvents;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _eventProvider = Provider.of<EventProvider>(context);
    _eventProvider.getEvents();
    // _searchResults = _eventProvider.events;
  }

  void onQueryChanged(String query) {
    setState(() {
      // _searchResults = _eventProvider.events.where((item) {
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
      if (userType == UserType.organizer) {
        eventsPreview = ListView.builder(
            itemCount: _searchResults.length + 1,
            itemBuilder: (ctx, index) {
              if (index == _searchResults.length) {
                return const VerticalEmptySpace(
                  height: 100,
                );
              }
              return EventPreview(event: _searchResults[index]);
            });
      } else {
        eventsPreview = ListView.builder(
            itemCount: _searchResults.length,
            itemBuilder: (ctx, index) {
              return EventPreview(event: _searchResults[index]);
            });
      }
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
                  // color: Color.fromARGB(255, 234, 234, 234),
                  border: Border(bottom: BorderSide(width: 2)),
                ),
                child: Column(
                  children: [
                    SearchBar(
                      padding: WidgetStateProperty.all(
                          const EdgeInsets.symmetric(
                              vertical: 4.0, horizontal: 16.0)),
                      textStyle: WidgetStateProperty.all(mediumTextStyle),
                      leading: const Icon(Icons.search),
                      backgroundColor: WidgetStateProperty.all(Colors.white),
                      onChanged: onQueryChanged,
                    ),
                    Container(
                        margin: const EdgeInsets.only(top: 12),
                        height: 50,
                        // width: 400,
                        child: GridView.count(
                          childAspectRatio: 5,
                          crossAxisCount: 3,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  value: true,
                                  onChanged: (val) {},
                                  fillColor: WidgetStateProperty.all(
                                      eventStatusColor[EventStatus.scheduled]),
                                ),
                                Text(
                                  'Scheduled',
                                  style: smallTextStyle.copyWith(
                                      color: eventStatusColor[
                                          EventStatus.scheduled]),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  value: true,
                                  onChanged: (val) {},
                                  fillColor: WidgetStateProperty.all(
                                      eventStatusColor[EventStatus.ongoing]),
                                ),
                                Text('Ongoing',
                                    style: smallTextStyle.copyWith(
                                      color:
                                          eventStatusColor[EventStatus.ongoing],
                                    )),
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  value: true,
                                  onChanged: (val) {},
                                  fillColor: WidgetStateProperty.all(
                                      eventStatusColor[EventStatus.completed]),
                                ),
                                Text('Completed',
                                    style: smallTextStyle.copyWith(
                                      color: eventStatusColor[
                                          EventStatus.completed],
                                    )),
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  value: true,
                                  onChanged: (val) {},
                                  fillColor: WidgetStateProperty.all(
                                      eventStatusColor[EventStatus.cancelled]),
                                ),
                                Text(
                                  'Cancelled',
                                  style: smallTextStyle.copyWith(
                                      color: eventStatusColor[
                                          EventStatus.cancelled]),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  value: true,
                                  onChanged: (val) {},
                                  fillColor: WidgetStateProperty.all(
                                      eventStatusColor[EventStatus.postponed]),
                                ),
                                Text(
                                  'Postponed',
                                  style: smallTextStyle.copyWith(
                                      color: eventStatusColor[
                                          EventStatus.postponed]),
                                ),
                              ],
                            ),
                          ],
                        ))
                  ],
                ),
              ),
            ],
          ),
        ),
        Flexible(
            // child: eventsPreview,
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
                  displayText: 'Organize Events',
                  actionOnPressed: () {
                    Navigator.of(context).pushNamed('/organize');
                  }),
            ))
      ],
    );
  }
}

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({super.key});

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  @override
  Widget build(BuildContext context) {
    return const SearchBar();
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
