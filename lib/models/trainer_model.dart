class TrainerModel {
  final String id;
  final String name;
  final String url;

  TrainerModel({
    required this.id,
    required this.name,
    required this.url,
  });

  // Method to convert TrainerModel instance to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'url': url,
    };
  }

  // Method to create a TrainerModel from a map
  factory TrainerModel.fromMap(Map<String, dynamic> map) {
    return TrainerModel(
      id: map['id'],
      name: map['name'],
      url: map['url'],
    );
  }
}
