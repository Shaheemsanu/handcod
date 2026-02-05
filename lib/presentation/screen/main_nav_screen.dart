import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:handcode_test/core/constants/assets.dart';
import 'package:handcode_test/core/constants/colors.dart';
import 'package:handcode_test/core/constants/sizes.dart';
import 'package:handcode_test/core/routes/route_names.dart';

class MainNavScreen extends StatelessWidget {
  final Widget child;

  const MainNavScreen({super.key, required this.child});

  int _getSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();

    if (location.startsWith(RouteNames.bookings)) return 1;
    if (location.startsWith(RouteNames.account)) return 2;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = _getSelectedIndex(context);

    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: child,
      bottomNavigationBar: _bottomNav(context, selectedIndex),
    );
  }

  Widget _bottomNav(BuildContext context, int selectedIndex) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: AppSizes.cardRadius,
        left: AppSizes.cardRadius,
        right: AppSizes.cardRadius,
      ),
      child: Container(
        height: 70,

        decoration: BoxDecoration(
          color: Colors.white,

          borderRadius: BorderRadius.circular(AppSizes.borderRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha:0.08),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _navItem(
              context,
              0,
              AppIcons.home,
              RouteNames.home,
              "Home",
              selectedIndex,
            ),
            _navItem(
              context,
              1,
              AppIcons.bookings,
              RouteNames.bookings,
              "Bookings",
              selectedIndex,
            ),
            _navItem(
              context,
              2,
              AppIcons.account,
              RouteNames.account,
              "Account",
              selectedIndex,
            ),
          ],
        ),
      ),
    );
  }

  Widget _navItem(
    BuildContext context,
    int index,
    String iconPath,
    String route,
    String label,
    int selectedIndex,
  ) {
    final isActive = selectedIndex == index;

    return GestureDetector(
      onTap: () => context.go(route),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isActive ? AppColors.lightGreenBg : Colors.white,
          borderRadius: BorderRadius.circular(AppSizes.borderRadius),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              iconPath,
              height: 24,
              width: 24,
              colorFilter: !isActive
                  ? ColorFilter.mode(Colors.grey, BlendMode.srcIn)
                  : null,
            ),
            if (isActive) ...[
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  color: AppColors.primaryGreen,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
