import 'package:flutter/material.dart';
import 'package:smart_home_mobile_app/product/constants/lang/local_keys_tr.dart';
import 'package:smart_home_mobile_app/product/enums/info_card_status.dart';
import 'package:smart_home_mobile_app/product/themes/app_colors.dart';

class CustomTitleInfoCard extends StatelessWidget {
  final InfoCardStatus infoCardStatus;
  const CustomTitleInfoCard({super.key, required this.infoCardStatus});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _buildCardInfoColor(),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(children: [
        _buildCardInfoIcon(),
        SizedBox(width: 10),
        _buildCardInfoText()
      ]),
    );
  }
  BoxDecoration _buildCardInfoColor(){
    switch(infoCardStatus){
      case InfoCardStatus.CONNECTION_ERROR : return BoxDecoration(color: AppColors.LIFE_GUARD, borderRadius: BorderRadius.all(Radius.circular(6)));
      case InfoCardStatus.SENSOR_ERROR : return BoxDecoration(color: AppColors.PICO_ORANGE, borderRadius: BorderRadius.all(Radius.circular(6)));
    }

  }
  Widget _buildCardInfoIcon(){
    switch(infoCardStatus){
      case InfoCardStatus.CONNECTION_ERROR : return Icon(Icons.signal_wifi_statusbar_connected_no_internet_4);
      case InfoCardStatus.SENSOR_ERROR : return Icon(Icons.warning);
    }
  }
  Widget _buildCardInfoText(){
    switch(infoCardStatus){
      case InfoCardStatus.CONNECTION_ERROR : return Text(LocalKeysTr.DEVICE_CONNECTION_ERROR, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400));
      case InfoCardStatus.SENSOR_ERROR : return Text(LocalKeysTr.DHT11_TEMPERATURE_SENSOR_ERROR, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400));
    }

  }
}
