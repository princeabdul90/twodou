import 'package:flutter/material.dart';

import 'ui/main_screen.dart';
import 'ui/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final theme = TwoDouTheme.globalTheme();

    return MaterialApp(
      title: 'Twodou',
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: const MainScreen(),
    );
  }
}
