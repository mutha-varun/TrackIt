// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:trackit/screens/transactions.dart';

// class HomeRecent extends StatefulWidget {
//   const HomeRecent({super.key});

//   @override
//   State<HomeRecent> createState() => _HomeRecentState();
// }

// class _HomeRecentState extends State<HomeRecent> {
  
//   final String uid = FirebaseAuth.instance.currentUser!.uid;

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//       stream: FirebaseFirestore.instance.collection("transactions").doc(uid).collection("transaction").snapshots(),
//       builder: (context, snapshot){
//         return SliverList.builder(
//           itemCount: snapshot.data!.docs.length,
//           itemBuilder: (context, index){
//             final transaction = snapshot.data!.docs[index].data();
//             return Container(
//               margin: const EdgeInsets.only(right: 3, left: 3, top: 12),
//               child: Transactions(title: transaction['title'] as String,
//                 amount: transaction['amount'] as double,
//                 date: transaction['date'] as String,
//                 type: transaction['type'] as String,
//               ),
//             );
//           }
//         );
//       }
//     );
//   }
// }