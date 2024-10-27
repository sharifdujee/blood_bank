import 'package:flutter/material.dart';
import 'package:samad_blood_bank/auth/log_in_screen.dart';
import 'package:samad_blood_bank/shared/button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../shared/text_style.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/splash.jpg',fit: BoxFit.cover, height: 300, width: 300,),
            const SizedBox(
              height: 40,
            ),
             Text(AppLocalizations.of(context)?.donate??'', style: motoStyle,),

            Text(AppLocalizations.of(context)?.motto??'', style: sloganStyle,),
            const SizedBox(
              height: 10,
            ),
            CustomButton(
              title: AppLocalizations.of(context)?.begin??'',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LogInScreen()),
                );
              },
            )



          ],
        ),
      ),
    );
  }
}
