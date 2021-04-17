import 'dart:async';

class CounterBloc {
  final counterStreamController = StreamController.broadcast();
  Stream get getStream => counterStreamController.stream;
  int counter = 0;
  void changeCounter(numb) {
    counter = numb;
    print("counter: $counter");
  }

  int getCounter() {
    return counter;
  }

  void dispose() {
    counterStreamController.close(); // close our StreamController
  }
}

final counterBloc = CounterBloc();
