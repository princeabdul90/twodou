import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:logging/logging.dart';

import 'data/sqlite/sqlite_repository.dart';
import 'data/repository.dart';
import 'ui/main_screen.dart';
import 'ui/theme.dart';


Future<void> main() async {
  _setupLogging();
  WidgetsFlutterBinding.ensureInitialized();

  final repository = SqliteRepository();
  await repository.init();
  runApp(MyApp(repository: repository));
}

void _setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
}

class MyApp extends StatelessWidget {
  final Repository repository;
  const MyApp({Key? key, required this.repository}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final theme = TwoDouTheme.globalTheme();

    return MultiProvider(
      providers: [
        Provider<Repository>(
          lazy: false,
          create: (_) => repository,
          dispose: (_, Repository repository) => repository.close(),
        ),


      ],
      child: MaterialApp(
        title: 'Twodou',
        debugShowCheckedModeBanner: false,
        theme: theme,
        home: const MainScreen(),
      ),
    );
  }
}
