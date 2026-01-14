import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Addtransaction extends StatefulWidget {
  final String uid;
  const Addtransaction({
    required this.uid,
    super.key
  });

  @override
  State<Addtransaction> createState() => _AddtransactionState();
}

class _AddtransactionState extends State<Addtransaction> {

  final amount = TextEditingController();
  final purpose = TextEditingController();
  String date = DateFormat('d MMM, yyyy').format(DateTime.now());

  Future<bool> addTransaction() async {
    final amt = double.tryParse(amount.text.trim());
    if (amt == null) return false;

    try {
      final txRef = FirebaseFirestore.instance.collection('transactions').doc(widget.uid);
      final data = await txRef.collection("transaction").count().get();
      final id = data.count.toString().padLeft(5, '0'); // keep zero-padding

      // ensure we await the write
      await txRef.collection('transaction').doc(id).set({
        "title": purpose.text.trim(),
        "amount": amt,
        "type": "Debit",
        "date": FieldValue.serverTimestamp()
      }); 

      // Atomically update Total on the parent document to avoid race conditions
      await txRef.update({
        "Total": FieldValue.increment(-amt),
      });

      return true;
    } catch (e) {
      debugPrint('addTransaction error: $e');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 277,
      padding: EdgeInsets.only(top: 16, right: 18, left:18, bottom: 16),
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(28)
      ),
      child: Column(
        spacing: 12,
        children: [
          Text("Add Transaction",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 137, 4, 4)
            ),
          ),
          TextField(
            autofocus: true,
            controller: amount,
            keyboardType: TextInputType.number,
            keyboardAppearance: Brightness.dark,
            cursorColor: Colors.black,
            cursorHeight: 25,
            decoration:InputDecoration(
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
          TextField(
            cursorHeight: 25,
            controller: purpose,
            cursorColor: Colors.black,
            keyboardAppearance: Brightness.dark,
            autofocus: false,
            decoration:InputDecoration(
              fillColor: Colors.black,
              focusColor: Colors.black,
              contentPadding: EdgeInsets.only(left: 15, top: 10, bottom: 10),
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
              hintText: "Purpose"
              //hintStyle: 
            ),
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(height: 1,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: (){
                  Navigator.of(context).pop();
                }, 
                
                child: Text("Close",
                  style: TextStyle(
                    color: Colors.red.shade600,
                    fontSize: 20
                  ),
                )
              ),
              TextButton(
                onPressed: () async {
                  final success = await addTransaction();
                  if(context.mounted)
                  {
                    Navigator.of(context).pop(success);
                  }
                }, 
                child: Text("Add",
                  style: TextStyle(
                    color: Colors.green.shade600,
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