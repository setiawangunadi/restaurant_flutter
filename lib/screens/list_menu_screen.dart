import 'package:flutter/material.dart';
import 'package:restaurant/data/models/detail_restaurant_response_model.dart';

class ListMenuScreen extends StatefulWidget {
  final String title;
  final List<Category>? listMenu;

  const ListMenuScreen({
    super.key,
    required this.title,
    this.listMenu,
  });

  @override
  State<ListMenuScreen> createState() => _ListMenuScreenState();
}

class _ListMenuScreenState extends State<ListMenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: widget.listMenu?.length,
        itemBuilder: (context, index) => Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(16.0),
          margin: const EdgeInsets.all(8.0),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
            color: Colors.grey,
          ),
          child: Row(
            children: [
              Icon(
                widget.title == "Foods"
                    ? Icons.fastfood_sharp
                    : Icons.emoji_food_beverage,
              ),
              const SizedBox(width: 8),
              Text(widget.listMenu?[index].name ?? ""),
            ],
          ),
        ),
      ),
    );
  }
}
