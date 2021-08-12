import 'package:afghanistan_law_app/src/preferences/language_preferences.dart';
import 'package:afghanistan_law_app/src/ui/lang_selection.dart';
import 'package:flutter/material.dart';
import 'package:afghanistan_law_app/src/blocs/splash/splash_bloc.dart';
import 'package:afghanistan_law_app/src/blocs/splash/splash_state.dart';
import 'package:afghanistan_law_app/src/ui/dashboard.dart';
import 'package:afghanistan_law_app/src/widgets/splash_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: BlocBuilder<SplashBloc, SplashScreenState>(
            builder: (context, SplashScreenState state) {
              if (state is SplashInitialState || state is SplashLoadingState) {
                return SplashScreenWidget();
              } else if (state is SplashLanguageSelectionState) {
                if (LanguagePreferences.getLocale() == null) {
                  return LanguageSelection();
                }
                return Dashboard();
              }
              return SplashScreenWidget();
            },
          ),
        ),
      ),
    );
  }
}














// import 'dart:async';
// import 'package:afghanistan_law_app/src/ui/dashboard.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';

// class Splash extends StatefulWidget {
//   const Splash({Key? key}) : super(key: key);

//   @override
//   _SplashState createState() => _SplashState();
// }

// class _SplashState extends State<Splash> {
//   @override
//   void initState() {
//     super.initState();
//     Timer(
//         Duration(seconds: 5),
//         () => Navigator.pushReplacement(
//             context, MaterialPageRoute(builder: (context) => Dashboard())));
//   }

//   Future<FirebaseApp> _initializeFirebase() async {
//     FirebaseApp firebaseApp = await Firebase.initializeApp();
//     return firebaseApp;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//         future: _initializeFirebase(),
//         builder: (context, snapshot) {
//           return Container(
//             color: Colors.white,
//             child: Padding(
//               padding: EdgeInsets.only(left: 40.0, right: 40.0, top: 180.0),
//               child: Column(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Image.asset(
//                       'assets/img/afghanistan_flag.jpg',
//                       height: 180.0,
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(18.0),
//                     child: CircularProgressIndicator(
//                       color: Colors.blue,
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           );
//         });
//   }
// }
