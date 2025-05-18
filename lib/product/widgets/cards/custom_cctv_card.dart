import 'package:flutter/material.dart';
import 'package:smart_home_mobile_app/product/constants/icons/icon_constants.dart';
import 'package:smart_home_mobile_app/product/constants/lang/local_keys_tr.dart';
import 'package:smart_home_mobile_app/product/themes/app_colors.dart';

class CustomCctvCard extends StatelessWidget {
  const CustomCctvCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: AppColors.SUBNAUTICAL, borderRadius: BorderRadius.circular(10)),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      height: 180,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(height: 100, child: Image.asset(IconConstants.getIconAsPNG(IconConstants.cctvIconPath))),
          Text(LocalKeysTr.CCTV_CAMERA.toUpperCase(), style: TextStyle(color: AppColors.WHITE, fontSize: 16, fontWeight: FontWeight.w500))
        ],
      ),
    );
  }
}
