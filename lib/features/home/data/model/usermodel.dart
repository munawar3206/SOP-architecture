class UserModel {
  final String name;
  final String age;
  final String image;

  UserModel({
    required this.name,
    required this.age,
    required this.image,
  });


  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      age: map['age'] ?? '',
      image: map['image'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'age': age,
      'image': image,
    };
  }
}
