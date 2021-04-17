import 'package:flutter/material.dart';
import 'package:my_app/bloc/product_bloc.dart';
import '../../../constants.dart';
import 'package:my_app/model/Product.dart';

class CartCounter extends StatefulWidget {
  @override
  const CartCounter(
      {Key key, @required this.product, @required this.numOfItems})
      : super(key: key);
  final Product product;
  final int numOfItems;
  _CartCounterState createState() =>
      _CartCounterState(product: this.product, numOfItems: this.numOfItems);
}

class _CartCounterState extends State<CartCounter> {
  _CartCounterState({@required this.product, @required this.numOfItems});
  Product product;
  int numOfItems;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        buildOutlineButton(
          icon: Icons.remove,
          press: () {
            if (numOfItems > 1) {
              setState(() {
                numOfItems--;
                bloc.removeToCart(product.id, 1);
              });
            }
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin / 2),
          child: Text(
            // if our item is less  then 10 then  it shows 01 02 like that
            numOfItems.toString().padLeft(2, "0"),
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        buildOutlineButton(
            icon: Icons.add,
            press: () {
              if (numOfItems <
                  product.quantity + bloc.getNumberShopItem(product.id)) {
                setState(() {
                  numOfItems++;
                  bloc.addToCart(product.id, 1);
                });
              }
            }),
      ],
    );
  }

  SizedBox buildOutlineButton({IconData icon, Function press}) {
    return SizedBox(
      width: 40,
      height: 32,
      child: OutlineButton(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(13),
        ),
        onPressed: press,
        child: Icon(icon),
      ),
    );
  }
}
