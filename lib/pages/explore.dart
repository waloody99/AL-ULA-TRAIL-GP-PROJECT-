import 'package:alulatrail/blocs/featured_bloc.dart';
import 'package:alulatrail/blocs/popular_places_bloc.dart';
import 'package:alulatrail/blocs/recent_places_bloc.dart';
import 'package:alulatrail/blocs/recommanded_places_bloc.dart';
import 'package:alulatrail/blocs/sign_in_bloc.dart';
import 'package:alulatrail/blocs/sp_area_one.dart';
import 'package:alulatrail/blocs/sp_area_two.dart';
import 'package:alulatrail/config/config.dart';
import 'package:alulatrail/pages/profile.dart';
import 'package:alulatrail/pages/search.dart';
import 'package:alulatrail/utils/next_screen.dart';
import 'package:alulatrail/widgets/featured_places.dart';
import 'package:alulatrail/widgets/popular_places.dart';
import 'package:alulatrail/widgets/recent_places.dart';
import 'package:alulatrail/widgets/recommended_places.dart';
import 'package:alulatrail/widgets/special_area1.dart';
import 'package:alulatrail/widgets/special_area2.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

class Explore extends StatefulWidget {
  Explore({Key? key}) : super(key: key);

  _ExploreArea createState() => _ExploreArea();
}

class _ExploreArea extends State<Explore> with AutomaticKeepAliveClientMixin {

  @override
  void initState() {
    super.initState();
    reloadData();
    
  }




  Future reloadData () async {
    Future.delayed(Duration(milliseconds: 0)).then((_) async{

      await context.read<FeaturedBloc>().getData()
      .then((value) => context.read<PopularPlacesBloc>().getData())
      .then((value) => context.read<RecentPlacesBloc>().getData())
      .then((value) => context.read<SpecialAreaOneBloc>().getData())
      .then((value) => context.read<SpecialAreaTwoBloc>().getData())
      .then((value) => context.read<RecommandedPlacesBloc>().getData());
      
      });
  }


  Future _onRefresh () async {
    context.read<FeaturedBloc>().onRefresh();
    context.read<PopularPlacesBloc>().onRefresh(mounted);
    context.read<RecentPlacesBloc>().onRefresh(mounted);
    context.read<SpecialAreaOneBloc>().onRefresh(mounted);
    context.read<SpecialAreaTwoBloc>().onRefresh(mounted);
    context.read<RecommandedPlacesBloc>().onRefresh(mounted);
  }




  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        backgroundColor: Colors.white,
          body: SafeArea(
              child: RefreshIndicator(
              onRefresh: () async => _onRefresh(),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Header(),
                    Featured(),
                    PopularPlaces(),
                    RecentPlaces(),
                    SpecialAreaOne(),
                    SpecialAreaTwo(),
                    RecommendedPlaces()
                  ],
                ),
              ),
            ),
          )
    );
  }

  @override
  bool get wantKeepAlive => true;
}




class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SignInBloc sb = Provider.of<SignInBloc>(context);
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 30, bottom: 20),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      Config().appName,
                      style: TextStyle(
                          fontSize: 22,
                          fontFamily: 'Circular',
                          fontWeight: FontWeight.w900,
                          color: Colors.grey[800]),
                    ),
                    Text(
                      'Explore the history of Al-Ula',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[600]),
                    ).tr()
                  ],
                ),
                Spacer(),
                InkWell(
                  child: sb.imageUrl == null || sb.isSignedIn == false
                      ? Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.person, size: 28),
                        )
                      : Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: CachedNetworkImageProvider(sb.imageUrl!),
                                  fit: BoxFit.cover)),
                        ),
                  onTap: () {
                    nextScreen(context, ProfilePage());
                  },
                )
              ],
            ),
          ),
          SizedBox(
            height: 25,
          ),
          InkWell(
            child: Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 5, right: 5),
              padding: EdgeInsets.only(left: 15, right: 15),
              height: 45,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                border: Border.all(color: Colors.grey[300]!, width: 0.5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Feather.search,
                      color: Colors.grey[600],
                      size: 20,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'search places',
                      style: TextStyle(fontSize: 15, color: Colors.blueGrey[700], fontWeight: FontWeight.w500),
                    ).tr(),
                  ],
                ),
              ),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SearchPage()));
            },
          )
        ],
      ),
    );
  }
}

