import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Config {

  final String appName = 'Al-Ula Trail - العلا تريل';
  final String mapAPIKey = 'AIzaSyALuTzgcnKhTF03XVI0vDFbuZOkmYmn8to';
  final String countryName = 'Saudi Arabia';
  final String splashIcon = 'assets/images/splash.png';
  final String supportEmail = 'wkialdukhail@sm.imamu.edu.sa';
  final String privacyPolicyUrl = 'https://www.freeprivacypolicy.com/live/23f4faba-9c5e-4f89-9619-7a7738f83627';
  final String yourWebsiteUrl = 'https://al-ula-trail.web.app/#/';

  // app theme color - primary color
  static final Color appThemeColor = Colors.orange.shade700;

  //special two Areas name that has been already upload from the admin panel
  final String specialArea1 = 'Arts - فنون';
  final String specialArea2 = 'Hegra - الحجر';
  final CameraPosition initialCameraPosition = CameraPosition(
    target: LatLng(26.550264,37.967865), //here
    zoom: 10,
  );

  
  //google maps marker icons
  final String hotelIcon = 'assets/images/hotel.png';
  final String restaurantIcon = 'assets/images/restaurant.png';
  final String hotelPinIcon = 'assets/images/hotel_pin.png';
  final String restaurantPinIcon = 'assets/images/restaurant_pin.png';
  final String drivingMarkerIcon = 'assets/images/driving_pin.png';
  final String destinationMarkerIcon = 'assets/images/destination_map_marker.png';

  
  
  //Intro images
  final String introImage1 = 'assets/images/travel6.png';
  final String introImage2 = 'assets/images/travel1.png';
  final String introImage3 = 'assets/images/travel5.png';

  
  //Language Setup
  final List<String> languages = [
    'English',
    'Arabic'
  ];


}