import 'package:trackit/screens/addfunds.dart';
import 'package:trackit/screens/addtransaction.dart';
import 'package:flutter/material.dart';

class AddButton extends StatefulWidget {
  
  final String uid;
  final VoidCallback? onTransactionAdded;
  const AddButton ({
    required this.uid,
    this.onTransactionAdded,
    super.key
  });

  @override
  State<AddButton> createState() => _AddButtonState();
}

class _AddButtonState extends State<AddButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 12,
      children: [
        SizedBox(
          height: 60,
          width: 155,
          child: OutlinedButton(
            style:ButtonStyle(
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)
                )
              ),
              side: WidgetStatePropertyAll(
                BorderSide(
                  color: Colors.green.shade800, width: 1.5
                )
              ),
              backgroundColor: WidgetStatePropertyAll(Colors.green.shade400)
            ),
            onPressed: ()async {
              final added = await showDialog<bool>(
                context: context, 
                builder: (BuildContext context){
                  return Dialog(
                    child: Addfunds(uid: widget.uid),
                  );
                }
              );
              if(added == true){
                widget.onTransactionAdded?.call();
                
              }
            
            }, 
            child: Container(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Icon(
                    Icons.add, 
                    color: Colors.white,
                    size: 25,
                    weight: 100,
                  ),
                  Text("Add funds",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500
                    ),
                  )
                ],
              ),
            ),   
          ),
        ),
        SizedBox(
          width: 198,
          height: 60,
          child: OutlinedButton(
            style: ButtonStyle(
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)
                )
              ),
              side: WidgetStatePropertyAll(
                BorderSide(
                  color: Colors.red.shade800, width: 1.5
                )
              ),
              backgroundColor: WidgetStatePropertyAll(Colors.red)
            ),
            onPressed: () async {
              final added = await showDialog<bool>(
                context: context,
                builder: (BuildContext context) {
                  return Dialog(
                    child: Addtransaction(uid: widget.uid),
                  );
                },
              );

              if (added == true) {
                widget.onTransactionAdded?.call();
                //setState(() {}); // local rebuild as well
              }
            }, 
            child: Row(
              children: [
                Icon(
                  Icons.add, 
                  color: Colors.white,
                  size: 25,
                ),
                Text("Add transaction",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500
                  ),
                )
              ],
            )
          ),
        ),
      ],
    );
  }
}