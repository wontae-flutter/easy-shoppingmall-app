import "package:flutter/material.dart";
import "package:provider/provider.dart";
//* Firestore에서 무언가를 가져온다고 하면 무조건 필요하다.
import "package:cloud_firestore/cloud_firestore.dart";
import 'package:palestine_console/palestine_console.dart';
import "../models/model_item.dart";

//* 왜 모델엔 extends changenotifier이고
//* 프로바이더에는 with changenotifie이지?
//* If your model class is already extending another class, then you can't extend ChangeNotifier.
//! Dart does not allow multiple inheritance. In this case you must use a mixin.
class ItemProvider with ChangeNotifier {
  //* reference: Collection(RDBMS의 모델)의 주소를 다루는 객체
  late CollectionReference itemsReference;
  List<Item> items = [];

  ItemProvider({reference}) {
    itemsReference =
        reference ?? FirebaseFirestore.instance.collection("items");
  }

  // todosReference = FirebaseFirestore.instance.collection("todos");
  //   //* 지속적인 데이터 관리 및 변화 감지를 위해 Stream을 사용한다
  //   todoStream = todosReference.snapshots();

  Future<void> fetchItems() async {
    items = await itemsReference.get().then((QuerySnapshot results) {
      return results.docs.map((DocumentSnapshot snapshot) {
        return Item.fromSnapShot(snapshot);
      }).toList();
    });
    //* 굳이 리턴값으로 새로운 items를 반환하지 않더라도
    //* notifyListers()로 items의 변화를 실시간으로 보고하기 때문에 가능하다
    notifyListeners();
  }
}
