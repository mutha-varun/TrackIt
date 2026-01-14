// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class Changer extends StreamProvider{
//   late final num balance;
  
//   void update(DocumentReference<Map<String, dynamic>> doc, String type, num amt) async{
//     final dataBalance = await doc.get();
//     if(type == "Debit")
//     {
//       balance = (dataBalance.data()!["Total"] as num) - amt;
//     }
//     else{
//       balance = (dataBalance.data()!["Total"] as num) + amt;
//     }
//     doc.update({
//       "Total" : balance
//     });

//     notifyListeners();
//   }
// }