import 'package:flutter/material.dart';
import 'package:perdi_meu_pet/domain/provider/user_provider.dart';
import 'package:provider/provider.dart';

import '../domain/model/pet.dart';
import '../domain/provider/pet_provider.dart';


class CreatePetScreen extends StatefulWidget {
  final Function(MapEntry<String, Pet>) onAdd;

  CreatePetScreen({required this.onAdd});

  @override
  _CreatePetScreenState createState() => _CreatePetScreenState();
}

class _CreatePetScreenState extends State<CreatePetScreen> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String breed = '';
  String age = '0';
  String description = '';
  String imageUrl = '';

  Future<void> _savePet() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final petProvider = Provider.of<PetProvider>(context, listen: false);

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final newPet = Pet(
        name: name,
        breed: breed,
        age: age,
        description: description,
        imageUrl: imageUrl,
        userId: userProvider.userId,
      );
      final addedPet = await petProvider.addPet(newPet);

      widget.onAdd(
        addedPet,
      );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create New Pet"),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: "Name"),
                validator: (value) =>
                    value == null || value.isEmpty ? "Name is required" : null,
                onSaved: (value) => name = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Breed"),
                onSaved: (value) => breed = value ?? '',
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Age"),
                validator: (value) {
                  final age = int.tryParse(value ?? '');
                  if (age == null || age < 0 || age > 100) {
                    return "Please enter a valid age (0-100)";
                  }
                  return null;
                },
                onSaved: (value) => age = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Description"),
                onSaved: (value) => description = value ?? '',
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Image URL"),
                onSaved: (value) => imageUrl = value ?? '',
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _savePet,
                child: Text("Save"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}