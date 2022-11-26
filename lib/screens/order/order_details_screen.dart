import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ishop_users/components/global.dart';
import 'package:ishop_users/models/address.dart';
import 'package:ishop_users/screens/order/address_design_widget.dart';
import 'package:ishop_users/screens/order/status_banner_widget.dart';
import 'package:intl/intl.dart';

class OrderDetailsScreen extends StatefulWidget {
  String? orderID;

  OrderDetailsScreen({
    super.key,
    this.orderID,
  });

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  String orderStatus = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: FutureBuilder(
            future: FirebaseFirestore.instance
                .collection("users")
                .doc(sharedPreferences!.getString("uid"))
                .collection("orders")
                .doc(widget.orderID)
                .get(),
            builder: (c, AsyncSnapshot dataSnapshot) {
              Map? orderDataMap;
              if (dataSnapshot.hasData) {
                orderDataMap = dataSnapshot.data.data() as Map<String, dynamic>;
                orderStatus = orderDataMap["status"].toString();
    
                return Column(
                  children: [
                    StatusBanner(
                      status: orderDataMap["isSuccess"],
                      orderStatus: orderStatus,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "€ ${orderDataMap["totalAmount"]}",
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Order ID = ${orderDataMap["orderId"]}",
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Order at = ${DateFormat("dd MMMM, yyyy - hh:mm aa").format(
                                  DateTime.fromMillisecondsSinceEpoch(
                                      int.parse(orderDataMap["orderTime"])))}",
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    const Divider(
                      thickness: 1,
                      color: Colors.purpleAccent,
                    ),
                    orderStatus == "ended"
                        ? Image.asset("assets/images/delivered.jpg")
                        : Image.asset("assets/images/state.png"),
                    const Divider(
                      thickness: 1,
                      color: Colors.purpleAccent,
                    ),
                    FutureBuilder(
                      future: FirebaseFirestore.instance
                          .collection("users")
                          .doc(sharedPreferences!.getString("uid"))
                          .collection("userAddress")
                          .doc(orderDataMap["addressID"])
                          .get(),
                      builder: (c, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          return AddressDesign(
                            model: Address.fromJson(
                                snapshot.data.data() as Map<String, dynamic>),
                            orderStatus: orderStatus,
                            orderId: widget.orderID,
                            sellerId: orderDataMap!["sellerUID"],
                            orderByUser: orderDataMap["orderBy"],
                          );
                        } else {
                          return const Center(
                            child: Text(
                              "No data exists.",
                            ),
                          );
                        }
                      },
                    ),
                  ],
                );
              } else {
                return const Center(
                  child: Text(
                    "No data exists.",
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
