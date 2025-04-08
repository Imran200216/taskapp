import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskapp/core/bloc/network_checker_bloc/network_bloc.dart';
import 'package:taskapp/core/helper/snack_bar_helper.dart';
import 'package:taskapp/core/locator/service_locator.dart';
import 'package:taskapp/features/auth/view/auth_login.dart';
import 'package:taskapp/features/auth/view/auth_register.dart';
import 'package:taskapp/gen/colors.gen.dart';
import 'package:taskapp/l10n/app_localizations.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    // Dispatch the network observe event
    locator<NetworkBloc>().add(NetworkObserve());
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // app localization
    final appLocalization = AppLocalizations.of(context);

    return MultiBlocProvider(
      providers: [
        // internet checker bloc
        BlocProvider(
          create: (context) {
            final bloc = locator<NetworkBloc>();
            bloc.add(NetworkObserve());
            return bloc;
          },
        ),
      ],
      child: MultiBlocListener(
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
        child: BlocBuilder<NetworkBloc, NetworkState>(
          builder: (context, state) {
            return SafeArea(
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: ColorName.white,
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 20.h,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          /// Title
                          Text(
                            appLocalization.authTitle,
                            textAlign: TextAlign.center,
                            style: Theme.of(
                              context,
                            ).textTheme.bodyLarge!.copyWith(
                              color: ColorName.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          SizedBox(height: 10.h),

                          // Description
                          Text(
                            appLocalization.authSubTitle,
                            textAlign: TextAlign.center,
                            style: Theme.of(
                              context,
                            ).textTheme.bodySmall!.copyWith(
                              color: ColorName.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),

                          SizedBox(height: 10.h),
                        ],
                      ),
                    ),

                    // Tab Bar
                    TabBar(
                      controller: _tabController,
                      indicatorColor: ColorName.primary,
                      indicatorSize: TabBarIndicatorSize.tab,
                      labelColor: ColorName.primary,
                      labelStyle: Theme.of(
                        context,
                      ).textTheme.bodyMedium!.copyWith(
                        color: ColorName.primary,
                        fontWeight: FontWeight.w500,
                        fontSize: 12.sp,
                      ),
                      unselectedLabelColor: ColorName.grey,
                      automaticIndicatorColorAdjustment: true,
                      tabs: [
                        Tab(text: appLocalization.login),
                        Tab(text: appLocalization.signUp),
                      ],
                    ),

                    /// **Use Expanded to Fill Remaining Space**
                    BlocBuilder<NetworkBloc, NetworkState>(
                      builder: (context, state) {
                        return Expanded(
                          child: TabBarView(
                            controller: _tabController,
                            children: [
                              // auth login
                              AuthLogin(),

                              // auth register
                              AuthRegister(),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
