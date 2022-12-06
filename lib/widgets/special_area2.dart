import 'package:alulatrail/blocs/sp_area_two.dart';
import 'package:alulatrail/config/config.dart';
import 'package:alulatrail/models/colors.dart';
import 'package:alulatrail/pages/area_based_places.dart';
import 'package:alulatrail/utils/list_card.dart';
import 'package:alulatrail/utils/next_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class SpecialAreaTwo extends StatelessWidget {
  SpecialAreaTwo({Key? key}) : super(key: key);

  


  
  @override
  Widget build(BuildContext context) {
    final spb = context.watch<SpecialAreaTwoBloc>();
    
    

    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 15, top: 20, right: 15,),
          child: Row(children: <Widget>[
            Text('special area-2 places', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.grey[800], wordSpacing: 1, letterSpacing: -0.6),).tr(),
            Spacer(),
            IconButton(icon: Icon(Icons.arrow_forward),
              onPressed: () => nextScreen(
                    context,
                    AreaBasedPlaces(
                      areaName: Config().specialArea2,
                      color: (ColorList().randomColors..shuffle()).first,
                    )),            
            )
          ],),
        ),
        

        Container(
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            padding: EdgeInsets.only(left: 10, right: 10),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: NeverScrollableScrollPhysics(),
            itemCount: spb.data.isEmpty ? 4 : spb.data.length,
            itemBuilder: (BuildContext context, int index) {
              if(spb.data.isEmpty) return Container();
              return ListCard1(d: spb.data[index], tag: 'sp2$index',);
           },
          ),
        )
        
        
      ],
    );
  }
}



