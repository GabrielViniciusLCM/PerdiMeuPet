import 'package:flutter/material.dart';
import 'package:perdi_meu_pet/screens/profile_screen.dart';
import 'package:provider/provider.dart';

import '/utils/app_routes.dart';
import '../screens/home_screen.dart';
import 'domain/provider/user_provider.dart';
// import './tabs/ProfileTab.dart';

void main() {
  // runApp(
  //   ChangeNotifierProvider(
  //     create: (context) => UsuarioProvider(),
  //     child: FindMyPetApp(),
  //   ),
  // );
  runApp(const FindMyPetApp());
}

class FindMyPetApp extends StatelessWidget {
  const FindMyPetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.teal,
          primaryColor: Colors.teal,
        ),
        home: HomeScreen(),
        routes: {
          AppRoutes.PROFILE: (ctx) => ProfileScreen(),
        }
      ),
    );
  }
}