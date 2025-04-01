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
              // Top decoration
              Positioned(
                top: -130,
                left: -130,
                child: ClipRect(
                  child: SvgPicture.asset(
                    Assets.img.svg.proverbTopDecoration,
                    height: 240.h,
                    width: 0.w,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // Bottom decoration
              Positioned(
                bottom: -130,
                right: -130,
                child: SvgPicture.asset(
                  Assets.img.svg.proverbBottomDecoration,
                  height: 240.h,
                  width: 240.w,
                  fit: BoxFit.cover,
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
