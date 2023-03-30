import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> categories = [
      {"icon": "assets/icons/crop-millet.svg", "text": "Millets"},
      {"icon": "assets/icons/edible-oil.svg", "text": "Oils"},
      {"icon": "assets/icons/emi-seeds.svg", "text": "Seeds"},
      {"icon": "assets/icons/vegetables.svg", "text": "Vegetables"},
      {"icon": "assets/icons/Discover.svg", "text": "More"},
    ];
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          categories.length,
          (index) => CategoryCard(
            icon: categories[index]["icon"],
            text: categories[index]["text"],
            press: () {},
          ),
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.icon,
    required this.text,
    required this.press,
  }) : super(key: key);

  final String? icon, text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        width: (55),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all((15)),
              height: (55),
              width: (55),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 207, 237, 253),
                borderRadius: BorderRadius.circular(10),
              ),
              child: SvgPicture.asset(icon!,
                  // ignore: deprecated_member_use
                  color: const Color.fromARGB(197, 7, 91, 127)),
            ),
            const SizedBox(height: 5),
            Text(text!, textAlign: TextAlign.center)
          ],
        ),
      ),
    );
  }
}
