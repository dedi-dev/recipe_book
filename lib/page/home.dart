import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_book/component/food_card.dart';
import 'package:recipe_book/domain/recipe.dart';
import 'package:recipe_book/provider/home_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static const routeName = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Provider.of<HomeProvider>(context, listen: false).getListRecipe();
  }

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    HomeProvider homeData = Provider.of<HomeProvider>(context);
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
                    homeData.getListRecipe(search: text);
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
                  homeData.getListRecipe(search: _textEditingController.text);
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
              child: homeData.isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Scrollbar(
                      child: ListView.builder(
                          itemCount: homeData.listRecipe.length,
                          itemBuilder: (BuildContext context, int index) {
                            Recipe recipe = homeData.listRecipe[index];
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
