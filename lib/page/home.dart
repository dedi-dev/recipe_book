import 'package:flutter/material.dart';
import 'package:recipe_book/component/food_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _textEditingController = TextEditingController();

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
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: "Search",
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
                onTap: () {},
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
              child: Scrollbar(
                child: ListView.builder(
                    itemCount: 3,
                    itemBuilder: (BuildContext context, int index) {
                      return FoodCard();
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
