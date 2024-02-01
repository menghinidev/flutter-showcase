import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sandbox/feature/camera/router/ocr/ocr_route.dart';
import 'package:sandbox/feature/camera/router/qrcode/qr_code_route.dart';
import 'package:sandbox/feature/pagination/router/pagination_showcase_route.dart';
import 'package:sandbox/feature/sliver/router/sliver_showcase_route.dart';

part 'showcasework.freezed.dart';

@freezed
class ShowcaseWork with _$ShowcaseWork {
  factory ShowcaseWork({
    required String id,
    required String title,
    required String description,
    required String imagePath,
    required List<ShowcaseWorkBadge> badges,
    String? detailsUrl,
  }) = _ShowcaseWork;
}

@freezed
class ShowcaseWorkBadge with _$ShowcaseWorkBadge {
  factory ShowcaseWorkBadge({
    required String label,
    String? navigateToUrl,
  }) = _ShowcaseWorkBadge;
}

class ShowcaseWorkFactory {
  static ShowcaseWork dappertuttoShowcase(AppLocalizations localizations) {
    return ShowcaseWork(
      id: 'dappertutto',
      title: localizations.feature_dappertutto_title,
      description: localizations.feature_dappertutto_description,
      imagePath: 'assets/images/dappertutto.png',
      badges: <ShowcaseWorkBadge>[
        ShowcaseWorkBadge(
          label: localizations.feature_badge_flutter,
          navigateToUrl: 'https://flutter.dev/',
        ),
        ShowcaseWorkBadge(
          label: localizations.feature_badge_firebase,
          navigateToUrl: 'https://firebase.google.com/',
        ),
        ShowcaseWorkBadge(
          label: localizations.feature_badge_riverpod,
          navigateToUrl: 'https://riverpod.dev/',
        ),
      ],
    );
  }

  static ShowcaseWork codeSnippetsShowcase(AppLocalizations localizations) {
    return ShowcaseWork(
      id: 'code_snippets',
      title: localizations.feature_code_snippets_title,
      description: localizations.feature_code_snippets_description,
      imagePath: 'assets/images/dappertutto.png',
      detailsUrl: 'https://www.easydeskweb.com/',
      badges: <ShowcaseWorkBadge>[
        ShowcaseWorkBadge(
          label: 'Slivers',
          navigateToUrl: SliverShowcaseRoute.fromHome(),
        ),
        ShowcaseWorkBadge(
          label: 'OCR',
          navigateToUrl: OcrScannerScreenRoute.fromHome(),
        ),
        ShowcaseWorkBadge(
          label: 'Pagination',
          navigateToUrl: PaginationShowcaseRoute.fromHome(),
        ),
        ShowcaseWorkBadge(
          label: 'QR Code Scanner',
          navigateToUrl: QrCodeScannerScreenRoute.fromHome(),
        ),
      ],
    );
  }
}
