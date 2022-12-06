import 'package:alulatrail/config/config.dart';
import 'package:alulatrail/pages/splash.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'blocs/ads_bloc.dart';
import 'blocs/blog_bloc.dart';
import 'blocs/bookmark_bloc.dart';
import 'blocs/comments_bloc.dart';
import 'blocs/featured_bloc.dart';
import 'blocs/notification_bloc.dart';
import 'blocs/other_places_bloc.dart';
import 'blocs/popular_places_bloc.dart';
import 'blocs/recent_places_bloc.dart';
import 'blocs/recommanded_places_bloc.dart';
import 'blocs/search_bloc.dart';
import 'blocs/sign_in_bloc.dart';
import 'blocs/sp_area_one.dart';
import 'blocs/sp_area_two.dart';
import 'blocs/area_bloc.dart';


final FirebaseAnalytics firebaseAnalytics = FirebaseAnalytics.instance;
final FirebaseAnalyticsObserver firebaseObserver =  FirebaseAnalyticsObserver(analytics: firebaseAnalytics);



class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BlogBloc>( create: (context) => BlogBloc(),),
        ChangeNotifierProvider<SignInBloc>(create: (context) => SignInBloc(),),
        ChangeNotifierProvider<CommentsBloc>(create: (context) => CommentsBloc(),),
        ChangeNotifierProvider<BookmarkBloc>(create: (context) => BookmarkBloc(),),
        ChangeNotifierProvider<PopularPlacesBloc>(create: (context) => PopularPlacesBloc(),),
        ChangeNotifierProvider<RecentPlacesBloc>(create: (context) => RecentPlacesBloc(),),
        ChangeNotifierProvider<RecommandedPlacesBloc>(create: (context) => RecommandedPlacesBloc(),),
        ChangeNotifierProvider<FeaturedBloc>(create: (context) => FeaturedBloc(),),
        ChangeNotifierProvider<SearchBloc>(create: (context) => SearchBloc()),
        ChangeNotifierProvider<NotificationBloc>(create: (context) => NotificationBloc()),
        ChangeNotifierProvider<AreaBloc>(create: (context) => AreaBloc()),
        ChangeNotifierProvider<SpecialAreaOneBloc>(create: (context) => SpecialAreaOneBloc()),
        ChangeNotifierProvider<SpecialAreaTwoBloc>(create: (context) => SpecialAreaTwoBloc()),
        ChangeNotifierProvider<OtherPlacesBloc>(create: (context) => OtherPlacesBloc()),
        ChangeNotifierProvider<AdsBloc>(create: (context) => AdsBloc()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          locale: context.locale,
          supportedLocales: context.supportedLocales,
          localizationsDelegates: context.localizationDelegates,
          navigatorObservers: [firebaseObserver],
          theme: ThemeData(
              primarySwatch: Colors.deepOrange,
              primaryColor: Config.appThemeColor,
              iconTheme: IconThemeData(color: Colors.grey[900]),
              fontFamily: 'Circular',
              scaffoldBackgroundColor: Colors.grey[100],
              appBarTheme: AppBarTheme(
                color: Colors.white,
                elevation: 0,
                iconTheme: IconThemeData(
                  color: Colors.grey[800],
                ),
                titleTextStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Circular',
                    color: Colors.grey[900]
                  )
              ),),
          home: SplashPage()),
    ); 
  }
}