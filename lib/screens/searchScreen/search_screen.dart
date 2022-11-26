import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ishop_users/models/sellers.dart';
import 'package:ishop_users/screens/searchScreen/search_seller_ui_design_widget.dart';
import 'package:string_extensions/string_extensions.dart';

extension CapExtension on String {
  String get inCaps => '${this[0].toUpperCase()}${substring(1)}';
  String get allInCaps => toUpperCase();
  String get capitalizeFirstofEach =>
      split(" ").map((str) => str.capitalize).join(" ");
}

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String sellerNameText = "";
  Future<QuerySnapshot>? storesDocumentsList;

  initializeSearchingStores(String textEnteredbyUser) {
    storesDocumentsList = FirebaseFirestore.instance
        .collection("sellers")
        .where("fullname",
            isGreaterThanOrEqualTo: textEnteredbyUser.capitalizeFirstofEach)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Colors.blueAccent,
              Colors.purpleAccent,
            ],
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          )),
        ),
        automaticallyImplyLeading: true,
        title: TextField(
          textInputAction: TextInputAction.search,
          onChanged: (textEntered) {
            setState(() {
              sellerNameText = textEntered;
            });

            initializeSearchingStores(sellerNameText);
          },
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Search Seller here...",
            hintStyle: const TextStyle(color: Colors.white54),
            suffixIcon: IconButton(
              onPressed: () {
                initializeSearchingStores(sellerNameText);
              },
              icon: const Icon(Icons.search),
              color: Colors.white,
            ),
          ),
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: FutureBuilder(
        future: storesDocumentsList,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                Sellers model = Sellers.fromJson(
                    snapshot.data.docs[index].data() as Map<String, dynamic>);

                return SearchSellersUIDesignWidget(
                  model: model,
                );
              },
            );
          } else {
            return const Center(
              child: Text("No record found."),
            );
          }
        },
      ),
    );
  }
}
