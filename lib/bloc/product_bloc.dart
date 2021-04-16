import 'package:flutter/material.dart';
import 'dart:async';
import 'package:my_app/model/Product.dart';

class ProductBloc {
  final cartStreamController = StreamController.broadcast();
  Stream get getStream => cartStreamController.stream;

  final Map allItem = {'shop items': products, 'cart items': []};
  void addToCart(product,numb){
    allItem['shop items'].
  }
}
