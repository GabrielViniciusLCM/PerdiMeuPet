import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../utils/urls.dart';
import '../model/pet.dart';

class PetService {
  static Future<Map<String, Pet>> getPets() async {
    final response = await http.get(Uri.parse('${Urls.BASE_URL}/pets.json'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final Map<String, Pet> petMap = {};
      data.forEach((key, value) {
        petMap[key] = Pet.fromJson(value);
      });
      return petMap;
    } else {
      throw Exception('Failed to load pets');
    }
  }

  static Future<Map<String, Pet>> getPetById(String id) async {
    final response =
        await http.get(Uri.parse('${Urls.BASE_URL}/pets/$id.json'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final Map<String, Pet> userMap = {id: Pet.fromJson(data)};

      return userMap;
    } else {
      throw Exception('Erro ao buscar pet');
    }
  }

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

  // Função para buscar o nome do pet com base no ID
  static Future<String> getPetNameById(String petId) async {
    try {
      Map<String, Pet> petMap = await PetService.getPetById(petId);
      Pet pet = petMap[petId]!;

      return pet.name;
    } catch (e) {
      throw Exception('Erro ao buscar nome do pet: $e');
    }
  }
}