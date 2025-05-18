import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_home_mobile_app/feature/view/cctv_camera/cctv_camera_view.dart';
import 'package:smart_home_mobile_app/feature/viewmodel/telemetry_data_notifier.dart';
import 'package:smart_home_mobile_app/product/constants/lang/local_keys_tr.dart';
import 'package:smart_home_mobile_app/product/enums/info_card_status.dart';
import 'package:smart_home_mobile_app/product/themes/app_colors.dart';
import 'package:smart_home_mobile_app/product/widgets/appbar/custom_appbar.dart';
import 'package:smart_home_mobile_app/product/widgets/buttons/custom_power_button.dart';
import 'package:smart_home_mobile_app/product/widgets/cards/custom_cctv_card.dart';
import 'package:smart_home_mobile_app/product/widgets/cards/custom_smart_lighting_card.dart';
import 'package:smart_home_mobile_app/product/widgets/cards/custom_smart_lock_card.dart';
import 'package:smart_home_mobile_app/product/widgets/cards/custom_temperature_card.dart';
import 'package:smart_home_mobile_app/product/widgets/cards/custom_title_info_card.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(kTelemetryDataProvider.notifier).listenConnectionState();
      ref.read(kTelemetryDataProvider.notifier).listenTelemetryState();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(),
      body: Container(
        decoration: BoxDecoration(color: AppColors.INFINITE_NIGHT),
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 40, horizontal: 10),
        child: Column(
          children: [
            SizedBox(height: 20),
            ..._buildInfoCards(),
            SizedBox(height: 30),
            ref.watch(kTelemetryDataProvider).deviceConnectionStatus ? CustomPowerButton() : SizedBox(),
            SizedBox(height: 40),
            Column(
              children: [
                Row(
                  children: [
                    Expanded(child: ref.watch(kTelemetryDataProvider).deviceConnectionStatus ? CustomTemperatureCard() : SizedBox()),
                    SizedBox(width: 10),
                    Expanded(child: ref.watch(kTelemetryDataProvider).deviceConnectionStatus ? CustomSmartLockCard() : SizedBox()),
                  ],
                ),
                SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                        child: ref.watch(kTelemetryDataProvider).deviceConnectionStatus
                            ? InkWell(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => CctvCameraView()));
                                },
                                child: CustomCctvCard())
                            : SizedBox()),
                    SizedBox(width: 10),
                    Expanded(child: ref.watch(kTelemetryDataProvider).deviceConnectionStatus ? CustomSmartLightingCard() : SizedBox()),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildInfoCards() {
    List<Widget> infoCards = [];
    var state = ref.watch(kTelemetryDataProvider);
    if (!state.deviceConnectionStatus) {
      infoCards.add(CustomTitleInfoCard(infoCardStatus: InfoCardStatus.CONNECTION_ERROR));
    }
    if (state.temperatureSensorErrorStatus) {
      infoCards.add(CustomTitleInfoCard(infoCardStatus: InfoCardStatus.SENSOR_ERROR));
    }
    return infoCards;
  }
}
