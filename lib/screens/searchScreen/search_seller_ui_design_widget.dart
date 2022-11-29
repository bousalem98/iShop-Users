import 'package:flutter/material.dart';
import 'package:ishop_users/models/sellers.dart';
import 'package:ishop_users/screens/brands/brands_screen.dart';
import 'package:smooth_star_rating_nsafe/smooth_star_rating.dart';

class SearchSellersUIDesignWidget extends StatefulWidget {
  Sellers? model;

  SearchSellersUIDesignWidget({
    super.key,
    this.model,
  });

  @override
  State<SearchSellersUIDesignWidget> createState() =>
      _SearchSellersUIDesignWidgetState();
}

class _SearchSellersUIDesignWidgetState
    extends State<SearchSellersUIDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //send user to a seller's brands screen
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (c) => BrandsScreen(
                      model: widget.model,
                    )));
      },
      child: Card(
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(28.0),
        ),
        elevation: 20,
        shadowColor: Colors.grey,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SizedBox(
            height: 270,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Image.network(
                    widget.model!.photoUrl.toString(),
                    height: 200,
                    width: 300,
                    fit: BoxFit.fill,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  widget.model!.name.toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.purple,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SmoothStarRating(
                  rating: widget.model!.ratings == null
                      ? 0.0
                      : getRatings(widget.model!.ratings),
                  starCount: 5,
                  color: Colors.purpleAccent,
                  borderColor: Colors.purpleAccent,
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  getRatings(Map? ratings) {
    double totalratings = double.parse(ratings!['0']);
    double nbRaters = double.parse(ratings!['1']);
    return totalratings / nbRaters;
  }
}
