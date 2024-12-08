import 'package:flutter/material.dart';
import 'package:perdi_meu_pet/domain/provider/pet_provider.dart';

import 'package:provider/provider.dart';

import '../domain/model/pet.dart';
import 'create_pet_screen.dart';


class MyPetsScreen extends StatefulWidget {
  @override
  _MyPetsScreenState createState() => _MyPetsScreenState();
}

class _MyPetsScreenState extends State<MyPetsScreen> {
  // List<Pet> pets = [];
  late PetProvider petProvider;
  Map<String, Pet> pets = {};
  bool isLoading = true;
  // late UserProvider userProvider;

  @override
  void initState() {
    super.initState();
    // userProvider = Provider.of<UserProvider>(context, listen: false);
    petProvider = Provider.of<PetProvider>(context, listen: false);
    _fetchPets();
  }

  void _fetchPets() async {
    try {
      // final petsMap = await PetService.getUserPets(userProvider.userId);
      final petsMap = await petProvider.getUserPets();
      setState(() {
        // pets = petsMap.values.toList();
        this.pets = petsMap;
        // print(pets);
        isLoading = false;
      });
    } catch (e) {
      // Handle errors here, like showing a snackbar
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _deletePet(String key) async {
    // await PetService.deletePet(key);
    await petProvider.deletePet(key);
    setState(() {
      pets.remove(key);
    });
    // Optionally: Call a service to remove the pet from the backend
  }

  void _addPet() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CreatePetScreen(
          onAdd: (pet) {
            setState(() {pets[pet.key] = pet.value;},);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Pets"),
        backgroundColor: Colors.teal,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : pets.isEmpty
              ? Center(child: Text("No pets available. Add some!"))
              :ListView.builder(
                itemCount: pets.keys.length,
                itemBuilder: (context, index) {
                  final key = pets.keys.elementAt(index); // Get the key
                  final value = pets[key]; // Access value using the key
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(value?.imageUrl ?? ''),
                      ),
                      title: Text("${value?.name}"),
                      subtitle: Text("Breed: ${value?.breed}\nAge: ${value?.age}"),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          _deletePet(key);
                        },
                      ),
                    ),
                  );
                },
              ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addPet,
        child: Icon(Icons.add),
        backgroundColor: Colors.teal,
      ),
    );
  }
}