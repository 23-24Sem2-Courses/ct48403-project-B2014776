class Product {
  final String? id;
  final String name;
  final double price;
  final String image;
  final String description;
  final int? quantity;
  Product({required this.name, required this.price, required this.image, required this.description, required this.quantity, required this.id});

  factory Product.fromJson(Map<String, dynamic> json){
    switch (json.runtimeType) {
      case const (Map<String, dynamic>):
        return Product(
          id: json['_id'],
          name: json['name'],
          price: json['price'],
          description: json['description'],
          quantity: json['quantity'],
          image: json["image"]

        );
      default:
        throw FormatException('Invalid JSON type for User: ${json.runtimeType}');
    }

  }

}