import 'package:flutter/material.dart';

import '../components/home_header.dart';
import '../components/discount_banner.dart';
import '../components/categories.dart';
import '../components/special_offers.dart';
import '../components/popular_products.dart';

class ShoppingScreen extends StatefulWidget {
  const ShoppingScreen({super.key});

  @override
  State<ShoppingScreen> createState() => _ShoppingScreenState();
}

class _ShoppingScreenState extends State<ShoppingScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const DiscountBanner(),
            Categories(),
            const SpecialOffers(),
            const SizedBox(height: (30)),
            PopularProducts(),
            const SizedBox(height: (30)),
          ],
        ),
      ),
    );
  }
}
