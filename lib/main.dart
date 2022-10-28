import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:logging/logging.dart';
import 'package:twodou_app/feature/task/presentation/provider/repository_implementation.dart';
import 'feature/category/presentation/provider/category_repository_provider.dart';
import 'package:twodou_app/utility/theme.dart';
import 'feature/app.dart';


Future<void> main() async {
  _setupLogging();
  WidgetsFlutterBinding.ensureInitialized();

  final repository = CategoryRepositoryProvider();
  final taskRepository = TaskRepositoryProvider();

  await repository.init();
  await taskRepository.init();

  runApp(MyApp(repository: repository, taskRepositoryProvider: taskRepository,));
}

void _setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
}

class MyApp extends StatelessWidget {
  final CategoryRepositoryProvider repository;
  final TaskRepositoryProvider taskRepositoryProvider;
  const MyApp({Key? key, required this.repository, required this.taskRepositoryProvider}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final theme = TwoDouTheme.globalTheme();

    return MultiProvider(
      providers: [
        Provider<CategoryRepositoryProvider>(
          lazy: false,
          create: (_) => repository,
          dispose: (_, CategoryRepositoryProvider repository) => repository.close(),
        ),

        Provider<TaskRepositoryProvider>(
          lazy: false,
          create: (_) => taskRepositoryProvider,
          dispose: (_, TaskRepositoryProvider taskRepository) => taskRepository.close(),
        ),

        //ChangeNotifierProvider(create: (_) => taskRepositoryProvider,)

      ],
      child: MaterialApp(
        title: 'Twodou',
        debugShowCheckedModeBanner: false,
        theme: theme,
        home: const App(),
      ),
    );
  }
}
