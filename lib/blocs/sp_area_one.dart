import 'package:alulatrail/config/config.dart';
import 'package:alulatrail/models/place.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SpecialAreaOneBloc extends ChangeNotifier{
  
  List<Place> _data = [];
  List<Place> get data => _data;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
 

  Future getData() async {
    QuerySnapshot rawData;
      rawData = await firestore
          .collection('places')
          .where('area', isEqualTo: Config().specialArea1)
          .orderBy('loves', descending: true)
          .limit(4)
          .get();
      
      List<DocumentSnapshot> _snap = [];
      _snap.addAll(rawData.docs);
      _data = _snap.map((e) => Place.fromFirestore(e)).toList();
      notifyListeners();
    
    
  }

  onRefresh(mounted) {
    _data.clear();
    getData();
    notifyListeners();
  }

  





}