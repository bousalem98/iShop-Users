import 'package:flutter/material.dart';
import 'package:ishop_users/models/items.dart';

import 'items_details_screen.dart';

class ItemsUiDesignWidget extends StatefulWidget {
  Items? model;

  ItemsUiDesignWidget({super.key, 
    this.model,
  });

  @override
  State<ItemsUiDesignWidget> createState() => _ItemsUiDesignWidgetState();
}

class _ItemsUiDesignWidgetState extends State<ItemsUiDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (c) => ItemsDetailsScreen(
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
          padding: const EdgeInsets.all(12.0),
          child: SizedBox(
            height: 200,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Image.network(
                    widget.model!.thumbnailUrl.toString(),
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  height: 1,
                ),
                Text(
                  widget.model!.itemTitle.toString(),
                  style: const TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    letterSpacing: 3,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
