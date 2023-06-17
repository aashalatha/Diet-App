import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';

import 'package:stayfit/models/recipe_model.dart';


class RecipeService{
  static const _appId = 'ae2d7296';
  static const _appKey = 'f792a364813875bcb885f4951a8d34f5';


    static Future<List<Recipe>> getRecipe(String query) async{
      final response = await http.get(Uri.parse("https://api.edamam.com/search?q=$query&app_id=$_appId&app_key=$_appKey"));

      if(response.statusCode == 200)
      {
        final data = jsonDecode(response.body);
        final List<Recipe> list =[];


        for(var i =0 ;i<data['hits'].length;i++){
          final entry = data['hits'][i];
          log(entry.toString());
          list.add(Recipe.fromJson(entry));
        }
        return list;
      }else{
        throw Exception('Http failed');
      } 
    }
}