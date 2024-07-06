import 'package:assignment/providers/event_provider.dart';
import 'package:assignment/providers/profile_provider.dart';
import 'package:provider/provider.dart';

final List<ChangeNotifierProvider<dynamic>> providerConfig = [
  ChangeNotifierProvider(create: (_) => ProfileProvider()),
  ChangeNotifierProvider(create: (_) => EventProvider()),
];
