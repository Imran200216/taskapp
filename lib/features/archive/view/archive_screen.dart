import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskapp/core/bloc/network_checker_bloc/network_bloc.dart';
import 'package:taskapp/core/helper/snack_bar_helper.dart';
import 'package:taskapp/features/archive/widgets/custom_no_task_found.dart';
import 'package:taskapp/gen/assets.gen.dart';
import 'package:taskapp/gen/colors.gen.dart';
import 'package:taskapp/l10n/app_localizations.dart';

class ArchiveScreen extends StatefulWidget {
  const ArchiveScreen({super.key});

  @override
  State<ArchiveScreen> createState() => _ArchiveScreenState();
}

class _ArchiveScreenState extends State<ArchiveScreen> {
  @override
  @override
  Widget build(BuildContext context) {
    // app localization
    final appLocalization = AppLocalizations.of(context);

    return MultiBlocListener(
      listeners: [
        // internet checker bloc
        BlocListener<NetworkBloc, NetworkState>(
          listener: (context, state) {
            if (state is NetworkFailure) {
              // no internet connection snack bar
              return SnackBarHelper.showSnackBar(
                context: context,
                message: appLocalization.internetFailureToast,
                backgroundColor: ColorName.toastErrorColor,
                textColor: ColorName.white,
                leadingIcon:
                    Icons.signal_cellular_connected_no_internet_4_bar_sharp,
              );
            } else if (state is NetworkSuccess) {
              //  internet connection snack bar
              return SnackBarHelper.showSnackBar(
                context: context,
                message: appLocalization.internetSuccessToast,
                backgroundColor: ColorName.toastSuccessColor,
                textColor: ColorName.white,
                leadingIcon: Icons.signal_cellular_alt,
              );
            }
          },
        ),
      ],
      child: SafeArea(
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
      ),
    );
  }
}
