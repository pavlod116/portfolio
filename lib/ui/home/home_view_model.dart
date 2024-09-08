import 'package:flutter/material.dart';
import 'package:portfolio/model/card.dart';
import 'package:portfolio/ui/create_card/create_card_view.dart';

class HomeViewModel extends ChangeNotifier {
  double dragPosition = 0.0;
  bool isPulled = false;

  void handleDragUpdate(DragUpdateDetails details) {
    dragPosition += details.primaryDelta!;
    if (dragPosition > 300) {
      dragPosition = 300;
      isPulled = true;
    } else {
      isPulled = false;
    }
    notifyListeners();
  }

  void handleDragEnd(DragEndDetails details, BuildContext context) {
    if (!isPulled) {
      dragPosition = 0.0;
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (context) =>  const CreateCardPage()));
      dragPosition = 0.0;
    }
    notifyListeners();
  }

  final Map<String, dynamic> cardModel = {
    'card1': {
      'title': 'Hello',
      'color': Colors.red,
      'description': '',
    },
    'card2': {
      'title': 'Hi',
      'color': Colors.green,
      'description': '',
    },
    'card3': {
      'title': 'Hey',
      'color': Colors.blue,
      'description': '',
    },
    'card4': {
      'title': 'Gut Morgen',
      'color': Colors.orange,
      'description': '',
    }
  };

  List<CardModel> getCard() {
    return cardModel.values.map((e) {
      return CardModel.fromJson(e);
    }).toList();
  }
}
