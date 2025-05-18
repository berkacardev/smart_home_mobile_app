import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_home_mobile_app/feature/viewmodel/telemetry_data_notifier.dart';
import 'package:smart_home_mobile_app/product/constants/icons/icon_constants.dart';
import 'package:smart_home_mobile_app/product/constants/lang/local_keys_tr.dart';
import 'package:smart_home_mobile_app/product/themes/app_colors.dart';
import 'package:smart_home_mobile_app/product/widgets/cards/custom_no_connection_icon_card.dart';

class CustomCctvCard extends ConsumerStatefulWidget {
  const CustomCctvCard({super.key});

  @override
  ConsumerState createState() => _CustomCctvCardState();
}

class _CustomCctvCardState extends ConsumerState<CustomCctvCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: AppColors.SUBNAUTICAL, borderRadius: BorderRadius.circular(10)),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      height: 180,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Stack(
            children: [
              Align(child: SizedBox(height: 100, width: 160, child: Image.asset(IconConstants.getIconAsPNG(IconConstants.cctvIconPath)))),
              ref.watch(kTelemetryDataProvider).deviceConnectionStatus ? SizedBox() : CustomNoConnectionIconCard()
            ],
          ),
          Text(LocalKeysTr.CCTV_CAMERA.toUpperCase(), style: TextStyle(color: AppColors.WHITE, fontSize: 16, fontWeight: FontWeight.w500))
        ],
      ),
    );
  }
}
