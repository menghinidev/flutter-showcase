import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'shimmer_placeholder.dart';

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
          SizedBox(height: 16.0),
          ContentPlaceholder(lineType: ContentLineType.threeLines),
          SizedBox(height: 16.0),
          TitlePlaceholder(width: 200.0),
          SizedBox(height: 16.0),
          ContentPlaceholder(lineType: ContentLineType.twoLines),
          SizedBox(height: 16.0),
          TitlePlaceholder(width: 200.0),
          SizedBox(height: 16.0),
          ContentPlaceholder(lineType: ContentLineType.twoLines),
        ],
      ),
    );
  }
}
