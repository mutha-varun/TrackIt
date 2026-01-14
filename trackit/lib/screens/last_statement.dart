//import 'package:budgetbuddy/globalvariable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trackit/screens/typeoftransaction.dart';
import 'package:trackit/screens/transactions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LastStatement extends StatefulWidget {
  const LastStatement({super.key});

  @override
  State<LastStatement> createState() => _LastStatementState();
}

class _LastStatementState extends State<LastStatement> {

  final String uid = FirebaseAuth.instance.currentUser!.uid;
  String formatDate(Timestamp stamp){
    return DateFormat('d MMM, yyyy').format(stamp.toDate());
  }
  
  String amount(num amt){
    return NumberFormat.decimalPattern('en_IN').format(amt);
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Typeoftransaction(),
        StreamBuilder(
          stream: FirebaseFirestore.instance.collection("transactions").doc(uid).collection("transaction").snapshots(),
          builder: (context, asyncSnapshot) {
            if(!asyncSnapshot.hasData)
            {
              return Center(
                child: Text("No transactions"),
              );
            }
            return Flexible(
              child: ListView.builder(
                padding: EdgeInsets.only(top: 4),
                itemCount: asyncSnapshot.hasData?asyncSnapshot.data!.docs.length:0 ,
                itemBuilder: (context, index){
                  final transaction = asyncSnapshot.data!.docs[asyncSnapshot.data!.docs.length-index-1].data();
                  return Container(
                    margin: EdgeInsets.only(right: 3, left: 3, top: 12),
                    child: Transactions(title: transaction['title'] as String,
                      amount: amount(transaction['amount'] as num),
                      date: formatDate(transaction['date']),
                      type: transaction['type'] as String,
                    ),
                  );
                }
              ),
            );
          }
        ),
      ],
    );
  }
}