import 'package:flutter/material.dart';
import 'package:perdi_meu_pet/domain/provider/user_provider.dart';
import 'package:perdi_meu_pet/domain/service/comment_service.dart';
import 'package:perdi_meu_pet/domain/service/post_service.dart';

import '../model/pet.dart';
import '../service/pet_service.dart';

class PetProvider with ChangeNotifier {
  final UserProvider userProvider; // Injected UserProvider
  final Map<String, Pet> _pets = {};

  PetProvider(this.userProvider); 

  Map<String, Pet> get pets => this._pets;

  Future<MapEntry<String, Pet>> addPet(Pet pet) async {
    try {
      final addedPet = await PetService.addPet(pet);
      this._pets[addedPet.key] = addedPet.value;
      notifyListeners();
      return addedPet;
    } catch (error) {
      rethrow;
    }
  }

  Future<void> deletePet(String key) async {
    try {
      final posts = await PostService.getPostsByPetId(key);
      posts.forEach((key, _) async {
        await CommentService.deleteCommentsByPostId(key);
      });
      await PostService.deletePostsByPetId(key, this.userProvider.userId);
      await PetService.deletePet(key);
      this._pets.remove(key);
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<Map<String, Pet>> getUserPets() async {
    final userId = this.userProvider.userId;
    try {
      final pets = await PetService.getUserPets(userId);
      this._pets.clear();
      this._pets.addAll(pets);
      notifyListeners();
      return this.pets;
    } catch (error) {
      rethrow;
    }
  }

  Future<String> getPetNameById(String id) async {
    try {
      final pet = await PetService.getPetById(id);
      return pet.value.name;
    } catch (error) {
      rethrow;
    }
  }

}