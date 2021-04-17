import 'package:flutter/material.dart';
import 'package:my_app/bloc/counter_bloc.dart';

import '../../../constants.dart';
import 'package:my_app/model/Product.dart';

class CartCounter extends StatefulWidget {
  @override
  const CartCounter({
    Key key,
    @required this.product,
  }) : super(key: key);
  final Product product;
  _CartCounterState createState() => _CartCounterState(product: this.product);
}

class _CartCounterState extends State<CartCounter> {
  _CartCounterState({@required this.product});
  Product product;
  int numOfItems = 1;
  @override
  Widget build(BuildContext context) {
    if (product.quantity <= 0) {
      counterBloc.changeCounter(0);
      return Text("This product is out of stock");
    } else {
      counterBloc.changeCounter(numOfItems);
      return Row(
        children: <Widget>[
          buildOutlineButton(
            icon: Icons.remove,
            press: () {
              if (numOfItems > 1) {
                setState(() {
                  numOfItems--;
                  counterBloc.changeCounter(numOfItems);
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
                if (numOfItems < product.quantity) {
                  setState(() {
                    numOfItems++;
                    counterBloc.changeCounter(numOfItems);
                  });
                }
              }),
        ],
      );
    }
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
