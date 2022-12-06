import 'package:alulatrail/models/place.dart';
import 'package:alulatrail/pages/comments.dart';
import 'package:alulatrail/pages/guide.dart';
import 'package:alulatrail/utils/next_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class TodoWidget extends StatelessWidget {
  final Place? placeData;
  const TodoWidget({Key? key, required this.placeData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Things To Do',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                )).tr(),
        Container(
          margin: EdgeInsets.only(top: 5, bottom: 5),
          height: 3,
          width: 50,
          
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(40)),
        ),
        Container(
          padding: EdgeInsets.only(top: 10, bottom: 10),
          child: GridView.count(
            padding: EdgeInsets.all(0),
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            crossAxisCount: 2,
            childAspectRatio: 1.4,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              InkWell(
                child: Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color: Colors.orangeAccent[400]!,
                                      offset: Offset(5, 5),
                                      blurRadius: 2)
                                ]),
                            child: Icon(
                              LineIcons.handPointingLeft,
                              size: 30,
                            ),
                          ),
                          
                          Text(
                              'Pocket guide',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15),
                            ).tr(),
                          
                        ])),
                onTap: () => nextScreen(context, GuidePage(d: placeData)),
              ),

              InkWell(
                child: Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color: Colors.orangeAccent[400]!,
                                      offset: Offset(5, 5),
                                      blurRadius: 2)
                                ]),
                            child: Icon(
                              LineIcons.comments,
                              size: 30,
                            ),
                          ),
                          Text(
                            'User reviews',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 15),
                          ).tr(),
                        ])),
                onTap: () => nextScreen(context, CommentsPage(collectionName: 'places', timestamp: placeData!.timestamp,)),
              ),
            ],
          ),
        )
      ],
    );
  }
}
