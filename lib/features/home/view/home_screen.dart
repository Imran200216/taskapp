import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:taskapp/core/locator/service_locator.dart';
import 'package:taskapp/features/home/view_modals/selection_chip_bloc.dart';
import 'package:taskapp/features/home/widgets/custom_choice_chip.dart';
import 'package:taskapp/features/home/widgets/custom_task_list_tile.dart';
import 'package:taskapp/gen/colors.gen.dart';
import 'package:taskapp/l10n/app_localizations.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // App localization
    final appLocalization = AppLocalizations.of(context);
    final isRTL = Directionality.of(context) == TextDirection.rtl;

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => locator.get<SelectionChipBloc>()),
      ],
      child: SafeArea(
        child: Directionality(
          textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
          child: Scaffold(
            backgroundColor: ColorName.white,
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
                child: Column(
                  crossAxisAlignment:
                      isRTL ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Wrap in Align for proper positioning
                    Align(
                      alignment:
                          isRTL ? Alignment.centerRight : Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment:
                            isRTL
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
                        children: [
                          // Hello user name
                          Text(
                            "${appLocalization.hello} Imran B!",
                            textAlign: isRTL ? TextAlign.right : TextAlign.left,
                            style: Theme.of(
                              context,
                            ).textTheme.bodyLarge!.copyWith(
                              color: ColorName.primary,
                              fontWeight: FontWeight.w600,
                              fontSize: 22.sp,
                            ),
                          ),

                          // Have a nice day
                          Text(
                            appLocalization.haveANiceDay,
                            textAlign: isRTL ? TextAlign.right : TextAlign.left,
                            style: Theme.of(
                              context,
                            ).textTheme.bodySmall!.copyWith(
                              color: ColorName.grey,
                              fontWeight: FontWeight.w500,
                              fontSize: 13.sp,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 20.h),

                    // Selection Chip using Bloc
                    BlocBuilder<SelectionChipBloc, SelectionChipState>(
                      builder: (context, state) {
                        final options = [
                          appLocalization.chipTaskCompleted,
                          appLocalization.chipTaskInProgress,
                          appLocalization.chipTaskOverDue,
                        ];
                        int selectedIndex =
                            (state is SelectionChipSelected)
                                ? state.selectedIndex
                                : 0;

                        return Align(
                          alignment:
                              isRTL
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                          child: Wrap(
                            spacing: 10.w,
                            children: List.generate(options.length, (index) {
                              final isSelected = selectedIndex == index;

                              return CustomChoiceChip(
                                index: index,
                                label: options[index],
                                isSelected: isSelected,
                                onSelected: (selected) {
                                  context.read<SelectionChipBloc>().add(
                                    SelectChipEvent(index),
                                  );
                                },
                              );
                            }),
                          ),
                        );
                      },
                    ),

                    SizedBox(height: 20.h),

                    // list of task (Task completed, Task InProgress, Task OverDue)
                    ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 20,
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 12.h);
                      },
                      itemBuilder: (context, index) {
                        return CustomTaskListTile(
                          taskTitle: "Design Changes",
                          taskDescription: "2 Days ago",
                          onTap: () {
                            // task description screen
                            GoRouter.of(context).pushNamed("taskDescription");
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
