import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:quick_notes/controllers/dark_mode_controllers.dart';
import 'package:quick_notes/controllers/note_controllers.dart';
import 'package:quick_notes/views/note_create.dart';
import 'package:quick_notes/views/setting_page.dart';
import 'firebase_options.dart';
import 'views/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NotesControllers()),
        ChangeNotifierProvider(create: (_) => DarkModeControllers()..init())
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: Provider.of<DarkModeControllers>(context).currentTheme(),
      // ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
      //   useMaterial3: true,
      // ),
      routes: {
        "/": (context) => HomePage(),
        "/setting": (context) =>  SettingPage(),
        "/createNote": (context) => NoteCreatePage()
      },
    );
  }
}
