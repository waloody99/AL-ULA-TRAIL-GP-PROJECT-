import 'dart:io';
import 'package:alulatrail/utils/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class MapService{

  MapService._();

  static Future<void> openMap(double latitude, double longitude, String placeId, context) async {
    final String googleUrlforAndroid = 'https://www.google.com/maps/search/?api=1&query=$latitude$longitude&query_place_id=$placeId';
    if(Platform.isAndroid){
      if(await canLaunch(googleUrlforAndroid)){
        await launch(googleUrlforAndroid);
      }else{
        openToast1(context, 'Google Maps App is required for this action');
      }
    }
  }

  
}