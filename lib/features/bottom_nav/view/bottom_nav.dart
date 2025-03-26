import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskapp/core/service/haptic_feedback_service.dart';
import 'package:taskapp/features/add_task/view/add_task_screen.dart';
import 'package:taskapp/features/archive/view/archive_screen.dart';
import 'package:taskapp/features/bottom_nav/view_modal/bottom_nav_bloc.dart';
import 'package:taskapp/features/home/view/home_screen.dart';
import 'package:taskapp/features/profile/view/profile_screen.dart';
import 'package:taskapp/features/proverb/view/proverb_screen.dart';
import 'package:taskapp/gen/colors.gen.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    /// screens
    final List<Widget> pages = [
      // home
      HomeScreen(),
      // archive
      ArchiveScreen(),
      // add task
      AddTaskScreen(),
      // proverb
      ProverbScreen(),
      // profile
      ProfileScreen(),
    ];

    return BlocBuilder<BottomNavBloc, BottomNavState>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            // screens
            body: pages[state.selectedIndex],
            // bottom nav
            bottomNavigationBar: BottomNavigationBar(
              showSelectedLabels: true,
              type: BottomNavigationBarType.fixed,
              showUnselectedLabels: true,
              iconSize: 18.h,
              unselectedLabelStyle: Theme.of(context).textTheme.bodySmall!
                  .copyWith(color: ColorName.grey, fontWeight: FontWeight.w500),
              selectedLabelStyle: Theme.of(
                context,
              ).textTheme.bodySmall!.copyWith(
                color: ColorName.primary,
                fontWeight: FontWeight.w600,
              ),
              selectedItemColor: ColorName.primary,
              unselectedItemColor: ColorName.grey,
              currentIndex: state.selectedIndex,
              onTap: (index) {
                // haptic feedback
                HapticFeedbackUtilityService.mediumImpact();

                // bottom nav bloc
                context.read<BottomNavBloc>().add(SelectTab(index: index));
              },
              items: const [
                // home
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined, color: ColorName.grey),
                  activeIcon: Icon(Icons.home, color: ColorName.primary),
                  label: 'Home',
                ),

                // archive
                BottomNavigationBarItem(
                  icon: Icon(Icons.archive_outlined, color: ColorName.grey),
                  activeIcon: Icon(Icons.archive, color: ColorName.primary),
                  label: 'Archive',
                ),

                // add
                BottomNavigationBarItem(
                  icon: Icon(Icons.add_circle_outline, color: ColorName.grey),
                  activeIcon: Icon(Icons.add_circle, color: ColorName.primary),
                  label: 'Add Task',
                ),

                // proverb
                BottomNavigationBarItem(
                  icon: Icon(Icons.lightbulb_outline, color: ColorName.grey),
                  activeIcon: Icon(Icons.lightbulb, color: ColorName.primary),
                  label: 'Proverb',
                ),

                // profile
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline, color: ColorName.grey),
                  activeIcon: Icon(Icons.person, color: ColorName.primary),
                  label: 'Profile',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
