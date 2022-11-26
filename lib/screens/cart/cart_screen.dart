import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ishop_users/assisted_methods/cart_item_counter.dart';
import 'package:ishop_users/assisted_methods/total_amount.dart';
import 'package:ishop_users/components/appbar_cart_badge.dart';
import 'package:ishop_users/components/global.dart';
import 'package:ishop_users/models/items.dart';
import 'package:ishop_users/screens/cart/cart_item_design_widget.dart';
import 'package:ishop_users/screens/shipment_address/address_screen.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  String? sellerUID;

  CartScreen({
    super.key,
    this.sellerUID,
  });

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<int>? itemQuantityList;
  double totalAmount = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    totalAmount = 0;
    Provider.of<TotalAmount>(context, listen: false)
        .showTotalAmountOfCartItems(0);
    itemQuantityList = cartMethods.separateItemQuantitiesFromUserCartList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithCartBadge(),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const SizedBox(
            height: 10,
          ),
          FloatingActionButton.extended(
            onPressed: () {
              cartMethods.clearCart(context);
              //Navigator.pushReplacement(context,MaterialPageRoute(builder: (c) => const HomePage()));
              //Navigator.pop(context);
            },
            heroTag: "btn1",
            icon: const Icon(
              Icons.clear_all,
            ),
            label: const Text(
              "Clear Cart",
              style: TextStyle(fontSize: 16),
            ),
          ),
          FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (c)=>AddressScreen(
                sellerUID: widget.sellerUID.toString(),
                totalAmount: totalAmount.toDouble(),
              )));
            },
            heroTag: "btn2",
            icon: const Icon(
              Icons.navigate_next,
            ),
            label: const Text(
              "Check Out",
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              child: Consumer2<TotalAmount, CartItemCounter>(
                  builder: (context, amountProvider, cartProvider, c) {
                return Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Center(
                    child: cartProvider.count == 0
                        ? Container()
                        : Text(
                            "Total Price: ${amountProvider.tAmount}",
                            style: const TextStyle(
                              letterSpacing: 2,
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                  ),
                );
              }),
            ),
          ),

          //query
          //model
          //design

          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("items")
                .where("itemID",
                    whereIn: cartMethods.separateItemIDsFromUserCartList())
                .orderBy("publishedDate", descending: true)
                .snapshots(),
            builder: (context, AsyncSnapshot dataSnapshot) {
              if (dataSnapshot.hasData) {
                //display
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      Items model = Items.fromJson(dataSnapshot.data.docs[index]
                          .data() as Map<String, dynamic>);
                      print(model);
                      if (index == 0) {
                        totalAmount = 0;
                        totalAmount = totalAmount +
                            (double.parse(model.price!) *
                                itemQuantityList![index]);
                      } else //==1 or greater than 1
                      {
                        totalAmount = totalAmount +
                            (double.parse(model.price!) *
                                itemQuantityList![index]);
                      }

                      //1                              == 1
                      if (dataSnapshot.data.docs.length - 1 == index) {
                        WidgetsBinding.instance
                            .addPostFrameCallback((timeStamp) {
                          Provider.of<TotalAmount>(context, listen: false)
                              .showTotalAmountOfCartItems(totalAmount);
                        });
                      }

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CartItemDesignWidget(
                          model: model,
                          quantityNumber: itemQuantityList![index],
                        ),
                      );
                    },
                    childCount: dataSnapshot.data.docs.length,
                  ),
                );
              } else {
                return const SliverToBoxAdapter(
                  child: Center(
                    child: Text(
                      "No items exists in cart",
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
