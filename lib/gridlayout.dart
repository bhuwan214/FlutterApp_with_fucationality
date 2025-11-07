import 'package:flutter/material.dart';
import 'food_data.dart';


class GridWidget extends StatelessWidget {
  const GridWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: GridView.builder(
     
         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
           crossAxisCount:2,
           crossAxisSpacing:10,
           mainAxisSpacing:10,
           childAspectRatio:.75,
           
        
         ),
         itemCount: foodItems.length,
         itemBuilder: (context, index) {
           final food = foodItems[index];
           return ImageCard(
             imageUrl: food['imageUrl']!,
             name: food['name']!,
             description: food['description']!,
           );
         }
        ),
      ),
    );
  }
}









class ImageCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String description;

  const ImageCard({super.key, required this.imageUrl, required this.name, required this.description});

  

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              name,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}