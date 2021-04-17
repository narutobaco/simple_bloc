import 'package:flutter/material.dart';
import 'package:my_app/model/Product.dart';
import 'package:my_app/bloc/product_bloc.dart';
import 'cart_counter.dart';
import '../../../constants.dart';

class ItemCard extends StatefulWidget {
  final Product product;
  @override
  const ItemCard({
    Key key,
    this.product,
  }) : super(key: key);
  _ItemCardState createState() => _ItemCardState(product: this.product);
}

class _ItemCardState extends State<ItemCard> {
  _ItemCardState({@required this.product});
  final Product product;
  @override
  Widget build(BuildContext context) {
    int totalCost = product.quantity * product.price;
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
                  "Total: \$$totalCost",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Center(
                  child: CartCounter(
                    product: this.product,
                    numOfItems: this.product.quantity,
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
                      onPressed: () {
                        bloc.removeToCart(this.product.id, product.quantity);
                        Navigator.popAndPushNamed(context, '/cart');
                      },
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
