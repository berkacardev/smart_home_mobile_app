import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_home_mobile_app/feature/viewmodel/telemetry_data_notifier.dart';
import 'package:smart_home_mobile_app/product/themes/app_colors.dart';

class CustomPowerButton extends ConsumerStatefulWidget {
  const CustomPowerButton({super.key});

  @override
  ConsumerState createState() => _CustomPowerButtonState();
}

class _CustomPowerButtonState extends ConsumerState<CustomPowerButton> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ref.read(kTelemetryDataProvider.notifier).sendTelemetryData(devicePowerStatus: !ref.watch(kTelemetryDataProvider).devicePowerStatus);
      },
      child: Center(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: ref.watch(kTelemetryDataProvider).devicePowerStatus ? AppColors.NORTH_TEXAS_GREEN : AppColors.SPACE_GREY,
                      width: ref.watch(kTelemetryDataProvider).devicePowerStatus ? 2 : 3)),
              padding: EdgeInsets.all(15),
              child: Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: ref.watch(kTelemetryDataProvider).devicePowerStatus ? AppColors.NORTH_TEXAS_GREEN : AppColors.SPACE_GREY, width: ref.watch(kTelemetryDataProvider).devicePowerStatus ? 2 : 3)),
                child: Icon(Icons.power_settings_new_rounded, color: ref.watch(kTelemetryDataProvider).devicePowerStatus ? AppColors.WHOLE_NINE_YARDS : AppColors.SPACE_GREY, size: 100),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
