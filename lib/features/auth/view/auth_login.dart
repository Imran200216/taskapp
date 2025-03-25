import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:taskapp/commons/widgets/custom_auth_social_btn.dart';
import 'package:taskapp/commons/widgets/custom_icon_filled_btn.dart';
import 'package:taskapp/commons/widgets/custom_text_field.dart';
import 'package:taskapp/gen/assets.gen.dart';
import 'package:taskapp/gen/colors.gen.dart';

class AuthLogin extends StatefulWidget {
  const AuthLogin({super.key});

  @override
  State<AuthLogin> createState() => _AuthLoginState();
}

class _AuthLoginState extends State<AuthLogin> {
  // controllers
  final TextEditingController emailLoginController = TextEditingController();
  final TextEditingController passwordLoginController = TextEditingController();

  // form key
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: ColorName.authTabBarBgColor),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Apple login btn
              CustomAuthSocialBtn(
                onTap: () {},
                btnTitle: "Login with Apple",
                iconPath: Assets.icon.svg.apple,
              ),

              SizedBox(height: 10.h),

              // google login btn
              CustomAuthSocialBtn(
                onTap: () {},
                btnTitle: "Login with Google",
                iconPath: Assets.icon.svg.google,
              ),

              SizedBox(height: 20.h),

              //  or continue with email text
              Text(
                textAlign: TextAlign.center,
                "or continue with email",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: ColorName.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),

              SizedBox(height: 20.h),

              // email text field
              CustomTextField(
                hintText: "Enter your email",
                prefixIcon: Icons.alternate_email,
              ),

              SizedBox(height: 14.h),

              // password text field
              CustomTextField(
                hintText: "Enter your password",
                isPassword: true,
                prefixIcon: Icons.lock_outline,
              ),

              SizedBox(height: 14.h),

              // forget password text btn
              Align(
                alignment: Alignment.bottomLeft,
                child: TextButton(
                  onPressed: () {
                    // forget password screen
                    GoRouter.of(context).pushNamed("authForget");
                  },
                  child: Text(
                    textAlign: TextAlign.center,
                    "Forget Password?",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: ColorName.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),

              Spacer(),

              // login btn
              CustomIconFilledBtn(
                onTap: () {},
                btnTitle: "Login",
                iconPath: Assets.icon.svg.login,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
