import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_home_mobile_app/feature/viewmodel/telemetry_data_notifier.dart';
import 'package:smart_home_mobile_app/product/constants/icons/icon_constants.dart';
import 'package:smart_home_mobile_app/product/constants/lang/local_keys_tr.dart';
import 'package:smart_home_mobile_app/product/themes/app_colors.dart';
import 'package:smart_home_mobile_app/product/widgets/cards/custom_no_connection_icon_card.dart';

class CustomSmartLockCard extends ConsumerStatefulWidget {
  const CustomSmartLockCard({super.key});

  @override
  ConsumerState createState() => _CustomSmartLockCardState();
}

class _CustomSmartLockCardState extends ConsumerState<CustomSmartLockCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          if (ref.watch(kTelemetryDataProvider).devicePowerStatus) {
            ref.read(kTelemetryDataProvider.notifier).sendTelemetryData(smartLockStatus: !ref.watch(kTelemetryDataProvider).smartLockStatus);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(LocalKeysTr.DEVICE_IS_NOT_ACTIVE),
                duration: Duration(seconds: 2),
              ),
            );
          }
        });
      },
      child: Container(
        decoration: BoxDecoration(color: AppColors.SUBNAUTICAL, borderRadius: BorderRadius.circular(10)),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        height: 180,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Stack(
              children: [
                SizedBox(
                    height: 100,
                    width: 160,
                    child: ref.watch(kTelemetryDataProvider).smartLockStatus
                        ? Image.asset(IconConstants.getIconAsPNG(IconConstants.unlockedIconPath))
                        : Image.asset(IconConstants.getIconAsPNG(IconConstants.lockedIconPath))),
                ref.watch(kTelemetryDataProvider).deviceConnectionStatus ? SizedBox() : CustomNoConnectionIconCard()
              ],
            ),
            Text(
                ref.watch(kTelemetryDataProvider).smartLockStatus
                    ? LocalKeysTr.THE_DOOR_IS_UNLOCKED.toUpperCase()
                    : LocalKeysTr.THE_DOOR_IS_LOCKED.toUpperCase(),
                style: TextStyle(color: AppColors.WHITE, fontSize: 16, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }
}
