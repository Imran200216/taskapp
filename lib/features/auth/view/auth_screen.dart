import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskapp/features/auth/view/auth_login.dart';
import 'package:taskapp/features/auth/view/auth_register.dart';
import 'package:taskapp/gen/colors.gen.dart';

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
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorName.white,
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    /// title
                    Text(
                      textAlign: TextAlign.center,
                      "Welcome to TaskNotify",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: ColorName.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    SizedBox(height: 10.h),

                    // Description
                    Text(
                      textAlign: TextAlign.center,
                      "Sign up or login below to manage\nyour project, task and your productivity",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: ColorName.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    SizedBox(height: 10.h),
                  ],
                ),
              ),

              // tab bar
              TabBar(
                controller: _tabController,
                indicatorColor: ColorName.primary,
                indicatorSize: TabBarIndicatorSize.tab,
                labelColor: ColorName.primary,
                labelStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: ColorName.primary,
                  fontWeight: FontWeight.w500,
                  fontSize: 12.sp,
                ),
                unselectedLabelColor: ColorName.grey,
                automaticIndicatorColorAdjustment: true,
                tabs: const [Tab(text: "Login"), Tab(text: "Sign Up")],
              ),

              /// TabBarView (Screens for each tab)
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    // auth login
                    AuthLogin(),

                    // auth sign up
                    AuthRegister(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
