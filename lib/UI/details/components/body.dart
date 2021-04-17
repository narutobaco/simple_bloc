import 'package:flutter/material.dart';
import 'package:my_app/UI/cart/components/cart_counter.dart';
import 'package:my_app/bloc/product_bloc.dart';
import 'package:my_app/constants.dart';
import 'package:my_app/model/Product.dart';
import 'package:my_app/bloc/counter_bloc.dart';
import 'add_to_cart.dart';
import 'color_and_size.dart';
import 'description.dart';
import 'product_title_with_image.dart';

class Body extends StatelessWidget {
  final Product product;
  final int number;

  const Body({Key key, this.product, this.number}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // It provide us total height and width
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: size.height,
            child: Stack(
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(top: size.height * 0.3),
                    padding: EdgeInsets.only(
                      top: size.height * 0.12,
                      left: kDefaultPaddin,
                      right: kDefaultPaddin,
                    ),
                    // height: 500,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                    ),
                    child: StreamBuilder(
                        initialData: counterBloc.counter,
                        stream: counterBloc.getStream,
                        builder: (context, snapshot) {
                          return Column(
                            children: <Widget>[
                              ColorAndSize(product: product),
                              SizedBox(height: kDefaultPaddin / 2),
                              Description(product: product),
                              SizedBox(height: kDefaultPaddin / 2),
                              CartCounter(
                                product: this.product,
                              ),
                              SizedBox(height: kDefaultPaddin / 2),
                              AddToCart(
                                product: product,
                                number: 1,
                              )
                            ],
                          );
                        })),
                ProductTitleWithImage(product: product)
              ],
            ),
          )
        ],
      ),
    );
  }
}
