class Recipe{
  final String label;
  final String image;
  final double calories;
  final String url;

  const Recipe({
    required this.label,
    required this.image,
    required this.calories,
    required this. url
  });
  factory Recipe.fromJson(Map<String,dynamic> json){
    return Recipe(
      label: json['recipe']['label'], 
      image: json['recipe']['image'],
      calories: json['recipe']['calories'],
      url: json['recipe']['url']
      );
}
}