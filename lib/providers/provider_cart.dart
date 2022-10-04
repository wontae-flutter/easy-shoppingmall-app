import 'package:flutter/material.dart';
import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "../models/model_item.dart";
import 'package:palestine_console/palestine_console.dart';

class CartProvider with ChangeNotifier {
  late CollectionReference cartReference;
  List<Item> cartItems = [];

  CartProvider({reference}) {
    cartReference = reference ?? FirebaseFirestore.instance.collection("carts");
  }

  //* 굳이 리턴값으로 새로운 items를 반환하지 않더라도
  //* notifyListers()로 items의 변화를 실시간으로 보고한다
  Future<void> fetchCartItemsOrMakeCart(User? user) async {
    if (user == null) {
      return;
    }

    final cartSnapshot = await cartReference.doc(user.uid).get();

    if (cartSnapshot.exists) {
      //* items필드는 array로 정의되어 있습니다
      Map<String, dynamic> document =
          //* snapshot은 하나의 document를 단위로 합니다
          cartSnapshot.data() as Map<String, dynamic>;
      //! 왜 굳이 빈 어레이 temp를 새로 하나 만들어야 하나요?
      //! 빈 어레이를 만들지 않으면 계속 생겨나는데....
      List<Item> temp = [];
      for (var item in document['items']) {
        temp.add(Item.fromMap(item));
      }
      //* best practice가 속성으로 정의된 state에 재할당하는 것입니다.
      cartItems = temp;
      notifyListeners();
    } else {
      //* 없으면 하나 생성하세요!
      await cartReference.doc(user.uid).set({"items": []});
      notifyListeners();
    }
  }

  Future<void> addItemToCart(User? user, Item item) async {
    cartItems.add(item);
    //* state immutability
    Map<String, dynamic> cartItemsMap = {
      "items": cartItems.map((item) {
        return item.toSnapShot();
      }).toList()
    };
    await cartReference.doc(user!.uid).set(cartItemsMap);
    notifyListeners();
  }

  Future<void> removeItemFromCart(User? user, Item item) async {
    cartItems.removeWhere((element) => element.id == item.id);
    Map<String, dynamic> cartItemsMap = {
      "items": cartItems.map((item) {
        return item.toSnapShot();
      }).toList()
    };
    await cartReference.doc(user!.uid).set(cartItemsMap);
    notifyListeners();
  }

  bool isItemInCart(Item item) {
    return cartItems.any(((element) => element.id == item.id));
  }
}
