import 'package:flutter/material.dart';
import 'package:sandbox/feature/shimmer/ui/shimmer_placeholder.dart';
import 'package:shimmer/shimmer.dart';

class ShowcaseShimmerWidget extends StatelessWidget {
  const ShowcaseShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          BannerPlaceholder(),
          TitlePlaceholder(width: double.infinity),
          SizedBox(height: 16),
          ContentPlaceholder(lineType: ContentLineType.threeLines),
          SizedBox(height: 16),
          TitlePlaceholder(width: 200),
          SizedBox(height: 16),
          ContentPlaceholder(lineType: ContentLineType.twoLines),
          SizedBox(height: 16),
          TitlePlaceholder(width: 200),
          SizedBox(height: 16),
          ContentPlaceholder(lineType: ContentLineType.twoLines),
        ],
      ),
    );
  }
}
