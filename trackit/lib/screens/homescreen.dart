import 'package:intl/intl.dart';
import 'package:trackit/screens/add_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trackit/screens/transactions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final uid = FirebaseAuth.instance.currentUser!.uid;

  String formatDate(dynamic stamp){
    
    if (stamp == null) return '—';

    if (stamp is Timestamp) {
      return DateFormat('d MMM, yyyy').format(stamp.toDate());
    }
    if (stamp is DateTime) {
      return DateFormat('d MMM, yyyy').format(stamp);
    }

    if (stamp is int) {
      return DateFormat('d MMM, yyyy').format(DateTime.fromMillisecondsSinceEpoch(stamp));
    }

    try {
      return DateFormat('d MMM, yyyy').format(DateTime.parse(stamp.toString()));
    } catch (e) {
      return stamp.toString();
    }
  }
  
  String amount(num amt){
    return NumberFormat.decimalPattern('en_IN').format(amt);
  }
  

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("transactions").doc(uid).snapshots(),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting)
        {
          return Center(child: CircularProgressIndicator(),);
        }

        if(!snapshot.hasData)
        {
          return Container(
            height: 355,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.all(Radius.circular(13))
            ),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 230,
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.only(bottom: 16,left:2, right: 2),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: [0.24,0.36,0.5,0.75],
                      colors: [
                        const Color.fromARGB(255, 8, 94, 165),
                        const Color.fromARGB(255, 23, 96, 156),
                        const Color.fromARGB(255, 18, 96, 161),
                        Colors.blue.shade700,
                      ]
                    ),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Total Balance",
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      const SizedBox(height: 4,),
                      Text("₹0",
                        style: const TextStyle(
                          fontSize: 36,
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      const Divider(
                        color: Colors.white,
                        thickness: 1,
                        height: 30,
                      ),
                      Text("No deposit made yet",
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w500
                        ),  
                      ),
                      const SizedBox(height: 12,),
                    ],
                  ),
                ),
                Column(
                  children: [
                    AddButton(uid: uid),
                    Container(
                      margin: const EdgeInsets.only(top: 5, bottom: 5),
                      child: const Text("Recent Transactions",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                        )
                      )
                    )
                  ],
                ),
              ],
            ),
          );
        }

        return StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('transactions')
              .doc(uid)
              .collection('transaction')
              .snapshots(),
          builder: (context, asyncSnapshot) {
            final data = snapshot.data!.data()!;
            final balance = amount(data["Total"]!=null?(data['Total']):0);
            final lastDepositDate = data['LastDepDate'] != null ? formatDate(data['LastDepDate']) : '—';
            final lastDeposit = amount(data["Last Deposit"]!=null?(data['Last Deposit']):0);

            if(!asyncSnapshot.hasData || asyncSnapshot.data!.docs.isEmpty) {
              return Container(
                height: 355,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(13))
                ),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 230,
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.only(bottom: 16,left:2, right: 2),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          stops: [0.24,0.36,0.5,0.75],
                          colors: [
                            const Color.fromARGB(255, 8, 94, 165),
                            const Color.fromARGB(255, 23, 96, 156),
                            const Color.fromARGB(255, 18, 96, 161),
                            Colors.blue.shade700,
                          ]
                        ),
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Total Balance",
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                          const SizedBox(height: 4,),
                          Text("₹$balance",
                            style: const TextStyle(
                              fontSize: 36,
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          const Divider(
                            color: Colors.white,
                            thickness: 1,
                            height: 30,
                          ),
                          Text("Last deposit: ₹$lastDeposit",
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w500
                            ),  
                          ),
                          const SizedBox(height: 12,),
                          Text("On $lastDepositDate",
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        AddButton(uid: uid, onTransactionAdded: () { setState(() {}); }),
                        Container(
                          margin: const EdgeInsets.only(top: 5, bottom: 5),
                          child: const Text("Recent Transactions",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                            )
                          )
                        )
                      ],
                    ),
                  ],
                ),
              );
            }

            final docs = asyncSnapshot.data!.docs;
            final itemCount = docs.length > 15 ? 15 : docs.length;

            return CustomScrollView(
                slivers:[
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: PersistentHeader(
                      widget:Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.all(Radius.circular(13))
                        ),
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              height: 230,
                              padding: const EdgeInsets.all(20),
                              margin: const EdgeInsets.only(bottom: 16,left:2, right: 2),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  stops: [0.24,0.36,0.5,0.75],
                                  colors: [
                                    const Color.fromARGB(255, 8, 94, 165),
                                    const Color.fromARGB(255, 23, 96, 156),
                                    const Color.fromARGB(255, 18, 96, 161),
                                    Colors.blue.shade700,
                                  ]
                                ),
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Total Balance",
                                    style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500
                                    ),
                                  ),
                                  const SizedBox(height: 4,),
                                  Text("₹$balance",
                                    style: const TextStyle(
                                      fontSize: 36,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  const Divider(
                                    color: Colors.white,
                                    thickness: 1,
                                    height: 30,
                                  ),
                                  Text("Last deposit: ₹$lastDeposit",
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500
                                    ),  
                                  ),
                                  const SizedBox(height: 12,),
                                  Text("On $lastDepositDate",
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                AddButton(uid: uid, onTransactionAdded: () { setState(() {}); }),
                                Container(
                                  margin: const EdgeInsets.only(top: 5, bottom: 5),
                                  child: const Text("Recent Transactions",
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white
                                    )
                                  )
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      height: 355
                    )
                  ),
                  SliverList.builder(
                    itemCount: itemCount,
                    itemBuilder: (context, index){
                      final transaction = docs[itemCount-index-1].data();
                      return Container(
                        margin: const EdgeInsets.only(right: 3, left: 3, top: 12),
                        child: Transactions(
                          title: transaction['title'] as String,
                          amount: amount(transaction['amount'] as num),
                          date: formatDate(transaction['date']) ,
                          type: transaction['type'] as String,
                        ),
                      );
                    }
                  )
                ]
              );
          }
        );
      }
    );
  }
}
class PersistentHeader extends SliverPersistentHeaderDelegate {
  final Widget widget;
  final double height;

  PersistentHeader({required this.widget, required this.height});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: widget);
  }

  @override
  double get maxExtent => height; // Max height of the container

  @override
  double get minExtent => height; // Min height when pinned

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false; // Set to true if the widget can change
  }
}