class ShoppingList {
  final String name;
  final String category;

  ShoppingList({
    required this.name,
    required this.category,
  });

  // Create a factory constructor to create a ShoppingList instance from a JSON map.
  factory ShoppingList.fromJson(Map<String, dynamic> json) {
    return ShoppingList(
      name: json['name'] as String,
      category: json['category'] as String,
    );
  }

  // Create a method to convert a ShoppingList instance to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'category': category,
    };
  }
}
