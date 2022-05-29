import 'package:flutter/material.dart';

class FoodCard extends StatelessWidget {
  const FoodCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
              child: Image.asset(
                "lib/asset/image/dummy.jpg",
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          const Text(
            "Neapolitan style vegetarian pizza",
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
            children: const [
              Text(
                "684",
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
                "10",
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
          const Text(
            "Food52",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
