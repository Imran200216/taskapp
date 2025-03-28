import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskapp/features/archive/widgets/custom_no_task_found.dart';
import 'package:taskapp/gen/assets.gen.dart';
import 'package:taskapp/gen/colors.gen.dart';
import 'package:taskapp/l10n/app_localizations.dart';

class ArchiveScreen extends StatelessWidget {
  const ArchiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // app localization
    final appLocalization = AppLocalizations.of(context);

    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              /// title about on boarding
              Text(
                textAlign: TextAlign.start,
                appLocalization.archiveTask,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: ColorName.primary,
                  fontWeight: FontWeight.w600,
                  fontSize: 15.sp,
                ),
              ),

              Spacer(),

              /// no task found
              CustomNoTaskFound(
                svgPath: Assets.img.svg.noTask,
                text: appLocalization.noArchiveFound,
              ),

              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
