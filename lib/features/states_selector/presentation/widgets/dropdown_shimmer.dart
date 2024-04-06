import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class DropdownShimmer extends StatelessWidget {
  const DropdownShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        margin: const EdgeInsets.symmetric(vertical: 7.5),
        height: 50,
        width: MediaQuery.of(context).size.width * 0.8,
      ),
    );
  }
}
