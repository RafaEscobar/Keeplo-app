class User {
  final int id;
  final String fullName;
  final String email;

  User({
    required this.id,
    required this.fullName,
    required this.email
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['id'] ?? 0,
    fullName: "${json['name']} ${json['last_name']}",
    email: json['email'] ?? "user@gmail.com"
  );
}