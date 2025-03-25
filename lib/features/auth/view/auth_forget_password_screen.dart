import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:taskapp/commons/widgets/custom_icon_filled_btn.dart';
import 'package:taskapp/commons/widgets/custom_text_field.dart';
import 'package:taskapp/gen/assets.gen.dart';
import 'package:taskapp/gen/colors.gen.dart';

class AuthForgetPasswordScreen extends StatelessWidget {
  const AuthForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                /// title
                Text(
                  textAlign: TextAlign.center,
                  "Forget Password",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: ColorName.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                SizedBox(height: 10.h),

                // Description
                Text(
                  textAlign: TextAlign.center,
                  "Enter your email account to reset password",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: ColorName.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                Spacer(),

                // forget password svg
                SvgPicture.asset(
                  Assets.img.svg.forgetPassword,
                  height: 0.22.sh,
                  fit: BoxFit.cover,
                ),

                Spacer(flex: 3),

                // email text field
                CustomTextField(
                  hasBorder: true,
                  hintText: "Enter your email",
                  prefixIcon: Icons.alternate_email,
                ),

                SizedBox(height: 14.h),

                // login btn
                CustomIconFilledBtn(
                  onTap: () {},
                  btnTitle: "Continue",
                  iconPath: Assets.icon.svg.login,
                ),

                SizedBox(height: 14.h),

                // back to login text btn
                Align(
                  alignment: Alignment.bottomCenter,
                  child: TextButton(
                    onPressed: () {
                      // login screen
                      GoRouter.of(context).pushNamed("auth");
                    },
                    child: Text(
                      textAlign: TextAlign.center,
                      "Back to login",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: ColorName.primary,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline,
                        decorationColor: ColorName.primary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
