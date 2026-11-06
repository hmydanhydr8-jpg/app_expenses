import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:nobody/models/list_colors.dart';
import 'package:nobody/widgets/data.dart';
import 'package:nobody/widgets/tab_bar_screen.dart';

final ValueNotifier<bool> darkModeNotifier = ValueNotifier(false);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final saved = await readSwitches();
  theDarkMode = saved;
  darkModeNotifier.value = saved;
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: darkModeNotifier,
      builder: (context, isDark, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: [
            GlobalCupertinoLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: [Locale("ar"), Locale("en")],
          locale: const Locale("ar"),
          theme: ThemeData(
            primaryColor: isDark
                ? darkColors["primary"]
                : lightColors["primary"],
          ),
          home: TabBarScreen(),
        );
      },
    );
  }
}
