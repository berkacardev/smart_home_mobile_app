import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_home_mobile_app/feature/view/cctv_camera/cctv_camera_view.dart';
import 'package:smart_home_mobile_app/feature/viewmodel/telemetry_data_notifier.dart';
import 'package:smart_home_mobile_app/product/enums/info_card_status.dart';
import 'package:smart_home_mobile_app/product/themes/app_colors.dart';
import 'package:smart_home_mobile_app/product/widgets/appbar/custom_appbar.dart';
import 'package:smart_home_mobile_app/product/widgets/buttons/custom_power_button.dart';
import 'package:smart_home_mobile_app/product/widgets/cards/custom_cctv_card.dart';
import 'package:smart_home_mobile_app/product/widgets/cards/custom_smart_lighting_card.dart';
import 'package:smart_home_mobile_app/product/widgets/cards/custom_smart_lock_card.dart';
import 'package:smart_home_mobile_app/product/widgets/cards/custom_temperature_card.dart';
import 'package:smart_home_mobile_app/product/widgets/cards/custom_title_info_card.dart';
import 'package:smart_home_mobile_app/product/widgets/overlays/custom_loading_indicator.dart';

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
    ref.listen(kTelemetryDataProvider, (previous, next) {

    });
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(),
      body: Container(
        decoration: BoxDecoration(color: AppColors.INFINITE_NIGHT),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(vertical: 40, horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 42),
              ..._buildInfoCards(),
              SizedBox(height: 10),
              CustomPowerButton(),
              SizedBox(height: 36),
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: CustomTemperatureCard()),
                      SizedBox(width: 10),
                      Expanded(child: CustomSmartLockCard()),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                          child: InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => CctvCameraView()));
                              },
                              child: CustomCctvCard())),
                      SizedBox(width: 10),
                      Expanded(child: CustomSmartLightingCard()),
                    ],
                  ),
                ],
              ),
            ],
          ),
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
