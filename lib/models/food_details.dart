class FoodData {
  List<FoodItem> food;

  FoodData({required this.food});

  factory FoodData.fromJson(Map<String, dynamic> json) {
    var foodList = json['food'] as List;
    List<FoodItem> foods =
        foodList.map((item) => FoodItem.fromJson(item)).toList();

    return FoodData(food: foods);
  }
}

class FoodItem {
  String name;
  int calories;
  Nutrition nutrition;
  Measurements measurements;

  FoodItem({
    required this.name,
    required this.calories,
    required this.nutrition,
    required this.measurements,
  });

  factory FoodItem.fromJson(Map<String, dynamic> json) {
    return FoodItem(
      name: json['name'],
      calories: json['calories'],
      nutrition: Nutrition.fromJson(json['nutrition']),
      measurements: Measurements.fromJson(json['measurements']),
    );
  }
}

class Nutrition {
  int carbohydrates;
  int protein;
  int fat;
  int fiber;

  Nutrition({
    required this.carbohydrates,
    required this.protein,
    required this.fat,
    required this.fiber,
  });

  factory Nutrition.fromJson(Map<String, dynamic> json) {
    return Nutrition(
      carbohydrates: json['carbohydrates'],
      protein: json['protein'],
      fat: json['fat'],
      fiber: json['fiber'],
    );
  }
}

class Measurements {
  String? serving;
  String? cup;
  String? bowl;
  String? plate;

  Measurements({
    this.serving,
    this.cup,
    this.bowl,
    this.plate,
  });

  factory Measurements.fromJson(Map<String, dynamic> json) {
    return Measurements(
      serving: json['serving'],
      cup: json['cup'],
      bowl: json['bowl'],
      plate: json['plate'],
    );
  }
}