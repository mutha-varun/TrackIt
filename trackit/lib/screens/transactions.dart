//import 'package:budgetbuddy/globalvariable.dart';
import 'package:flutter/material.dart';

class Transactions extends StatelessWidget {
  final String title, amount, date, type;

  const Transactions({
    required this.title,
    required this.amount,
    required this.date,
    required this.type,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15)
      ),
      subtitleTextStyle: TextStyle(
        color: Colors.white70,
        fontSize: 16,
      ),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w400
      ),
      leadingAndTrailingTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: (type.compareTo('Debit') == 0)?Colors.red:Colors.green 
      ),
      tileColor: Colors.black,
      leading: CircleAvatar(
        radius: 27,
        backgroundColor: Colors.blueGrey,
        child: Icon(
          Icons.shopping_cart,
          color: Colors.white,
          size: 32,
        ),
      ),
      title: Text(title),
      subtitle: Text(date),
      trailing: Text('₹$amount'),
    );
  }
}