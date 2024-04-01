import 'package:flutter/material.dart';

class TextTitle extends StatelessWidget {
  final String? title;
  final Widget? subtitle;
  final EdgeInsetsGeometry? margin;

  const TextTitle({super.key, this.title, this.subtitle, this.margin});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      margin: margin ?? const EdgeInsets.only(bottom: 32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title == null ? "Restaurant" : title ?? "",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: title == null ? 32 : 20,
            ),
          ),
          subtitle == null
              ? const Text(
                  "Recommendation restaurant for you!",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                  ),
                )
              : subtitle!,
        ],
      ),
    );
  }
}
