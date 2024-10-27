import 'package:flutter/material.dart';
import 'package:samad_blood_bank/screen/dash_board.dart';
import 'package:samad_blood_bank/auth/sign_up_screen.dart';
import 'package:samad_blood_bank/services/auth_service.dart';
import 'package:samad_blood_bank/shared/button.dart';
import 'package:samad_blood_bank/shared/text_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> login() async {
    try {
      var authService = AuthService();
      bool isLoginSuccessful = await authService.login(
          emailController.text, passwordController.text);
      if (isLoginSuccessful) {
        String? userId = authService.getUserId();
        if (userId != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DashBoard(userId: userId)),
          );
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Login success')));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Failed to retrieve user ID')));
        }
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Login failed')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Failed to Login')));
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppLocalizations.of(context)?.logIn ?? ''),
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.topLeft, // Aligns text to the top-left
            child: Column(
              children: [
                Text(
                  AppLocalizations.of(context)?.welcome ?? '',
                  textAlign: TextAlign.center, // Left-align text
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const Image(
                  image: AssetImage('assets/images/splash.jpg'),
                  height: 200,
                  fit: BoxFit.cover,
                )
              ],
            ),
          ),
          Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextField(
                  controller: emailController,
                  label: AppLocalizations.of(context)?.email ?? '',
                  hint: 'admin32@gmail.com',
                  iconData: const Icon(Icons.email),
                ),
                CustomTextField(
                  controller: passwordController,
                  label: AppLocalizations.of(context)?.password ?? '',
                  hint: 'As321@#',
                  iconData: const Icon(Icons.email),
                ),
                CustomButton(
                    title: AppLocalizations.of(context)?.logIn ?? '',
                    onTap: () {
                      login();
                    })
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(AppLocalizations.of(context)?.oldUser ?? ''),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpScreen()));
                  },
                  child: Text(AppLocalizations.of(context)?.signUp ?? ''))
            ],
          ),
        ],
      ),
    );
  }
}
