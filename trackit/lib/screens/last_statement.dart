import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  final List<String> labels = const ["All", "Credit","Food", "Grocery","Transport", "Entertainment", "Clothes", "Others"];
  late String selectedLabel;
  String formatDate(Timestamp stamp){
    return DateFormat('d MMM, yyyy').format(stamp.toDate());
  }
  
  String amount(num amt){
    return NumberFormat.decimalPattern('en_IN').format(amt);
  }
  
  @override
  void initState() {
    selectedLabel = labels[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 48,
          child: ListView.builder(
            itemCount: labels.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index){
              String text = labels[index];
              return Padding(
                padding: const EdgeInsets.only(right: 3, left: 7),
                child: GestureDetector(
                  onTap: (){
                    setState(() {
                      selectedLabel = text;
                    });
                  },
                  child: Chip(
                    color: WidgetStatePropertyAll(
                      text==selectedLabel?Colors.white
                      :const Color.fromARGB(255, 64, 83, 93)
                    ),
                    padding: EdgeInsets.only(top:5, bottom:5, left:9, right:9),
                    side: BorderSide.none,
                    label: Text(text,
                      style: TextStyle(
                        fontSize: 20,
                        color: text==selectedLabel?Colors.black:Colors.white,
                        fontWeight: FontWeight.bold
                      )
                    ), 
                  ),
                ),
              );
            }
          ),
        ),
        StreamBuilder(
          stream: FirebaseFirestore.instance.collection("transactions").doc(uid).collection("transaction").snapshots(),
          builder: (context, asyncSnapshot) {
            if(!asyncSnapshot.hasData)
            {
              return Expanded(
                child: Center(
                  child: Text("No transactions"),
                ),
              );
            }
            final docs = asyncSnapshot.data!.docs;
            
            
            final filteredDocs = selectedLabel == "All" ? 
            docs : docs.where((doc) => doc['category'] == selectedLabel).toList();

            if(filteredDocs.isEmpty){
              return Expanded(
                child: Center(
                  child: Text("No transactions",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 28,
                      color: Colors.white
                    ),
                  ),
                ),
              );
            }

            return Flexible(
              child: ListView.builder(
                padding: EdgeInsets.only(top: 4),
                itemCount: filteredDocs.length,
                itemBuilder: (context, index){
                  final transaction = filteredDocs[filteredDocs.length-index-1].data();
                  return Container(
                    margin: EdgeInsets.only(right: 3, left: 3, top: 12),
                    child: Transactions(title: transaction['title'] as String,
                      amount: amount(transaction['amount'] as num),
                      date: formatDate(transaction['date']),
                      type: transaction['type'] as String,
                      category: transaction['category'] as String,
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