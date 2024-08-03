import 'package:assignment/models/request_model.dart';
import 'package:assignment/providers/request_provider.dart';
import 'package:assignment/theme/fonts.dart';
import 'package:assignment/widgets/components/custom_buttons.dart';
import 'package:assignment/widgets/components/empty_space.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ManageRequestScreen extends StatefulWidget {
  const ManageRequestScreen({super.key});

  @override
  State<ManageRequestScreen> createState() => _ManageRequestScreenState();
}

class _ManageRequestScreenState extends State<ManageRequestScreen> {
  late RequestProvider _requestProvider;

  List<BaseRequestModel> _searchResults = [];
  String _searchQuery = '';
  final Map<String, bool> _requestTypeFilter = {
    'Feedback': true,
    'Report': true,
    'Organizer Role Requests': true,
  };
  final Map<String, Color> _requestTypeColor = {
    'Feedback': Colors.amber,
    'Report': Colors.red,
    'Organizer Role Requests': Colors.blue,
  };
  final Map<String, bool> _requestStatusFilter = {
    'Pending Review': true,
    'Reviewed': false,
    'Approved': false,
    'Rejected': false,
  };

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _requestProvider = Provider.of<RequestProvider>(context);
    _requestProvider.getRequests();
  }

  void onQueryChanged(String query) {
    _searchQuery = query;
    setState(() {
      _searchResults = _requestProvider.requests.where((item) {
        bool matchesTitle =
            item.id!.toLowerCase().contains(query.toLowerCase());
        bool matchesDescription =
            item.description!.toLowerCase().contains(query.toLowerCase());
        bool matchesType = _requestTypeFilter[item.type] ?? false;
        bool matchesStatus = _requestStatusFilter[item.status] ?? false;
        return (matchesTitle || matchesDescription) &&
            matchesType &&
            matchesStatus;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget requestPreview;
    if (_searchResults.isNotEmpty) {
      requestPreview = ListView.builder(
          itemCount: _searchResults.length,
          itemBuilder: (ctx, index) {
            return RequestPreview(requestId: _searchResults[index].id!, requestDate: _searchResults[index].date, status: _searchResults[index].status, requestType: _searchResults[index].type);
          });
    } else {
      requestPreview = const Text("No events found");
      onQueryChanged(_searchQuery);
    }
    return Column(children: [
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
                    padding: WidgetStateProperty.all(const EdgeInsets.symmetric(
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
                        crossAxisCount: 2,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: _requestTypeFilter['Feedback'],
                                onChanged: (val) {
                                  _requestTypeFilter['Feedback'] = val!;
                                  onQueryChanged(_searchQuery);
                                },
                                fillColor: WidgetStateProperty.all(
                                    _requestTypeColor['Feedback']),
                              ),
                              Text(
                                'Scheduled',
                                style: smallTextStyle.copyWith(
                                    color: _requestTypeColor['Feedback']),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                value: _requestTypeFilter['Report'],
                                onChanged: (val) {
                                  _requestTypeFilter['Report'] = val!;
                                  onQueryChanged(_searchQuery);
                                },
                                fillColor: WidgetStateProperty.all(
                                    _requestTypeColor['Report']),
                              ),
                              Text('Ongoing',
                                  style: smallTextStyle.copyWith(
                                    color: _requestTypeColor['Report'],
                                  )),
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                value: _requestTypeFilter[
                                    'Organizer Role Requests'],
                                onChanged: (val) {
                                  _requestTypeFilter[
                                      'Organizer Role Requests'] = val!;
                                  onQueryChanged(_searchQuery);
                                },
                                fillColor: WidgetStateProperty.all(
                                    _requestTypeColor[
                                        'Organizer Role Requests']),
                              ),
                              Text('Completed',
                                  style: smallTextStyle.copyWith(
                                    color: _requestTypeColor[
                                        'Organizer Role Requests'],
                                  )),
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                value: _requestStatusFilter['Pending Review'],
                                onChanged: (val) {
                                  _requestStatusFilter['Pending Review'] = val!;
                                  _requestStatusFilter['Reviewed'] = !val;
                                  _requestStatusFilter['Approved'] = !val;
                                  _requestStatusFilter['Rejected'] = !val;
                                  onQueryChanged(_searchQuery);
                                },
                                fillColor:
                                    WidgetStateProperty.all(Colors.lightGreen),
                              ),
                              Text('Reviewed',
                                  style: smallTextStyle.copyWith(
                                    color: Colors.lightGreen,
                                  )),
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
      requestPreview
    ]);
  }
}

class RequestPreview extends StatelessWidget {
  const RequestPreview({
    super.key,
    required this.requestId,
    required this.requestDate,
    required this.status,
    required this.requestType,
  });

  final String requestId;
  final String requestDate;
  final String status;
  final String requestType;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: EdgeInsets.all(16.0),
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Request ID: $requestId',
            style: mediumTextStyle,
          ),
          Text(
            'Request Date: $requestDate',
            style: mediumTextStyle,
          ),
          Text(
            'Status: $status',
            style: mediumTextStyle,
          ),
          Text(
            'Request Type: $requestType',
            style: mediumTextStyle,
          ),
          const VerticalEmptySpace(),
          Align(
            alignment: Alignment.bottomRight,
            child: CustomActionButton(
              displayText: "View",
              actionOnPressed: () {
                Navigator.of(context).pushNamed('/view_request', arguments: requestId);
              },
              width: 70,
              height: 40,
            ),
          ),
        ],
      ),
    );
  }
}
