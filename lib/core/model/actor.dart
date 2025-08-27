class Actor {
  final int id;
  final String name;
  final String role;
  final String? photo;

  Actor({
    required this.id,
    required this.name,
    required this.role,
    this.photo,
  });

  factory Actor.fromJson(Map<String, dynamic> json) {
    return Actor(
      id: json['id'],
      name: json['name'],
      role: json['role'],
      photo: json['photo'],
    );
  }
}
