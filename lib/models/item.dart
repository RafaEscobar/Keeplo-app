class Item {

  Item({
    required this.id,
    required this.name,
    required this.status,
    required this.observations,
    required this.vahulId,
    required this.image
  });

  final int id;
  final String name;
  final bool status;
  final String observations;
  final int vahulId;
  final String image;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json['id'],
    name: json['name'],
    status: json['status'],
    observations: json['observations'],
    vahulId: json['vahul_id'],
    image: json['image']
  );
}
