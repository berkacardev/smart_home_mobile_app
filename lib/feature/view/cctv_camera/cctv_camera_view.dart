import 'package:flutter/material.dart';
import 'package:mjpeg_stream/mjpeg_stream.dart';
import 'package:smart_home_mobile_app/product/constants/global_constants.dart';
import 'package:smart_home_mobile_app/product/constants/lang/local_keys_tr.dart';
import 'package:smart_home_mobile_app/product/themes/app_colors.dart';
import 'package:smart_home_mobile_app/product/widgets/appbar/custom_appbar.dart';

class CctvCameraView extends StatelessWidget {
  const CctvCameraView({super.key});

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
            SizedBox(height: 60),
            Text(LocalKeysTr.CCTV_CAMERA.toUpperCase(),style: TextStyle(color: AppColors.WHITE,fontSize: 18)),
            SizedBox(height: 20),
            MJPEGStreamScreen(
              streamUrl: GlobalConstants.CCTV_CAMERA_LIVE_URL,
              showLiveIcon: true,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}
