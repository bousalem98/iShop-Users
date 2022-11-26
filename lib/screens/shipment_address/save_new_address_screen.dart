import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ishop_users/components/global.dart';
import 'package:ishop_users/components/snackbar.dart';
import 'package:ishop_users/screens/shipment_address/text_field_address_widget.dart';

class SaveNewAddressScreen extends StatefulWidget {
  String? sellerUID;
  double? totalAmount;

  SaveNewAddressScreen({
    super.key,
    this.sellerUID,
    this.totalAmount,
  });

  @override
  State<SaveNewAddressScreen> createState() => _SaveNewAddressScreenState();
}

class _SaveNewAddressScreenState extends State<SaveNewAddressScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController streetNumber = TextEditingController();
  TextEditingController flatHouseNumber = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController stateCountry = TextEditingController();
  String completeAddress = "";
  final formKey = GlobalKey<FormState>();

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
        title: const Text(
          "iShop",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            completeAddress =
                "${streetNumber.text.trim()}, ${flatHouseNumber.text.trim()}, ${city.text.trim()}, ${stateCountry.text.trim()}.";

            FirebaseFirestore.instance
                .collection("users")
                .doc(sharedPreferences!.getString("uid"))
                .collection("userAddress")
                .doc(DateTime.now().millisecondsSinceEpoch.toString())
                .set({
              "name": name.text.trim(),
              "phoneNumber": phoneNumber.text.trim(),
              "streetNumber": streetNumber.text.trim(),
              "flatHouseNumber": flatHouseNumber.text.trim(),
              "city": city.text.trim(),
              "stateCountry": stateCountry.text.trim(),
              "completeAddress": completeAddress,
            }).then((value) {
              showSnackBar(context, "New Shipment Address has been saved.");
              formKey.currentState!.reset();
            });
          }
        },
        label: const Text("Save Now"),
        icon: const Icon(
          Icons.save,
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(18.0),
              child: Text(
                "Save New Address:",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Form(
              key: formKey,
              child: Column(
                children: [
                  TextFieldAddressWidget(
                    hint: "Name",
                    controller: name,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFieldAddressWidget(
                    hint: "Phone Number",
                    controller: phoneNumber,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFieldAddressWidget(
                    hint: "Street Number",
                    controller: streetNumber,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFieldAddressWidget(
                    hint: "Flat / House Number",
                    controller: flatHouseNumber,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFieldAddressWidget(
                    hint: "City",
                    controller: city,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFieldAddressWidget(
                    hint: "State / Country",
                    controller: stateCountry,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
