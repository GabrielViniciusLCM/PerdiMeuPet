import 'Animal.dart';
class Pet extends Animal{
  Pet({
    required this.id,
    required this.nome,
    required this.especie,
    required this.raca,
    required this.imagemUrl,
  }) : super(id: '', especie: '', raca: '');

  final String id;
  final String nome;
  final String especie;
  final String raca;
  final String imagemUrl;
}
