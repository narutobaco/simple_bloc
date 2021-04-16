import 'package:flutter/material.dart';
import 'package:my_app/model/Product.dart';
import 'cart_counter.dart';
import '../../../constants.dart';

class ItemCard extends StatelessWidget {
  final Product product;
  const ItemCard({
    Key key,
    this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          flex: 3,
          child: Container(
            padding: EdgeInsets.all(kDefaultPaddin),
            // For  demo we use fixed height  and width
            // Now we dont need them
            // height: 180,
            // width: 160,
            decoration: BoxDecoration(
              color: product.color,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Hero(
              tag: "${product.id}",
              child: Image.asset(
                product.image,
              ),
            ),
          ),
        ),
        Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: kDefaultPaddin / 4),
                  child: Text(
                    // products is out demo list
                    product.title,
                    style: TextStyle(color: kTextLightColor),
                  ),
                ),
                Text(
                  "Total: \$${product.price}",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: kDefaultPaddin / 4),
                  child: Text(
                    // products is out demo list
                    "Remain: ${product.quantity}",
                    style: TextStyle(color: kTextLightColor),
                  ),
                ),
                Center(
                  child: CartCounter(
                    product: this.product,
                  ),
                ),
              ],
            )),
        Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                SizedBox(
                  height: 40,
                  child: FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9),
                      ),
                      color: Colors.white,
                      onPressed: () {},
                      child: Icon(
                        Icons.delete,
                        color: Colors.redAccent,
                      )),
                ),
                SizedBox(
                  height: 40,
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9)),
                    color: product.color,
                    onPressed: () {},
                    child: Text(
                      "Buy".toUpperCase(),
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ],
    );
  }
}
