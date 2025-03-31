import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:taskapp/core/constants/app_constants.dart';
import 'package:taskapp/core/locator/service_locator.dart';
import 'package:taskapp/features/on_boarding/view_modal/on_boarding_bloc.dart';
import 'package:taskapp/features/on_boarding/widgets/custom_on_boarding.dart';
import 'package:taskapp/features/on_boarding/widgets/custom_on_boarding_btn.dart';
import 'package:taskapp/gen/colors.gen.dart';
import 'package:taskapp/l10n/app_localizations.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  /// page controller
  final PageController pageController = PageController();

  @override
  void initState() {
    super.initState();

    pageController.addListener(() {
      context.read<OnBoardingBloc>().add(
        PageChangeEvent(pageIndex: pageController.page?.round() ?? 0),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // app localization
    final appLocalization = AppLocalizations.of(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorName.white,
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),

              Expanded(
                flex: 4,
                child: PageView(
                  controller: pageController,
                  onPageChanged: (index) {
                    context.read<OnBoardingBloc>().add(
                      PageChangeEvent(pageIndex: index),
                    );
                  },
                  children: [
                    // Page 1
                    CustomOnBoarding(
                      onBoardingTitle: appLocalization.onBoardingTitleFirst,
                      onBoardingSubTitle:
                          appLocalization.onBoardingSubTitleFirst,
                      imgUrlFirst: AppConstants.onBoardingPage1Img1,
                      imgUrlSecond: AppConstants.onBoardingPage1Img2,
                      imgUrlThird: AppConstants.onBoardingPage1Img3,
                      imgUrlFourth: AppConstants.onBoardingPage1Img4,
                    ),

                    // Page 2
                    CustomOnBoarding(
                      onBoardingTitle: appLocalization.onBoardingTitleSecond,
                      onBoardingSubTitle:
                          appLocalization.onBoardingSubTitleSecond,
                      imgUrlFirst: AppConstants.onBoardingPage2Img1,
                      imgUrlSecond: AppConstants.onBoardingPage2Img2,
                      imgUrlThird: AppConstants.onBoardingPage2Img3,
                      imgUrlFourth: AppConstants.onBoardingPage2Img4,
                    ),

                    // Page 3
                    CustomOnBoarding(
                      onBoardingTitle: appLocalization.onBoardingTitleThird,
                      onBoardingSubTitle:
                          appLocalization.onBoardingSubTitleThird,
                      imgUrlFirst: AppConstants.onBoardingPage3Img1,
                      imgUrlSecond: AppConstants.onBoardingPage3Img2,
                      imgUrlThird: AppConstants.onBoardingPage3Img3,
                      imgUrlFourth: AppConstants.onBoardingPage3Img4,
                    ),
                  ],
                ),
              ),

              Spacer(),

              /// SmoothPageIndicator
              BlocBuilder<OnBoardingBloc, OnBoardingState>(
                builder: (context, state) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SmoothPageIndicator(
                        controller: pageController,
                        count: 3,
                        effect: ExpandingDotsEffect(
                          activeDotColor: ColorName.primary,
                          dotColor: ColorName.grey,
                          dotHeight: 5.h,
                          dotWidth: 10.w,
                        ),
                      ),

                      // next btn
                      CustomOnBoardingBtn(
                        btnTitle:
                            state is OnBoardingPageChangedSuccess &&
                                    state.currentPage < 2
                                ? appLocalization.next
                                : appLocalization.getStarted,

                        onTap: () async {
                          if (state is OnBoardingPageChangedSuccess) {
                            final nextPage = state.currentPage + 1;

                            if (nextPage < 3) {
                              // Move the PageView forward
                              pageController.animateToPage(
                                nextPage,
                                duration: Duration(milliseconds: 500),
                                curve: Curves.easeInOut,
                              );

                              // Update the Bloc state
                              locator.get<OnBoardingBloc>().add(
                                PageChangeEvent(pageIndex: nextPage),
                              );
                            } else {
                              // Onboarding finished, store status in Hive and navigate to auth screen
                              var box = await Hive.openBox(
                                'userOnBoardingStatusBox',
                              ); // ✅ Ensure box is opened
                              await box.put('userOnBoardingStatus', true);

                              if (!context.mounted) return;

                              // auth screen
                              GoRouter.of(context).pushReplacementNamed("auth");
                            }
                          }
                        },
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
