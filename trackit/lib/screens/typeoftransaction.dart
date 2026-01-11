import 'package:flutter/material.dart';

class Typeoftransaction extends StatefulWidget {
  const Typeoftransaction({super.key});

  @override
  State<Typeoftransaction> createState() => _Typeoftransaction();
}

class _Typeoftransaction extends State<Typeoftransaction> {

  final List<String> labels = const ["All", "Food", "Transport", "Entertainment", "Shopping"];
  late String selectedLabel;

  @override
  void initState() {
    super.initState();
    selectedLabel = labels[0];
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: EdgeInsets.only(left: 10),
      color: Colors.black,
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
    );
  }
}