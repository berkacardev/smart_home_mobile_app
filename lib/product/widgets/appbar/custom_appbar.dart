import 'package:flutter/material.dart';
import 'package:smart_home_mobile_app/product/constants/lang/local_keys_tr.dart';
import 'package:smart_home_mobile_app/product/themes/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      title: Text(
        LocalKeysTr.MY_SMART_HOME.toUpperCase(),
        style: const TextStyle(
          color: AppColors.WHITE,
          fontSize: 22,
          fontWeight: FontWeight.w400,
          letterSpacing: 1.2,
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(8),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Container(
            height: 1,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 5);
}
