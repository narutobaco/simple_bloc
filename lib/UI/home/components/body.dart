import 'package:flutter/material.dart';
import 'package:my_app/constants.dart';
import 'package:my_app/UI/details/details_screen.dart';
import 'package:my_app/bloc/product_bloc.dart';

import 'item_card.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        initialData: bloc.allItem,
        stream: bloc.getStream,
        builder: (context, snapshot) {
          return snapshot.data["shop items"].length > 0
              ? shopProductListBuilder(snapshot)
              : Center(child: Text("All items in shop have been taken"));
        });
  }
}

Widget shopProductListBuilder(snapshot) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
          child: GridView.builder(
              itemCount: snapshot.data["shop items"].length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: kDefaultPaddin,
                crossAxisSpacing: kDefaultPaddin,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (context, index) => ItemCard(
                    product: snapshot.data["shop items"][index],
                    press: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsScreen(
                            product: snapshot.data["shop items"][index],
                          ),
                        )),
                  )),
        ),
      ),
    ],
  );
}
