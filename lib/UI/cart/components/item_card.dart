import 'package:flutter/material.dart';
import 'package:my_app/model/Product.dart';
import 'package:my_app/bloc/product_bloc.dart';
import '../../../constants.dart';

class ItemCard extends StatefulWidget {
  final Product product;
  @override
  const ItemCard({
    Key key,
    this.product,
  }) : super(key: key);
  _ItemCardState createState() => _ItemCardState(
      product: this.product,
      numOfItems: this.product.quantity,
      totalCost: this.product.price * this.product.quantity);
}

class _ItemCardState extends State<ItemCard> {
  _ItemCardState(
      {@required this.product,
      @required this.numOfItems,
      @required this.totalCost});
  final Product product;
  int numOfItems;
  int totalCost;
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
                  "Total: \$$totalCost",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      buildOutlineButton(
                        icon: Icons.remove,
                        press: () {
                          if (numOfItems > 1) {
                            setState(() {
                              numOfItems--;
                              totalCost = numOfItems * product.price;
                              bloc.removeToCart(product.id, 1);
                            });
                          }
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: kDefaultPaddin / 2),
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
                                product.quantity +
                                    bloc.getNumberShopItem(product.id)) {
                              setState(() {
                                numOfItems++;
                                totalCost = numOfItems * product.price;
                                bloc.addToCart(product.id, 1);
                              });
                            }
                          }),
                    ],
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
                    onPressed: () {
                      bloc.buyProduct(product.id);
                      Navigator.popAndPushNamed(context, '/cart');
                    },
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
