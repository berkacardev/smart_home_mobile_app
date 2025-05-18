import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_home_mobile_app/feature/viewmodel/telemetry_data_notifier.dart';
import 'package:smart_home_mobile_app/product/constants/icons/icon_constants.dart';
import 'package:smart_home_mobile_app/product/constants/units.dart';
import 'package:smart_home_mobile_app/product/themes/app_colors.dart';

class CustomTemperatureCard extends ConsumerStatefulWidget {
  const CustomTemperatureCard({super.key});

  @override
  ConsumerState createState() => _CustomTemperatureCardState();
}

class _CustomTemperatureCardState extends ConsumerState<CustomTemperatureCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: AppColors.SUBNAUTICAL, borderRadius: BorderRadius.circular(10)),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      height: 180,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(height: 100, child: Image.asset(IconConstants.getIconAsPNG(IconConstants.temperatureIconPath))),
          ref.watch(kTelemetryDataProvider).devicePowerStatus ? Text("${ref.watch(kTelemetryDataProvider).temperatureValue}${Units.CELSIUS_DEGREE}", style: TextStyle(color: AppColors.WHITE, fontSize: 16, fontWeight: FontWeight.w500)) : Text("-${Units.CELSIUS_DEGREE}", style: TextStyle(color: AppColors.WHITE, fontSize: 16, fontWeight: FontWeight.w500))
        ],
      ),
    );
  }
}
