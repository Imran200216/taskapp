import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
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
                    // page 1
                    CustomOnBoarding(
                      onBoardingTitle: appLocalization.onBoardingTitleFirst,
                      onBoardingSubTitle:
                          appLocalization.onBoardingSubTitleFirst,
                      imgUrlFirst:
                          "https://images.unsplash.com/photo-1611224923853-80b023f02d71?q=80&w=1339&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                      imgUrlSecond:
                          "https://images.unsplash.com/photo-1590402494756-10c265b9d736?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                      imgUrlThird:
                          "https://images.unsplash.com/photo-1586473219010-2ffc57b0d282?q=80&w=1364&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                      imgUrlFourth:
                          "https://images.unsplash.com/photo-1589987607627-616cac5c2c5a?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                    ),

                    // page 2
                    CustomOnBoarding(
                      onBoardingTitle: appLocalization.onBoardingTitleSecond,
                      onBoardingSubTitle:
                          appLocalization.onBoardingSubTitleSecond,
                      imgUrlFirst:
                          "https://images.unsplash.com/photo-1590402494587-44b71d7772f6?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                      imgUrlSecond:
                          "https://images.unsplash.com/photo-1563986768609-322da13575f3?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                      imgUrlThird:
                          "https://plus.unsplash.com/premium_photo-1661370149497-0a6e3aa2394a?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                      imgUrlFourth:
                          "https://images.unsplash.com/photo-1634078111133-a1e12d6131b6?q=80&w=1230&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
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
                        count: 2,
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
                                    state.currentPage == 0
                                ? "Next"
                                : "Get Started",

                        onTap: () async {
                          if (state is OnBoardingPageChangedSuccess) {
                            final nextPage = state.currentPage + 1;

                            if (nextPage < 2) {
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

                              if (!context.mounted)
                                return; // ✅ Check if widget is still active before navigating
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
