import 'package:flutter/material.dart';
import 'package:my_app/bloc/product_bloc.dart';
import 'package:my_app/constants.dart';
import 'package:my_app/model/Product.dart';

import 'item_card.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      initialData: bloc.allItem,
      stream: bloc.getStream,
      builder: (context, snapshot) {
        return snapshot.data["cart items"].length > 0
            ? cartProductListBuilder(snapshot)
            : Center(child: Text("Cart is empty"));
      },
    );
  }
}

Widget cartProductListBuilder(snapshot) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
          child: GridView.builder(
              itemCount: snapshot.data["cart items"].length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                mainAxisSpacing: kDefaultPaddin,
                crossAxisSpacing: kDefaultPaddin,
                childAspectRatio: 2,
              ),
              itemBuilder: (context, index) =>
                  ItemCard(product: snapshot.data["cart items"][index])),
        ),
      ),
    ],
  );
}
