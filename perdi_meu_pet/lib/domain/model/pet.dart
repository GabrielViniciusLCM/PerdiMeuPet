// ignore_for_file: unnecessary_this

class Pet {
  final String name;        // nome do pet
  final String userId;      // id do usuário que fez o post, ou seja, que perdeu o pet
  final String breed;       // raça do pet
  final String age;         // idade do pet
  final String description; // descrição do pet
  final String imageUrl;    // url da imagem do pet
  // final DateTime placedAt = DateTime.now();
  
  Pet({
    required this.name,
    required this.userId,
    this.breed        = '',
    this.age          = '0',
    this.description  = '',
    this.imageUrl     = '',
  }):assert(name.isNotEmpty),
    assert(userId.isNotEmpty),
    assert(name.length >= 3),
    assert(userId.length >= 5),
    // assert(breed.isNotEmpty),
    assert(age.isNotEmpty),
    assert(
      int.tryParse(age) != null && 
      int.tryParse(age)! >= 0 && 
      int.tryParse(age)! <= 100, 
      'Age must be a valid number between 0 and 100'
    );
    // assert(description.isNotEmpty),
    // assert(imageUrl.isNotEmpty),
    // assert(breed.length >= 3),
    // assert(description.length >= 5),
    // assert(description.length <= 500),
    // assert(imageUrl.length >= 5);

  Pet.fromJson(Map<String, dynamic> json):
    this.name        = json['name'],
    this.breed       = json['breed'],
    this.age         = json['age'],
    this.description = json['description'],
    this.imageUrl    = json['imageUrl'],
    this.userId      = json['userId'];

  Map<String, dynamic> toJson() {
    return {
      'name':        this.name,
      'breed':       this.breed,
      'age':         this.age,
      'description': this.description,
      'imageUrl':    this.imageUrl,
      'userId':      this.userId,
      // 'placedAt':    this.placedAt,
    };
  }

  @override
  String toString() {
    return '''Pet{
      \n\tname: ${this.name},
      \n\tbreed: ${this.breed},
      \n\tage: ${this.age},
      \n\tdescription: ${this.description},
      \n\timageUrl: ${this.imageUrl},
      \n\tuserId: ${this.userId},
      \n}''';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Pet &&
      other.name        == this.name &&
      other.breed       == this.breed &&
      other.age         == this.age &&
      other.description == this.description &&
      other.imageUrl    == this.imageUrl &&
      other.userId      == this.userId;
  }
}