import 'package:flutter/material.dart';
import 'package:perdi_meu_pet/domain/provider/comment_provider.dart';
import 'package:perdi_meu_pet/screens/profile_screen.dart';
import 'package:provider/provider.dart';

import '/utils/app_routes.dart';
import '../screens/home_screen.dart';
import 'domain/provider/pet_provider.dart';
import 'domain/provider/post_provider.dart';
import 'domain/provider/user_provider.dart';
import 'screens/my_pet_screen.dart';
void main() {
  runApp(const FindMyPetApp());
}

class FindMyPetApp extends StatelessWidget {
  const FindMyPetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (context) => CommentProvider()), 
        ChangeNotifierProxyProvider<UserProvider, PetProvider>(
          create: (_) => PetProvider(UserProvider()),
          update: (_, userProvider, previousPetProvider) => PetProvider(userProvider),
        ),
        ChangeNotifierProxyProvider<UserProvider, PostProvider>(
          create: (_) => PostProvider(UserProvider()), 
          update: (_, userProvider, previousPostProvider) => PostProvider(userProvider),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.teal,
          primaryColor: Colors.teal,
        ),
        home: HomeScreen(),
        routes: {
          AppRoutes.PROFILE: (ctx) => ProfileScreen(),
          AppRoutes.MY_PETS: (ctx) => MyPetsScreen(),
        }
      ),
    );
  }
}
