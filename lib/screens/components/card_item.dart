import 'package:flutter/material.dart';
import 'package:restaurant/config/app_routes.dart';
import 'package:restaurant/config/constants.dart';

class CardItem extends StatelessWidget {
  final String? id;
  final String? title;
  final String? location;
  final String? rating;
  final String? pictureId;
  final String? description;
  final EdgeInsetsGeometry? padding;

  const CardItem({
    super.key,
    this.id,
    this.title,
    this.location,
    this.rating,
    this.pictureId,
    this.description,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        AppRoutes.detail,
        arguments: {
          "id": id,
        },
      ),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.15,
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.orangeAccent,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            pictureId != null
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(
                      "${Constants.baseUrlImageLow}$pictureId",
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: MediaQuery.of(context).size.height * 0.2,
                    ),
                  )
                : const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.fastfood),
                  ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title ?? "Restaurant 1",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.location_on, color: Colors.red),
                    const SizedBox(width: 4),
                    Text(
                      location ?? "St. Somewhere on Earth",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.yellow),
                    const SizedBox(width: 4),
                    Text(
                      rating ?? "4.6",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
