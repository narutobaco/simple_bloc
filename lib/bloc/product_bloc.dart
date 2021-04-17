import 'dart:async';
import 'package:my_app/model/Product.dart';

class ProductBloc {
  final productStreamController = StreamController.broadcast();
  Stream get getStream => productStreamController.stream;

  final Map allItem = {'shop items': products, 'cart items': []};
  void addToCart(productId, numb) {
    print("add to cart : $productId");
    Product temp =
        allItem['shop items'].firstWhere((item) => item.id == productId);
    Product shopProduct = Product(
        id: temp.id,
        image: temp.image,
        title: temp.title,
        price: temp.price,
        description: temp.description,
        size: temp.size,
        color: temp.color,
        quantity: temp.quantity - numb);
    allItem['shop items'].removeWhere((item) => item.id == productId);
    allItem['shop items'].add(shopProduct);

    var contain = allItem['cart items'].where((item) => item.id == productId);
    if (contain.isEmpty) {
      Product cartProduct = Product(
          id: temp.id,
          image: temp.image,
          title: temp.title,
          price: temp.price,
          description: temp.description,
          size: temp.size,
          color: temp.color,
          quantity: numb);
      allItem['cart items'].add(cartProduct);
    } else {
      Product temp2 =
          allItem['cart items'].firstWhere((item) => item.id == productId);
      Product cartProduct = Product(
          id: temp2.id,
          image: temp2.image,
          title: temp2.title,
          price: temp2.price,
          description: temp2.description,
          size: temp2.size,
          color: temp2.color,
          quantity: temp2.quantity + numb);
      allItem['cart items'].removeWhere((item) => item.id == productId);
      allItem['cart items'].add(cartProduct);
    }
  }

  void dispose() {
    productStreamController.close(); // close our StreamController
  }
}

final bloc = ProductBloc();
