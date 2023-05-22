class Pet {
  final String id;
  final String name;
  final String breed;
  final int age;
  final String? image;

  Pet({
    required this.id,
    required this.name,
    required this.breed,
    required this.age,
    this.image,
  });

  factory Pet.fromJson(Map<String, dynamic> json) {
    return Pet(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      breed: json['breed'] ?? '',
      age: json['age'] ?? 0,
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'breed': breed,
      'age': age,
      'image': image,
    };
  }
}
