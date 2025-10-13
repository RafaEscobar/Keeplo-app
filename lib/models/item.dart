class Item {

  Item({
    required this.id,
    required this.name,
    required this.status,
    required this.observations,
    required this.amount,
    required this.vahulId,
    required this.image
  });

  final int id;
  final String name;
  final int status;
  final String observations;
  final int amount;
  final int vahulId;
  final String image;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json['id'] ?? 0,
    name: json['name'] ?? '',
    status: json['status'] ?? '',
    observations: json['observation'] ?? '',
    amount: json['amount'] ?? 0,
    vahulId: json['vahul_id'] ?? 0,
    image: json['image'] ?? ''
  );
}
