import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

enum ShimmerType { cardGrid, cardList }

class ShimmerCustom extends StatelessWidget {
  const ShimmerCustom({
    Key? key,
    required this.child,
    this.direction = ShimmerDirection.ltr,
  }) : super(key: key);
  final Widget child;
  final ShimmerDirection direction;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      direction: direction,
      period: const Duration(milliseconds: 1200),
      baseColor: Colors.grey.withOpacity(0.4),
      highlightColor: Colors.white,
      child: child,
    );
  }
}

shimmerCardGrid() => GridView.builder(
  padding: const EdgeInsets.only(left: 18, right: 18, top: 8),
  shrinkWrap: true,
  physics: const ClampingScrollPhysics(),
  itemCount: 10,
  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    crossAxisSpacing: 8,
    mainAxisSpacing: 8,
    childAspectRatio: 0.9,
  ),
  itemBuilder: (context, index) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      height: 20,
    );
  },
);
