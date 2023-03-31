import 'package:flutter/material.dart';

class Shop {
  final String name;
  final String location;
  final String imageUrl;

  Shop({required this.name, required this.location, required this.imageUrl});
}

class ShoppingScreen extends StatelessWidget {
  final List<Shop> shops = [
    Shop(
        name: "Royal Organic Millets",
        location: "Bengaluru | 5.1 kms away",
        imageUrl:
            "https://images.unsplash.com/photo-1472851294608-062f824d29cc?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8c2hvcHxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=900&q=60"),
    Shop(
        name: "The Millet House",
        location: "Yelahanka | 2.4 kms away",
        imageUrl: "https://c8.alamy.com/comp/BAM7TD/millets-shop-BAM7TD.jpg"),
    Shop(
        name: "Siridhanya Millets",
        location: "Yelahanka | 3.8  Kms away",
        imageUrl:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQzOHZsv4GO0fMsYUCx6BtGSJ000jZwCkJ4Sw&usqp=CAU"),
    Shop(
        name: "Pristine Organics | 4.3 Kms away",
        location: "Yelahanka",
        imageUrl:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSSluIbW1haZndIPmW_LumN7I-T0AACuguZUg&usqp=CAU"),
    Shop(
        name: "Native Food Store",
        location: "Yelahanka | 6.2 Kms away",
        imageUrl:
            "https://images.unsplash.com/photo-1519996409144-56c88c9aa612?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8bWlsbGV0c3xlbnwwfHwwfHw%3D&auto=format&fit=crop&w=900&q=60"),
    Shop(
        name: "Just Organik",
        location: "MG Road | 15.1 Kms away",
        imageUrl:
            "https://images.unsplash.com/photo-1651241587503-a874db54a1a7?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OXx8bWlsbGV0c3xlbnwwfHwwfHw%3D&auto=format&fit=crop&w=900&q=60"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              child: Text("Shops Near You",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: shops.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      // Handle shop item click
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Image.network(
                              shops[index].imageUrl,
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    shops[index].name,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    shops[index].location,
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                            Icon(Icons.arrow_forward),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
