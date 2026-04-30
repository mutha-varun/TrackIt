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
  late DateTime selectedStartDate;
  late DateTime selectedEndDate;
  String formatDate(Timestamp stamp){
    return DateFormat('d MMM, yyyy').format(stamp.toDate());
  }
  
  String amount(num amt){
    return NumberFormat.decimalPattern('en_IN').format(amt);
  }
  
  @override
  void initState() {
    selectedLabel = labels[0];
    selectedEndDate = DateTime.now();
    selectedStartDate = selectedEndDate.subtract(const Duration(days: 30));
    _initializeStartDate();
    super.initState();
  }

  Future<void> _initializeStartDate() async {
    try {
      var docRef = await FirebaseFirestore.instance.collection("transactions").doc(uid).get();

      Timestamp start = docRef.data()!["Created_at"];

      setState(() {
        selectedStartDate = start.toDate();
      });
      
    } catch (e) {
      setState(() {
        selectedStartDate = selectedEndDate.subtract(const Duration(days: 30));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(left: 5),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(10)
          ),
          child: Column(
            children: [
              SizedBox(
                height: 48,
                child: ListView.builder(
                  itemCount: labels.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index){
                    String text = labels[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 3, left: 5),
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: GestureDetector(
                  onTap: () async {
                    final DateTimeRange? picked = await showDateRangePicker(
                      context: context,
                      firstDate: DateTime(2025),
                      lastDate: DateTime.now(),
                      initialDateRange: DateTimeRange(start: selectedStartDate, end: selectedEndDate),
                    );
                    if (picked != null) {
                      setState(() {
                        selectedStartDate = picked.start;
                        selectedEndDate = picked.end;
                      });
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 64, 83, 93),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.calendar_today, color: Colors.white),
                        const SizedBox(width: 8),
                        Text(
                          '${DateFormat('d MMM').format(selectedStartDate)} - ${DateFormat('d MMM').format(selectedEndDate)}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        
        StreamBuilder(
          stream: FirebaseFirestore.instance.collection("transactions").doc(uid).collection("transaction").snapshots(),
          builder: (context, asyncSnapshot) {
            if(!asyncSnapshot.hasData)
            {
              return const Expanded(
                child: Center(
                  child: Text("No transactions"),
                ),
              );
            }
            final docs = asyncSnapshot.data!.docs;
            
            
            final filteredDocs = docs.where((doc) {
              final category = doc['category'] as String;
              final date = (doc['date'] as Timestamp).toDate();
              final categoryMatch = selectedLabel == "All" || category == selectedLabel;
              final dateMatch = date.isAfter(selectedStartDate) && date.isBefore(selectedEndDate.add(const Duration(days: 1)));
              return categoryMatch && dateMatch;
            }).toList();

            if(filteredDocs.isEmpty){
              return const Expanded(
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