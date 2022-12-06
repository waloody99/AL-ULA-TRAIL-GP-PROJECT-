import 'package:alulatrail/blocs/blog_bloc.dart';
import 'package:alulatrail/blocs/area_bloc.dart';
import 'package:alulatrail/models/colors.dart';
import 'package:alulatrail/models/area.dart';
import 'package:alulatrail/pages/area_based_places.dart';
import 'package:alulatrail/utils/empty.dart';
import 'package:alulatrail/utils/loading_cards.dart';
import 'package:alulatrail/utils/next_screen.dart';
import 'package:alulatrail/widgets/custom_cache_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';


class AreasPage extends StatefulWidget {
  AreasPage({Key? key}) : super(key: key);

  @override
  _AreasPageState createState() => _AreasPageState();
}

class _AreasPageState extends State<AreasPage> with AutomaticKeepAliveClientMixin {


  ScrollController? controller;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    controller = new ScrollController()..addListener(_scrollListener);
    super.initState();
    Future.delayed(Duration(milliseconds: 0))
    .then((value){
      context.read<AreaBloc>().getData(mounted);
    });

  }


  @override
  void dispose() {
    controller!.removeListener(_scrollListener);
    super.dispose();
  }




  void _scrollListener() {
    final db = context.read<BlogBloc>();
    
    if (!db.isLoading) {
      if (controller!.position.pixels == controller!.position.maxScrollExtent) {
        context.read<AreaBloc>().setLoading(true);
        context.read<AreaBloc>().getData(mounted);

      }
    }
  }

  
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final sb = context.watch<AreaBloc>();

    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          automaticallyImplyLeading: false,
          title: Text(
            'Areas'
            
          ).tr(),
          elevation: 0,
          actions: <Widget>[
            IconButton(
              icon: Icon(Feather.rotate_cw, size: 22,),
              onPressed: (){
                context.read<AreaBloc>().onReload(mounted);
              },
            )
          ],
        ),

    body: RefreshIndicator(
        child: sb.hasData == false 
        ? ListView(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.35,),
            EmptyPage(icon: Feather.clipboard, message: 'No areas found', message1: ''),
          ],
          )
        
        : ListView.separated(
          padding: EdgeInsets.all(15),
          controller: controller,
          physics: AlwaysScrollableScrollPhysics(),
          itemCount: sb.data.length != 0 ? sb.data.length + 1 : 8,
          separatorBuilder: (BuildContext context, int index) => SizedBox(height: 10,),
          
          //shrinkWrap: true,
          itemBuilder: (_, int index) {

            if (index < sb.data.length) {
              return _ItemList(d: sb.data[index]);
            }
            return Opacity(
                opacity: sb.isLoading ? 1.0 : 0.0,
                child: sb.lastVisible == null
                ? LoadingCard(height: 140)
                
                : Center(
                  child: SizedBox(
                      width: 32.0,
                      height: 32.0,
                      child: new CupertinoActivityIndicator()),
                ),
              
            );
          },
        ),
        onRefresh: () async {
          context.read<AreaBloc>().onRefresh(mounted);
          
        },
      ),
    );
  }
  
  @override
  bool get wantKeepAlive => true;
}


class _ItemList extends StatelessWidget {
  final AreaModel d;
  const _ItemList({Key? key, required this.d}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
          child: Container(
            height: 140,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          
        ),
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: CustomCacheImage(imageUrl: d.thumbnailUrl,)),
            ),

            Align(
              alignment: Alignment.center,
              child: Text(d.name!.toUpperCase(), style: TextStyle(
                fontSize: 22,
                color: Colors.white,
                fontWeight: FontWeight.w600
              ),),
            )

            
          ],
        )
      ),

      onTap: ()=> nextScreen(context, AreaBasedPlaces(
        areaName: d.name,
        color: (ColorList().randomColors..shuffle()).first,
        
        )),
    );
  }
}



