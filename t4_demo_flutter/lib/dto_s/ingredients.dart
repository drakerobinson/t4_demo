class Ingredients {

  final int id;
  final String nameClean;
  final double quantity;
  final String metric;

  Ingredients({
    required this.id,
    required this.nameClean,
    required this.quantity,
    required this.metric,
  });

  factory Ingredients.fromJSON(Map<String, dynamic> json) {
    return Ingredients(
        id: json['id'],
        nameClean: json['nameClean'],
        quantity: json['amount'],
        metric: json['unit']);
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "nameClean": nameClean,
    "quantity": quantity,
    "metric": metric,
  };

}