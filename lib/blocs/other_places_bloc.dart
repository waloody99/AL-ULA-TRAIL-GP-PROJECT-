import 'package:alulatrail/models/place.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class OtherPlacesBloc extends ChangeNotifier{
  
  List<Place> _data = [];
  List<Place> get data => _data;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
 

  Future getData(String? areaName, String? timestamp) async {
    _data.clear();
    QuerySnapshot rawData;
      rawData = await firestore
          .collection('places')
          .where('area', isEqualTo: areaName)
          .where('timestamp', isNotEqualTo: timestamp)
          .orderBy('timestamp', descending: true)
          .limit(6)
          .get();
      
      List<DocumentSnapshot> _snap = [];
      _snap.addAll(rawData.docs);
      _data = _snap.map((e) => Place.fromFirestore(e)).toList();
      notifyListeners();
    
    
  }

  onRefresh(mounted, String areaname, String timestamp) {
    _data.clear();
    getData(areaname, timestamp);
    notifyListeners();
  }

}