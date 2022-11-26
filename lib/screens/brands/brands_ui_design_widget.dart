import 'package:flutter/material.dart';
import 'package:ishop_users/models/brands.dart';
import 'package:ishop_users/screens/items/items_screen.dart';

class BrandsUiDesignWidget extends StatefulWidget {
  Brands? model;

  BrandsUiDesignWidget({
    this.model,
  });

  @override
  State<BrandsUiDesignWidget> createState() => _BrandsUiDesignWidgetState();
}

class _BrandsUiDesignWidgetState extends State<BrandsUiDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (c) => ItemsScreen(
                        model: widget.model,
                      )));
        },
        child: Card(
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(28.0),
          ),
          elevation: 10,
          shadowColor: Colors.black,
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: SizedBox(
              height: 180,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Image.network(
                        widget.model!.thumbnailUrl.toString(),
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                      height: 1,
                    ),
                    Text(
                      widget.model!.brandTitle.toString(),
                      style: const TextStyle(
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        letterSpacing: 3,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
