import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:taskapp/features/proverb/view_modal/quote_bloc/quote_bloc.dart';
import 'package:taskapp/features/proverb/widgets/custom_build_quote_display.dart';
import 'package:taskapp/gen/assets.gen.dart';
import 'package:taskapp/gen/colors.gen.dart';

class ProverbScreen extends StatelessWidget {
  const ProverbScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(color: ColorName.white),
          child: Stack(
            children: [
              // Top left decoration
              Positioned(
                top: -130.h,
                left: -130.w,
                child: ClipRect(
                  child: SvgPicture.asset(
                    Assets.img.svg.proverbTopDecoration,
                    height: 240.h,
                    width: 0.w,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // Bottom right decoration
              Positioned(
                bottom: -130.h,
                right: -130.w,
                child: SvgPicture.asset(
                  Assets.img.svg.proverbBottomDecoration,
                  height: 240.h,
                  width: 240.w,
                  fit: BoxFit.cover,
                ),
              ),

              // top  right decoration
              Positioned(
                top: -130.h,
                right: -130.w,
                child: ClipRect(
                  // Clip overflowing content
                  child: SvgPicture.asset(
                    Assets.img.svg.decorationTop,
                    height: 240.h,
                    width: 0.w,
                    color: ColorName.primary,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // bottom  left decoration
              Positioned(
                bottom: -130.h,
                left: -130.w,
                child: ClipRect(
                  child: Transform.rotate(
                    angle: pi,
                    child: SvgPicture.asset(
                      Assets.img.svg.decorationTop,
                      height: 240.h,
                      width: 240.w,
                      color: ColorName.primary,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),

              // top  right decoration
              Positioned(
                top: 20,
                right: 20,
                child: Tooltip(
                  message: "Quotes are displayed only in English",

                  textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontSize: 10.sp,
                    color: ColorName.white,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  waitDuration: Duration(milliseconds: 300),
                  showDuration: Duration(seconds: 2),
                  child: Container(
                    width: 40.0,
                    height: 40.0,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorName.primary,
                    ),
                    child: const Icon(Icons.info, color: ColorName.white),
                  ),
                ),
              ),

              // Quote Display
              Align(
                alignment: Alignment.center,
                child: BlocBuilder<QuoteBloc, QuoteState>(
                  builder: (context, state) {
                    if (state is QuoteLoading) {
                      return Skeletonizer(
                        child: CustomBuildQuoteDisplay(
                          quote: "Loading quote...",
                          author: "Loading...",
                        ),
                      );
                    } else if (state is QuoteLoaded) {
                      return CustomBuildQuoteDisplay(
                        quote: state.quote,
                        author: state.author,
                      );
                    } else if (state is QuoteError) {
                      return CustomBuildQuoteDisplay(
                        quote: state.message,
                        author: "",
                      );
                    }
                    return SizedBox();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
