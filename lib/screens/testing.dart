// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:table_calendar/table_calendar.dart';

// class EventCalendarScreen extends StatefulWidget {
//   const EventCalendarScreen({super.key});

//   @override
//   _EventCalendarScreenState createState() => _EventCalendarScreenState();
// }

// class _EventCalendarScreenState extends State<EventCalendarScreen> {
//   CalendarFormat _calendarFormat = CalendarFormat.month;
//   DateTime _focusedDay = DateTime.now();
//   DateTime? _selectedDay;
//   List<Map<String, dynamic>> _events = [];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Event Calendar'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.menu),
//             onPressed: () {
//               // Add your menu action here
//             },
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               decoration: InputDecoration(
//                 prefixIcon: const Icon(Icons.search),
//                 hintText: 'Search by Keyword',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10.0),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 16.0),
//             TableCalendar(
//               firstDay: DateTime.utc(2010, 10, 16),
//               lastDay: DateTime.utc(2030, 3, 14),
//               focusedDay: _focusedDay,
//               calendarFormat: _calendarFormat,
//               selectedDayPredicate: (day) {
//                 return isSameDay(_selectedDay, day);
//               },
//               onDaySelected: (selectedDay, focusedDay) {
//                 setState(() {
//                   _selectedDay = selectedDay;
//                   _focusedDay = focusedDay;
//                 });
//                 _loadEvents(selectedDay);
//               },
//               onFormatChanged: (format) {
//                 if (_calendarFormat != format) {
//                   setState(() {
//                     _calendarFormat = format;
//                   });
//                 }
//               },
//               onPageChanged: (focusedDay) {
//                 _focusedDay = focusedDay;
//               },
//             ),
//             const SizedBox(height: 16.0),
//             if (_events.isNotEmpty)
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: _events.map((event) {
//                   return Card(
//                     child: ListTile(
//                       title: Text(event['title']),
//                       subtitle: Text(event['description']),
//                     ),
//                   );
//                 }).toList(),
//               )
//             else
//               const Text('No events for this day'),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<void> _loadEvents(DateTime selectedDay) async {
//     final FirebaseFirestore firestore = FirebaseFirestore.instance;
//     final String formattedDate = "${selectedDay.year}-${selectedDay.month}-${selectedDay.day}";

//     try {
//       QuerySnapshot snapshot = await firestore
//           .collection('events')
//           .where('date', isEqualTo: formattedDate)
//           .get();

//       setState(() {
//         _events = snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
//       });
//     } catch (e) {
//       print('Error fetching events: $e');
//     }
//   }
// }