class DietChart {
  String day;
  String breakfast;
  String midMorningSnack;
  String lunch;
  String eveningSnack;
  String dinner;

  DietChart({
    required this.day,
    required this.breakfast,
    required this.midMorningSnack,
    required this.lunch,
    required this.eveningSnack,
    required this.dinner,
  });
}


List <DietChart> dietChart = [
  DietChart(
  day: "Sunday",
  breakfast: " 2 boiled eggs\n 1 small dosa (without ghee)\n 1 tablespoon of coconut chutney",
  lunch: "1 cup of brown rice\n 1 small bowl of chicken curry\n 1 small bowl of vegetable curry \n 1 small bowl of rasam\n 1 small bowl of curd",
  midMorningSnack: "1 cup of buttermilk\n 4-5 almonds",
  eveningSnack: "1 cup of coffee",
  dinner: "2 small chapatis\n 1 small bowl of fish curry\n 1 small bowl of vegetable curry\n 1 cup of salad"
),
  DietChart(day: "Monday", 
  breakfast: ' Omelette made with 2 eggs and vegetables\n 1 slice of whole wheat bread',
  midMorningSnack:"Sprouts salad with cucumber, tomato, and lemon juice", 
  lunch:  "1 cup of quinoa\n 1 small bowl of chicken curry\n 1 small bowl of vegetable curry\n 1 small bowl of rasam\n 1 small bowl of curd", 
  eveningSnack: "1 cup of yogurt\n 4-5 walnuts", 
  dinner: 'Grilled chicken breast\n 1 small bowl of vegetable curry\n a tablespoon of cucumber and carrot slices'
),
  DietChart(day: "Tuesday", 
  breakfast: '2 boiled eggs\n 1 small dosa (without ghee)\n a tablespoon of tomato chutney',
  midMorningSnack:"Mixed fruit bowl with a variety of seasonal fruits like papaya, apple, and oranges.", 
  lunch:  "1 cup of brown rice\n 1 small bowl of fish curry\n 1 small bowl of vegetable curry\n 1 small bowl of rasam\n 1 small bowl of curd", 
  eveningSnack: " 1 cup of buttermilk\n 4-5 cashews", 
  dinner: '2 small chapatis\n 1 small bowl of chicken curry\n 1 small bowl of vegetable curry\n 1 tablespoon of salad'
),
DietChart(day: "Wednesday", 
  breakfast: ' Scrambled eggs with vegetables \n 1 slice of whole wheat bread',
  midMorningSnack:"Vegetable upma", 
  lunch:  " 1 cup of quinoa\n 1 small bowl of fish curry\n 1 small bowl of vegetable curry\n 1 small bowl of rasam\n 1 small bowl of curd", 
  eveningSnack: " 1 cup of yogurt\n 4-5 almond", 
  dinner: 'Grilled fish fillet\n 1 small bowl of vegetable curry\n 1 tablespoon of cucumber and carrot slices'
),
DietChart(day: "Thursday", 
  breakfast: ' 2 boiled eggs\n 1 small dosa (without ghee)\n 1 tablespoon of mint chutney',
  midMorningSnack:"Roasted chickpeas", 
  lunch:  "1 cup of brown rice\n 1 small bowl of chicken curry\n 1 small bowl of vegetable curry\n 1 small bowl of rasam\n 1 small bowl of curd", 
  eveningSnack: " 1 cup of buttermilk\n 4-5 walnuts", 
  dinner: '2 small chapatis\n 1 small bowl of chicken curry\n 1 small bowl of vegetable curry\n 1 tablespoon of salad'
),
DietChart(day: "Friday", 
  breakfast: 'Vegetable omelette made with 2 eggs and assorted veggies\n 1 slice of whole wheat bread',
  midMorningSnack:"Tomato and cucumber slices", 
  lunch:  "1 cup of quinoa\n 1 small bowl of chicken curry\n 1 small bowl of vegetable curry\n 1 small bowl of rasam\n 1 small bowl of curd", 
  eveningSnack: " 1 cup of yogurt\n 4-5 cashews", 
  dinner: 'Grilled chicken breast\n 1 small bowl of vegetable curry\n 1 tablespoon of cucumber and carrot slices'
),
DietChart(day: "Saturday", 
  breakfast: '2 boiled eggs\n 1 small dosa (without ghee)\n 1 tablespoon of onion-tomato chutney',
  midMorningSnack:"Yogurt with 4-5 nuts like almonds or walnuts.", 
  lunch:  "1 cup of brown rice\n 1 small bowl of fish curry\n 1 small bowl of vegetable curry\n 1 small bowl of rasam\n 1 small bowl of curd", 
  eveningSnack: " 1 cup of buttermilk\n 4-5 almonds", 
  dinner: ' 2 small chapatis\n 1 small bowl of chicken curry\n 1 small bowl of vegetable curry\n 1 tablespoon of salad'
),
];
