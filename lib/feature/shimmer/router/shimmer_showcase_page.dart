import 'package:flutter/material.dart';
import 'package:sandbox/feature/shimmer/ui/shimmer_component.dart';

class ShimmerShowcasePage extends StatelessWidget {
  const ShimmerShowcasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Shimmer')),
      body: const CustomScrollView(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        slivers: [
          SliverToBoxAdapter(child: ShowcaseShimmerWidget()),
        ],
      ),
    );
  }
}
