import 'package:flutter/material.dart';

class Transactions extends StatelessWidget {
  final String title, amount, date, type, category;

  const Transactions({
    required this.title,
    required this.amount,
    required this.date,
    required this.type,
    required this.category,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    final List<String> label = ["Credit","Food", "Grocery","Transport", "Entertainment", "Clothes", "Others"];
    final List<IconData> icons = [Icons.savings_rounded, Icons.restaurant_sharp, Icons.local_grocery_store_sharp, 
    Icons.directions_car_outlined, Icons.theater_comedy_sharp, Icons.checkroom_sharp, Icons.more_horiz];
    final index = label.indexOf(category);
    
    return ListTile(
      horizontalTitleGap: 20,
      dense: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
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
          icons[index],
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