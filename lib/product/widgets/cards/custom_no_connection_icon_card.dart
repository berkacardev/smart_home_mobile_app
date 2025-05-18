import 'package:flutter/material.dart';
import 'package:smart_home_mobile_app/product/themes/app_colors.dart';

class CustomNoConnectionIconCard extends StatelessWidget {
  final double? top;
  final double? right;
  const CustomNoConnectionIconCard({super.key, this.top, this.right});


  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: right ?? 0,
      top: top ?? 60,
      child: Container(
        decoration: BoxDecoration(color: AppColors.LIFE_GUARD, shape: BoxShape.circle),
        width: 30,
        height: 30,
        child: Padding(padding: EdgeInsets.all(5), child: Icon(Icons.signal_wifi_statusbar_connected_no_internet_4, color: AppColors.WHITE, size: 20)),
      ),
    );
  }
}
