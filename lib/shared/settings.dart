import 'package:flutter/material.dart';

import 'package:hive/hive.dart';
import 'package:samad_blood_bank/auth/log_in_screen.dart';

import '../main.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  List<bool> isSelected = [true, false]; // For language selection
  List<bool> isThemeSelected = [true, false]; // For theme selection
  List<bool> isAdmin = [true, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setting'),
        elevation: 0,
      ),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Language Selection ToggleButtons
              SizedBox(
                height: 40,
                child: Align(
                  alignment: Alignment.center,
                  child: ToggleButtons(
                    focusColor: Colors.green,
                    fillColor: Colors.red,
                    color: Colors.redAccent,
                    highlightColor: Colors.blue,
                    hoverColor: Colors.red,
                    borderColor: Colors.green,
                    borderWidth: 2,
                    selectedBorderColor: Colors.yellow,
                    selectedColor: Colors.green,
                    borderRadius: BorderRadius.circular(50),
                    constraints: const BoxConstraints(
                      minHeight: 40,
                      minWidth:
                      60, // Reduce the minWidth to fit in the available space
                    ),
                    onPressed: (int index) {
                      Hive.box('langBox')
                          .put('langCode', index == 1 ? 'en' : 'bn');
                      MyApp.setLocale(
                          context, Locale(index == 1 ? 'en' : 'bn'));
                      setState(() {
                        for (int i = 0; i < isSelected.length; i++) {
                          isSelected[i] = i == index;
                        }
                      });
                    },
                    isSelected: isSelected,
                    children: const [
                      Padding(
                        padding:
                        EdgeInsets.symmetric(horizontal: 2, vertical: 0),
                        child: Text('Bengali'),
                      ),
                      Padding(
                        padding:
                        EdgeInsets.symmetric(horizontal: 2, vertical: 0),
                        child: Text('English'),
                      ),
                    ],
                  ),
                ),
              ),
              // Add a SizedBox with reduced height between the buttons
              const SizedBox(
                  height: 20), // Reduced the space between ToggleButtons

              // Theme Selection ToggleButtons
              SizedBox(
                height: 40,
                child: ToggleButtons(
                  focusColor: Colors.green,
                  fillColor: Colors.red,
                  borderColor: Colors.green,
                  borderWidth: 2,
                  selectedBorderColor: Colors.yellow,
                  selectedColor: Colors.green,
                  borderRadius: BorderRadius.circular(50),
                  constraints: const BoxConstraints(
                    minHeight: 40,
                    minWidth:
                    60, // Reduce the minWidth to fit in the available space
                  ),
                  onPressed: (int index) {
                    setState(() {
                      for (int i = 0; i < isThemeSelected.length; i++) {
                        isThemeSelected[i] = i == index;
                      }
                      if (index == 0) {
                        MyApp.setTheme(context, ThemeMode.light);
                      } else if (index == 1) {
                        MyApp.setTheme(context, ThemeMode.dark);
                      }
                    });
                  },
                  isSelected: isThemeSelected,
                  children: const [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2, vertical: 0),
                      child: Text('Light'),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2, vertical: 0),
                      child: Text('Dark'),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
             /* SizedBox(
                height: 40,
                child: Align(
                  alignment: Alignment.center,
                  child: ToggleButtons(
                    focusColor: Colors.green,
                    fillColor: Colors.red,
                    color: Colors.redAccent,
                    highlightColor: Colors.blue,
                    hoverColor: Colors.red,
                    borderColor: Colors.green,
                    borderWidth: 2,
                    selectedBorderColor: Colors.yellow,
                    selectedColor: Colors.green,
                    borderRadius: BorderRadius.circular(50),
                    constraints: const BoxConstraints(
                      minHeight: 40,
                      minWidth:
                      60, // Reduce the minWidth to fit in the available space
                    ),
                    onPressed: (int index) {
                      setState(() {
                        for (int i = 0; i < isAdmin.length; i++) {
                          isAdmin[i] = i == index;
                        }
                        if (index == 0) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LogInScreen()));
                        } else if (index == 1) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const S()));
                        }
                      });
                    },
                    isSelected: isAdmin,
                    children: const [
                      Padding(
                        padding:
                        EdgeInsets.symmetric(horizontal: 2, vertical: 0),
                        child: Text('Admin'),
                      ),
                      Padding(
                        padding:
                        EdgeInsets.symmetric(horizontal: 2, vertical: 0),
                        child: Text('Employee'),
                      ),
                    ],
                  ),
                ),
              ),*/
            ],
          ),
        ],
      ),
    );
  }
}
