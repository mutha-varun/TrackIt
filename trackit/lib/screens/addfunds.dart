import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Addfunds extends StatefulWidget {
  final String uid;
  const Addfunds({
    required this.uid,
    super.key
  });

  @override
  State<Addfunds> createState() => _AddfundsState();
}

class _AddfundsState extends State<Addfunds> {
  final amount = TextEditingController();
  String date = DateFormat('d MMM, yyyy').format(DateTime.now());
  

  Future<bool> addFund() async {
    final amt = double.tryParse(amount.text.trim());
    if (amt == null) return false;

    try{
      final txRef = FirebaseFirestore.instance.collection('transactions').doc(widget.uid);
      final data =  await txRef.collection("transaction").count().get();
      final id = data.count.toString().padLeft(5,"0");


      await txRef.collection('transaction').doc(id).set({
        "title": "Deposit",
        "amount": amt ,
        "type": "Credit",
        "date": FieldValue.serverTimestamp(),
      });

      await txRef.update({
        "Total" : FieldValue.increment(amt),
        "Last Deposit": num.parse(amount.text.trim()),
        "LastDepDate": FieldValue.serverTimestamp(),
      });

      return true;
    }catch(e)
    {
      debugPrint(e.toString());
      return false;
    }
    
  }

  @override
  void dispose() {
    amount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(28)
      ),
      height: 240,
      width: 400,
      padding: EdgeInsets.only(top: 16, right: 18, left:18, bottom: 14),
      child: Column(
        spacing: 12,
        children: [
          Text("Add Funds",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 58, 155, 61)
            ),
          ),
          SizedBox(height: 3,),
          TextField(
            controller: amount,
            keyboardType: TextInputType.number,
            cursorColor: Colors.black,
            cursorHeight: 25,
            autofocus: true,
            keyboardAppearance: Brightness.dark,
            decoration: InputDecoration(
              fillColor: Colors.black,
              focusColor: Colors.black,
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left:8.0),
                child: Icon(
                  Icons.currency_rupee, 
                  color: Colors.black, 
                  size: 27,
                ),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
              prefixIconConstraints: BoxConstraints(
                maxWidth: 50,
                //minHeight: 0
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20)
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  width: 1.5,
                  color: Colors.black
                )
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  width: 2,
                  color: Colors.black
                )
              ),
            ),
            style: TextStyle(
              color: Colors.black,
              fontSize: 25,
              fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: (){
                  Navigator.of(context).pop();
                }, 
                
                child: Text("Close",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 20
                  ),
                )
              ),
              TextButton(
                onPressed: ()async {
                  final success = await addFund();
                  if(context.mounted){
                    Navigator.of(context).pop(success);
                  }
                }, 
                child: Text("Add",
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 20
                  ),
                )
              ),
              SizedBox(width: 8,)
            ],
          )
        ],
      ),
    );
  }
}