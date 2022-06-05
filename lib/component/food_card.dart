import 'package:flutter/material.dart';
import 'package:recipe_book/page/detail.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../domain/recipe.dart';

class FoodCard extends StatelessWidget {
  final Recipe recipe;

  const FoodCard({
    Key? key,
    required this.recipe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          DetailRecipe.routeName,
          arguments: recipe,
        );
      },
      child: Container(
        padding: EdgeInsets.all(6),
        margin: EdgeInsets.only(bottom: 6),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            width: 1,
            color: Colors.black26,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: recipe.imageUrl,
                  placeholder: (context, url) => SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            Text(
              recipe.name,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            const Divider(
              height: 1,
              thickness: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  '${recipe.calories.ceil()}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.green,
                  ),
                ),
                Text(
                  "Calories",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                Text(
                  "|",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                Text(
                  '${recipe.totalIngredients}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.green,
                  ),
                ),
                Text(
                  "Ingredients",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const Divider(
              height: 1,
              thickness: 1,
            ),
            const SizedBox(
              height: 6,
            ),
            Text(
              recipe.source,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
