import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskapp/core/bloc/network_checker_bloc/network_bloc.dart';
import 'package:taskapp/core/helper/snack_bar_helper.dart';
import 'package:taskapp/core/locator/service_locator.dart';
import 'package:taskapp/core/service/network/network_service.dart';
import 'package:taskapp/features/home/view_modals/selection_chip_bloc/selection_chip_bloc.dart';
import 'package:taskapp/features/home/widgets/custom_choice_chip.dart';
import 'package:taskapp/gen/colors.gen.dart';
import 'package:taskapp/l10n/app_localizations.dart';
import 'dart:ui' as lang;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    // Start monitoring network changes
    NetworkService().startMonitoring();

    // Start observing in the NetworkBloc
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NetworkBloc>().add(NetworkObserve());
    });
  }

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context);
    final isRTL = Directionality.of(context) == lang.TextDirection.rtl;

    return MultiBlocProvider(
      providers: [
        // selection chip bloc
        BlocProvider(create: (context) => locator.get<SelectionChipBloc>()),

        // network bloc
        BlocProvider(create: (context) => locator.get<NetworkBloc>()),
        //
        // // view task bloc
        // BlocProvider(create: (context) => locator.get<ViewTaskBloc>()),
      ],
      child: MultiBlocListener(
        listeners: [
          // network failure
          BlocListener<NetworkBloc, NetworkState>(
            listener: (context, state) {
              if (state is NetworkFailure) {
                SnackBarHelper.showSnackBar(
                  context: context,
                  message: appLocalization.internetFailureToast,
                  backgroundColor: ColorName.toastErrorColor,
                  textColor: ColorName.white,
                  leadingIcon:
                      Icons.signal_cellular_connected_no_internet_4_bar_sharp,
                );
              } else if (state is NetworkSuccess) {
                SnackBarHelper.showSnackBar(
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
          child: Directionality(
            textDirection:
                isRTL ? lang.TextDirection.rtl : lang.TextDirection.ltr,
            child: Scaffold(
              backgroundColor: ColorName.white,
              body: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 20.h,
                    horizontal: 20.w,
                  ),
                  child: Column(
                    crossAxisAlignment:
                        isRTL
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment:
                            isRTL
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment:
                              isRTL
                                  ? CrossAxisAlignment.end
                                  : CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${appLocalization.hello} Imran B!",
                              style: Theme.of(
                                context,
                              ).textTheme.bodyLarge!.copyWith(
                                color: ColorName.primary,
                                fontWeight: FontWeight.w600,
                                fontSize: 22.sp,
                              ),
                            ),
                            Text(
                              appLocalization.haveANiceDay,
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
                                  onSelected: (_) {
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

                      BlocBuilder<NetworkBloc, NetworkState>(
                        builder: (context, state) {
                          if (state is NetworkInitial) {
                            return Text('Checking connectivity...');
                          } else if (state is NetworkSuccess) {
                            return Text('Connected');
                          } else if (state is NetworkFailure) {
                            return Text("not connected");
                          }

                          return SizedBox();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
