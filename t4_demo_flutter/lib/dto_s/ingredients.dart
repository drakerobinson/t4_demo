class Ingredient {

  final int id;
  final String name;
  final double quantity;
  final String metric;


  Ingredient({
    required this.id,
    required this.name,
    required this.quantity,
    required this.metric,
  });

  factory Ingredient.fromExpandedJSON(Map<String, dynamic> json) {
    return Ingredient(
        id: json['id'],
        name: json['nameClean'],
        quantity: json['amount'],
        metric: json['unit']);
  }

  factory Ingredient.fromQuery(Map<String, dynamic> json) {
    return Ingredient(
      id: json['id'],
      name: json['name'],
      quantity: 0.0,
      metric: "N/A",
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "nameClean": name,
    "amount": quantity,
    "unit": metric,
  };

}