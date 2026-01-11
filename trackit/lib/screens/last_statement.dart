//import 'package:budgetbuddy/globalvariable.dart';
import 'package:trackit/globalvariable.dart';
import 'package:trackit/screens/typeoftransaction.dart';
import 'package:trackit/screens/transactions.dart';
import 'package:flutter/material.dart';

class LastStatement extends StatefulWidget {
  const LastStatement({super.key});

  @override
  State<LastStatement> createState() => _LastStatementState();
}

class _LastStatementState extends State<LastStatement> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Typeoftransaction(),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.only(top: 4),
            itemCount: transactions.length,
            itemBuilder: (context, index){
              final transaction = transactions[index];
              return Container(
                margin: EdgeInsets.only(right: 3, left: 3, top: 12),
                child: Transactions(title: transaction['title'] as String,
                  amount: transaction['amount'] as double,
                  date: transaction['date'] as String,
                  type: transaction['type'] as String,
                ),
              );
            }
          )
        ),
      ],
    );
  }
}