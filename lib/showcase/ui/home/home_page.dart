import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sandbox/showcase/model/showcase_work/showcasework.dart';
import 'package:sandbox/showcase/ui/home/sections/app_bar.dart';
import 'package:sandbox/showcase/ui/home/sections/header_section.dart';
import 'package:sandbox/showcase/ui/home/sections/showcase_work_listview.dart';
import 'package:sandbox/showcase/ui/utils/scroll_utility.dart';
import 'package:sandbox/showcase/ui/utils/ui_utility.dart';
import 'package:sandbox/utils/localization/app_localization_service.dart';

final showcaseWorkProvider = Provider<List<ShowcaseWork>>((ref) {
  return [
    ShowcaseWorkFactory.dappertuttoShowcase(ref.watch(appLocalizationsProvider)),
    ShowcaseWorkFactory.codeSnippetsShowcase(ref.watch(appLocalizationsProvider)),
  ];
});

class HomePage extends HookConsumerWidget with UiUtility, UiShape {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(showcaseWorkProvider);
    return Scaffold(
      appBar: const RoundedHomePageAppBar(),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              'https://png.pngtree.com/thumb_back/fh260/background/20211029/pngtree-gradient-geometric-vertical-background-for-instagram-stories-device-landing-page-web-image_914127.png',
              fit: BoxFit.cover,
            ),
          ),
          const Positioned(
            top: kToolbarHeight + UiDimension.mediumSize,
            left: UiDimension.mediumSize,
            right: UiDimension.mediumSize,
            bottom: 0,
            child: CustomScrollView(
              slivers: [HomePageHeader()],
            ),
          ),
        ],
      ),
      bottomSheet: CustomScrollConfiguration(
        child: DraggableScrollableSheet(
          minChildSize: 0.1,
          expand: false,
          initialChildSize: 0.7,
          maxChildSize: 0.7,
          snap: true,
          snapSizes: const [0.1],
          builder: (context, scrollController) => Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: topRounded.borderRadius,
            ),
            alignment: Alignment.topCenter,
            child: ShowcaseWorkListView(
              items: items,
              scrollController: scrollController,
            ),
          ),
        ),
      ),
    );
  }
}
