class CarModel {
  String id;
  String ownerId;
  String model;
  String make;
  int year;
  double price;
  int kilometers;
  String description;
  List<String> images; // List of URLs for car images
  String transmission;
  String fuelType;
  bool isAvailable;
  bool isArchived;

  CarModel({
    required this.ownerId,
    required this.model,
    required this.make,
    required this.year,
    required this.price,
    required this.kilometers,
    required this.description,
    required this.images,
    required this.transmission,
    required this.fuelType,
    this.isAvailable = true,
    this.isArchived = true,
  }) : id = '';
  CarModel.withId({
    required this.id,
    required this.ownerId,
    required this.model,
    required this.make,
    required this.year,
    required this.price,
    required this.kilometers,
    required this.description,
    required this.images,
    required this.transmission,
    required this.fuelType,
    this.isAvailable = true,
    this.isArchived = true,
  });

  // Convert CarModel object to a map for saving to Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ownerId': ownerId,
      'model': model,
      'make': make,
      'year': year,
      'price': price,
      'kilometers': kilometers,
      'description': description,
      'images': images,
      'transmission': transmission,
      'fuelType': fuelType,
      'isAvailable': isAvailable,
      'isArchived': isArchived,
    };
  }

  // Create a CarModel object from a Firestore map
  factory CarModel.fromMap(Map<String, dynamic> map, String id) {
    return CarModel.withId(
      id: id,
      ownerId: map['ownerId'] ?? '',
      model: map['model'] ?? '',
      make: map['make'] ?? '',
      year: map['year'] ?? 0,
      price: (map['price'] ?? 0).toDouble(),
      kilometers: map['kilometers'] ?? 0,
      description: map['description'] ?? '',
      images: List<String>.from(map['images'] ?? []),
      transmission: map['transmission'] ?? 'Unknown',
      fuelType: map['fuelType'] ?? 'Unknown',
      isAvailable: map['isAvailable'] ?? true,
      isArchived: map['isArchived'] ?? false,
    );
  }
}
