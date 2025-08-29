class Vahul {
  final int id;
  final String name;
  final String description;
  final String color;
  final int userId;
  final String img;

  Vahul({
    required this.id,
    required this.name,
    required this.description,
    required this.color,
    required this.userId,
    required this.img,
  });

  factory Vahul.fromJson(Map<String, dynamic> json) => Vahul(
    id: json['id'] ?? 0,
    name: json['name'] ?? '',
    description: json['description'] ?? '',
    color: json['color'] ?? '',
    userId: json['user_id'] ?? 0,
    img: json['image']
  );
}