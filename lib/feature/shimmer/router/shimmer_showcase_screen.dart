import 'package:flutter/material.dart';
import 'package:sandbox/feature/shimmer/ui/shimmer_component.dart';

class ShimmerShowcaseScreen extends StatelessWidget {
  const ShimmerShowcaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      slivers: [
        SliverToBoxAdapter(child: ShowcaseShimmerWidget()),
      ],
    );
  }
}
