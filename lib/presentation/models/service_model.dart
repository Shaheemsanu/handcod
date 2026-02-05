class ServiceModel {
  final String name;
  final String category;
  final double rating;
  final int orders;
  final String duration;
  final int price;
  final String? imageUrl;
  final int quantity;

  ServiceModel({
    required this.name,
    required this.category,
    required this.rating,
    required this.orders,
    required this.duration,
    required this.price,
    this.imageUrl,
    this.quantity = 0,
  });

  factory ServiceModel.fromMap(Map<String, dynamic> map) {
    return ServiceModel(
      duration: "",
      imageUrl: "",
      category: "",
      rating: 0,
      orders: 0,
      name: map['name'],
      quantity: map['quantity'],
      price: map['price'],
    );
  }

  Map<String, dynamic> toMap() {
    return {'name': name, 'quantity': quantity, 'price': price};
  }

  ServiceModel copyWith({int? quantity}) {
    return ServiceModel(
      name: name,
      category: category,
      rating: rating,
      orders: orders,
      duration: duration,
      price: price,
      imageUrl: imageUrl,
      quantity: quantity ?? this.quantity,
    );
  }
}
