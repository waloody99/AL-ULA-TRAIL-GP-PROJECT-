import 'dart:io';

class AdConfig {

  static const int userClicksAmountsToShowEachAd  = 4;

  //-- Admob Ads --
  static const String admobAppIdAndroid = 'ca-app-pub-3940256099942544~3347511713';
  // interstitial ad ids - admob
  static const String admobInterstitialAdUnitIdAndroid = 'ca-app-pub-3940256099942544/1033173712';
  //-- Fb Ads --
  static const String fbInterstitialAdUnitIdAndroid = '193186341991913_35*************';


  String getAdmobAppId () {
    if(Platform.isAndroid){
      return admobAppIdAndroid;
    }
    else{
      return admobAppIdAndroid;
    }
  }


  String getAdmobInterstitialAdUnitId (){
    if(Platform.isAndroid){
      return admobInterstitialAdUnitIdAndroid;
    }
    else{
      return admobInterstitialAdUnitIdAndroid;
    }
  }


  String getFbInterstitialAdUnitId (){
    if(Platform.isAndroid){
      return fbInterstitialAdUnitIdAndroid;
    }
    else{
      return fbInterstitialAdUnitIdAndroid;
    }
  }


}