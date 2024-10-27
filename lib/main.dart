import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:samad_blood_bank/firebase_options.dart';
import 'package:samad_blood_bank/screen/splash_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp(
     options: DefaultFirebaseOptions.currentPlatform

   );
  final appDocumentDirectory =
  await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  if (!Hive.isBoxOpen('langBox')) {
    Hive.openBox('langBox');
  }
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

  static void setTheme(BuildContext context, ThemeMode themeMode) {
    final _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setTheme(themeMode);
  }

  // Adding a static method to access the _MyAppState from outside
  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }
}



class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('bn');
  ThemeMode _themeMode = ThemeMode.system;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void setTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }

  void initLangLocale() async {
    if (!Hive.isBoxOpen('langBox')) {
      await Hive.openBox('langBox');
    }
    setState(() {
      _locale = Locale.fromSubtags(
          languageCode:
          Hive.box('langBox').get('langCode', defaultValue: 'bn'));
    });
  }

  // Method to change the locale dynamically
  void setLocale(Locale language) {
    setState(() {
      _locale = language;
    });
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      themeMode: _themeMode,
      locale: _locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: const [Locale('bn'), Locale('en')],
      theme: ThemeData.light(
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark(useMaterial3: true),
      home: const SplashScreen(),
    );
  }
}


