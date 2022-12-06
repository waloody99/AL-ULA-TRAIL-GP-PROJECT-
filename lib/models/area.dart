import 'package:cloud_firestore/cloud_firestore.dart';

class AreaModel {
  String? name;
  String? thumbnailUrl;
  String? timestamp;

  AreaModel({
    this.name,
    this.thumbnailUrl,
    this.timestamp
  });


  factory AreaModel.fromFirestore(DocumentSnapshot snapshot){
    Map d = snapshot.data() as Map<dynamic, dynamic>;
    return AreaModel(
      name: d['name'],
      thumbnailUrl: d['thumbnail'],
      timestamp: d['timestamp'],
    );
  }


  Map<String, dynamic> toJson (){
    return {
      'name' : name,
      'thumbnail' : thumbnailUrl,
      'timestamp' : timestamp
    };
  }
}

