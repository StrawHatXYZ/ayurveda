import 'package:flutter/material.dart';
import 'package:health/models/Product.dart';
import 'package:health/components/product_card.dart';
import 'package:health/components/section_title.dart';

class PopularProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: (20)),
          child: SectionTitle(title: "Popular Products", press: () {}),
        ),
        const SizedBox(height: (20)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...List.generate(
                demoProducts.length,
                (index) {
                  if (demoProducts[index].isPopular)
                    return ProductCard(product: demoProducts[index]);

                  return const SizedBox
                      .shrink(); // here by default width and height is 0
                },
              ),
              const SizedBox(width: (20)),
            ],
          ),
        )
      ],
    );
  }
}
