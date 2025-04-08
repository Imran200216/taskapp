import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskapp/core/service/haptics/haptic_feedback_service.dart';
import 'package:taskapp/gen/colors.gen.dart';
import 'package:taskapp/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomProfileThanksText extends StatelessWidget {
  final String developerName;
  final String developerPortfolio;

  const CustomProfileThanksText({
    super.key,
    required this.developerName,
    required this.developerPortfolio,
  });

  @override
  Widget build(BuildContext context) {
    // app localization
    final appLocalization = AppLocalizations.of(context);

    return RichText(
      text: TextSpan(
        style: TextStyle(fontSize: 16, color: Colors.black),
        children: [
          TextSpan(text: "${appLocalization.madeWith} "),
          TextSpan(text: "❤️", style: TextStyle(color: ColorName.primary)),
          TextSpan(text: " ${appLocalization.from} "),
          TextSpan(
            text: developerName,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: ColorName.primary,
              decoration: TextDecoration.underline,
              decorationColor: ColorName.primary,
            ),
            recognizer:
                TapGestureRecognizer()
                  ..onTap = () {
                    HapticFeedbackUtilityService.mediumImpact();
                    launchUrl(Uri.parse(developerPortfolio));
                  },
          ),
        ],
      ),
    );
  }
}
