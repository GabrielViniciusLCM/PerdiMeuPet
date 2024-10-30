import 'package:flutter/material.dart';
import 'package:perdi_meu_pet/screens/HomeScreen.dart';
import 'package:provider/provider.dart';
import 'usuario_provider.dart';
// import './tabs/ProfileTab.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => UsuarioProvider(),
      child: FindMyPetApp(),
    ),
  );
}

class FindMyPetApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
      theme: ThemeData(
        primarySwatch: Colors.teal,
        primaryColor: Colors.teal,
      ),
    );
  }
}