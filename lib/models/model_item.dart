import "package:cloud_firestore/cloud_firestore.dart";

class Item {
  late String title;
  late String description;
  late String brand;
  late String imageUrl;
  late int price;
  late String registerDate;
  late String id;

  Item({
    required this.title,
    required this.description,
    required this.brand,
    required this.imageUrl,
    required this.price,
    required this.registerDate,
    required this.id,
  });

  Item.fromSnapShot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    //* 자동생성된 id값은 바로 이렇게 찾을 수 있습니다
    id = snapshot.id;
    title = data['title'];
    description = data['description'];
    brand = data['brand'];
    imageUrl = data['imageUrl'];
    price = data['price'];
    registerDate = data['registerDate'];
  }

  //* carts 컬렉션의 document는 id로 userID를 사용,
  //* 각 유저마다 장바구니를 고유하게 가지고 있어야하기 때문이죠.

  //* items라는 array필드에 선택된 아이템들이 들어갈 것입니다.
  //* 즉 Item 객체를 carts의 어레이에 집어넣을 떄 이 객체를 파이어베이스가 인식할 수 있는 Map 형태로 변환해야 합니다
  //* hence, toSnapshot
  //* (이전에는 도큐먼트에서 가져오는 fromSnapShot 함수만 구현되어 있었음)

  //* carts 컬렉션의 각 도큐먼트의 items가 DocumentSnapshot형태가 아니므로 에러가 발생할 수 있기에
  //* fromMap 함수도 필요하다

  Item.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    title = data['title'];
    description = data['description'];
    brand = data['brand'];
    imageUrl = data['imageUrl'];
    price = data['price'];
    registerDate = data['registerDate'];
  }

  Map<String, dynamic> toSnapShot() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'brand': brand,
      'imageUrl': imageUrl,
      'price': price,
      'registerDate': registerDate,
    };
  }
}
