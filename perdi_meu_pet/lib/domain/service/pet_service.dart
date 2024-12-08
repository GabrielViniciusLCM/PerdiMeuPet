import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../utils/urls.dart';
import '../model/pet.dart';

class PetService {
  
  static Future<Map<String, Pet>> getUserPets(String userId) async {
    final response = await http.get(Uri.parse('${Urls.BASE_URL}/pets.json'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final Map<String, Pet> petMap = {};
      data.forEach((key, value) {
        final pet = Pet.fromJson(value);
        if (pet.userId == userId) {
          petMap[key] = pet;
        }
      });
      return petMap;
    } else {
      throw Exception('Failed to load pets');
    }
  }

  static Future<MapEntry<String, Pet>> getPetById(String id) async {
    final response = await http.get(Uri.parse('${Urls.BASE_URL}/pets/$id.json'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      print(data);
      final Pet pet = Pet.fromJson(data);
      final MapEntry<String, Pet> petMap = MapEntry(id, pet);
      return petMap;
    } else {
      throw Exception('Erro ao buscar pet');
    }
  }

  // Don't need the userId parameter, because the user is already logged in
  // and the added pet will be associated with the logged in user
  static Future<MapEntry<String, Pet>> addPet(Pet pet) async {
    final response = await http.post(
      Uri.parse('${Urls.BASE_URL}/pets.json'),
      body: json.encode(pet),
    );
    if (response.statusCode == 200) {
      final id = json.decode(response.body)['name'];
      final MapEntry<String, Pet> petMap = MapEntry(id, pet);
      return petMap;
    } else {
      throw Exception('Failed to add pet');
    }
  }

  static Future<void> deletePet(String petId) async {
    final response = await http.delete(
      Uri.parse('${Urls.BASE_URL}/pets/$petId.json'),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to delete pet');
    }
  }
}