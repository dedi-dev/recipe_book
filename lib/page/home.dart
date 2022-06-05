import 'package:flutter/material.dart';
import 'package:recipe_book/component/food_card.dart';
import 'package:recipe_book/domain/recipe.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static const routeName = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _textEditingController = TextEditingController();
  bool _isLoading = false;
  List<Recipe> _listRecipe = [];

  Future<List<Recipe>?> _getListRecipe({String search = 'pizza'}) async {
    setState(() {
      _isLoading = true;
    });
    String baseUrl =
        dotenv.env['BASE_URL'] ?? 'https://api.edamam.com/api/recipes';
    String appId = dotenv.env['APP_ID'] ?? '';
    String appKey = dotenv.env['APP_KEY'] ?? '';

    try {
      var response = await Dio().get(
          '$baseUrl/v2?app_id=$appId&app_key=$appKey&type=public&q=$search');
      if (response.data != null) {
        var listRecipeJson = (response.data['hits'] ?? []) as List<dynamic>;
        List<Recipe> listRecipe = listRecipeJson.map((e) {
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
        setState(() {
          _isLoading = false;
        });
        return listRecipe;
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _getListRecipe().then((value) => _listRecipe = value ?? []);
  }

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.fromLTRB(24, 48, 24, 0),
        child: Column(
          children: [
            const Text(
              "Find Best Recipe For Cooking",
              style: TextStyle(
                color: Colors.black,
                fontSize: 34,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Row(children: [
              Flexible(
                flex: 3,
                child: TextFormField(
                  controller: _textEditingController,
                  onFieldSubmitted: (text) {
                    _getListRecipe(search: text).then((value) {
                      setState(() {
                        _listRecipe = value ?? [];
                      });
                    });
                    ;
                  },
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: "example: Pizza",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.green, width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    fillColor: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              InkWell(
                onTap: () {
                  _getListRecipe(search: _textEditingController.text)
                      .then((value) {
                    setState(() {
                      _listRecipe = value ?? [];
                    });
                  });
                  ;
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.green.shade100,
                      borderRadius: BorderRadius.circular(10)),
                  height: 60,
                  width: 40,
                  child: const Icon(
                    Icons.toc_rounded,
                    color: Colors.green,
                  ),
                ),
              )
            ]),
            const SizedBox(
              height: 12,
            ),
            Expanded(
              child: _isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Scrollbar(
                      child: ListView.builder(
                          itemCount: _listRecipe.length,
                          itemBuilder: (BuildContext context, int index) {
                            Recipe recipe = _listRecipe[index];
                            return FoodCard(recipe: recipe);
                          }),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
