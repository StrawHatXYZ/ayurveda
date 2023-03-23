import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DiscountBanner extends StatelessWidget {
  const DiscountBanner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        // height: 90,
        width: double.infinity,
        margin: const EdgeInsets.all((20)),
        padding: const EdgeInsets.symmetric(
          horizontal: (20),
          vertical: (15),
        ),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 69, 164, 205),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  "assets/icons/discount.svg",
                  height: (20),
                  width: (20),
                  // ignore: deprecated_member_use
                  color: Colors.white,
                ),
                const SizedBox(width: 5),
                const Text(
                  "New User Offer",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: (24),
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(height: 5),
            const Text(
              "Get 20% discount on first purchase",
              style: TextStyle(
                color: Colors.white,
                fontSize: (16),
              ),
            ),
          ],
        ));
  }
}
