import 'package:alulatrail/blocs/ads_bloc.dart';
import 'package:alulatrail/blocs/notification_bloc.dart';
import 'package:alulatrail/pages/blogs.dart';
import 'package:alulatrail/pages/bookmark.dart';
import 'package:alulatrail/pages/explore.dart';
import 'package:alulatrail/pages/profile.dart';
import 'package:alulatrail/pages/areas.dart';
import 'package:alulatrail/services/app_service.dart';
import 'package:alulatrail/utils/snacbar.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:external_app_launcher/external_app_launcher.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _currentIndex = 0;
  PageController _pageController = PageController();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  List<IconData> iconList = [
    Feather.home,
    Feather.grid,
    Feather.list,
    Feather.bookmark,
    Feather.user
  ];


  void onTabTapped(int index) {
    setState(()=> _currentIndex = index);
   _pageController.animateToPage(index,
      curve: Curves.easeIn,
      duration: Duration(milliseconds: 300)
    );
   
  }


  Future configureAds ()async{
    await context.read<AdsBloc>().initiateAdsOnApp();
    context.read<AdsBloc>().loadAds();
  }



 @override
  void initState() {
    super.initState();
    AppService().checkInternet().then((hasInternet) {
      if (hasInternet == false) {
       openSnacbar(scaffoldKey, 'no internet'.tr());
      }
    });


    Future.delayed(Duration(milliseconds: 0))
    .then((value) async{
      await context.read<NotificationBloc>().initFirebasePushNotification(context);
      await context.read<AdsBloc>().checkAdsEnable().then((isEnabled)async{
        if(isEnabled != null && isEnabled == true){
          debugPrint('ads enabled true');
          configureAds();      /* enable this line to enable ads on the app */
          
        }else{
          debugPrint('ads enabled false');
        }
      });

    });
  }
  


  @override
  void dispose() {
    _pageController.dispose();
    context.read<AdsBloc>().dispose();
    super.dispose();
  }


  Future _onWillPop () async{
    if(_currentIndex != 0){
      setState (()=> _currentIndex = 0);
      _pageController.animateToPage(0, duration: Duration(milliseconds: 300), curve: Curves.easeIn);
    }else{
      await SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop', true);
    }
  }




  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => await _onWillPop(),
      child: Scaffold(
        key: scaffoldKey,
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.orange,
          onPressed: () async {
            await LaunchApp.openApp(
              androidPackageName: 'com.FahAlm.Alulatrail',
              openStore: false,
            );
          },
          tooltip: 'increment',
          child: Icon(Icons.view_in_ar),
      ),
      bottomNavigationBar: AnimatedBottomNavigationBar(
          icons: iconList,
          activeColor: Theme.of(context).primaryColor,
          gapLocation: GapLocation.none,
          activeIndex: _currentIndex,
          inactiveColor: Colors.grey[500],
          splashColor: Theme.of(context).primaryColor,
          iconSize: 22,
          onTap: (index) => onTabTapped(index),
        ),
        body: PageView(
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),  
          children: <Widget>[
            Explore(),
            AreasPage(),
            BlogPage(),
            BookmarkPage(),
            ProfilePage(),
          ],
        ),
      ),
    );

  }
}
