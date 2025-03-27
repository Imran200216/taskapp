import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taskapp/features/proverb/view_modal/quote_bloc/quote_bloc.dart';
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
                      return const CircularProgressIndicator();
                    } else if (state is QuoteLoaded) {
                      return _buildQuoteDisplay(state.quote, state.author);
                    } else if (state is QuoteError) {
                      return _buildQuoteDisplay(state.message, "");
                    }
                    return const Text("Press the button to load a quote");
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// build quote
  Widget _buildQuoteDisplay(String quote, String author) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        /// Starting quotes
        SvgPicture.asset(
          Assets.icon.svg.quoteStarting,
          height: 50.h,
          width: 50.w,
          fit: BoxFit.cover,
          color: ColorName.profileBgColor,
        ),

        SizedBox(height: 20.h),

        /// Quote Text
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Text(
            '"$quote"',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: ColorName.profileBgColor,
            ),
          ),
        ),

        SizedBox(height: 10.h),

        /// Author Name
        Text(
          author.isNotEmpty ? "- $author" : "",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16.sp,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w500,
            color: ColorName.grey,
          ),
        ),

        SizedBox(height: 20.h),

        /// Ending quotes
        SvgPicture.asset(
          Assets.icon.svg.quoteEnding,
          height: 50.h,
          width: 50.w,
          fit: BoxFit.cover,
          color: ColorName.profileBgColor,
        ),
      ],
    );
  }
}
