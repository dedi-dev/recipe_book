import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:recipe_book/domain/recipe.dart';

class HomeProvider with ChangeNotifier {
  bool _isLoading = false;
  List<Recipe> _listRecipe = [];

  bool get isLoading => _isLoading;
  List<Recipe> get listRecipe => _listRecipe;

  String baseUrl =
      dotenv.env['BASE_URL'] ?? 'https://api.edamam.com/api/recipes';
  String appId = dotenv.env['APP_ID'] ?? '';
  String appKey = dotenv.env['APP_KEY'] ?? '';

  Future<void> getListRecipe({String search = 'pizza'}) async {
    _isLoading = true;

    try {
      var response = await Dio().get(
          '$baseUrl/v2?app_id=$appId&app_key=$appKey&type=public&q=$search');
      if (response.data != null) {
        var listRecipeJson = (response.data['hits'] ?? []) as List<dynamic>;
        _listRecipe = listRecipeJson.map((e) {
          var ingredientsJson =
              (e['recipe']['ingredients'] ?? []) as List<dynamic>;

          String ingredientMapper(Map<String, dynamic> ingredient) {
            return ingredient['text'];
          }

          List<String> ingredients =
              ingredientsJson.map(((e) => ingredientMapper(e))).toList();

          return Recipe(
            id: '',
            name: e['recipe']['label'] ?? '',
            imageUrl: e['recipe']['image'] ?? '',
            source: e['recipe']['source'] ?? '',
            calories: e['recipe']['calories'] ?? 0,
            totalIngredients: ingredientsJson.length,
            ingredients: ingredients,
          );
        }).toList();
        _isLoading = false;
      } else {
        _isLoading = false;
      }
    } catch (e) {
      _isLoading = false;
      print(e);
    }

    notifyListeners();
  }
}
