import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:recipe_book/domain/recipe.dart';

class DetailRecipe extends StatelessWidget {
  const DetailRecipe({Key? key}) : super(key: key);

  static const routeName = '/detail';

  @override
  Widget build(BuildContext context) {
    final Recipe? argument =
        ModalRoute.of(context)?.settings.arguments as Recipe;

    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Recipe'),
      ),
      body: Container(
        width: double.maxFinite,
        padding: EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: argument?.imageUrl ?? "",
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
              Align(
                alignment: Alignment.center,
                child: Text(
                  argument?.name ?? '',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "${argument?.calories.ceil()}",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.green,
                    ),
                  ),
                  Text(
                    ' Calories',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 6,
              ),
              const Divider(
                height: 1,
                thickness: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "${argument?.totalIngredients}",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.green,
                    ),
                  ),
                  Text(
                    ' Ingredients:',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 6,
              ),
              ...List.generate(
                argument?.ingredients.length ?? 0,
                (index) => Text(
                  '${index + 1}. ${argument?.ingredients[index]}',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
