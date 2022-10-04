import 'package:flutter/material.dart';
import '../models/model_item.dart';
import "package:provider/provider.dart";
import '../providers/provider_auth.dart';
import '../providers/provider_item.dart';
import '../providers/provider_cart.dart';
import "package:palestine_console/palestine_console.dart";

class ItemDetailScreen extends StatelessWidget {
  const ItemDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //* item이 바뀔 때마다 리빌드가 되어야하기에 build 내부에 들어가있어야 합니다
    //* 전달받은 props 받는 방법
    final item = ModalRoute.of(context)!.settings.arguments as Item;
    //! 로그인한 유저 입장에서 해당 상품이 장바구니에 없다면 추가버튼
    //! 이미 있으면....
    //* 즉 장바구니, 유저 프로바이더가 필요하겠죠
    final cart = Provider.of<CartProvider>(context);
    final authClient =
        Provider.of<FirebaseAuthProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(item.title),
      ),
      body: Container(
          padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
          child: ListView(
            children: [
              Image.network(item.imageUrl),
              SizedBox(height: 6),
              Padding(
                padding: EdgeInsets.only(right: 40),
                child: Text(
                  item.title,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.brand),
                        Text(item.price.toString()),
                        Text(item.registerDate),
                      ]),
                  cart.isItemInCart(item)
                      ? Icon(
                          Icons.check,
                          color: Colors.blue,
                        )
                      : InkWell(
                          onTap: () {
                            cart.addItemToCart(authClient.user, item);
                            Print.white("장바구니에 책이 추가되었습니다.");
                          },
                          child: Column(children: [
                            Icon(
                              Icons.add,
                              color: Colors.blue,
                            ),
                            SizedBox(height: 6),
                            Text(
                              "담기",
                              style: TextStyle(color: Colors.blue),
                            )
                          ]),
                        ),
                ],
              ),
              SizedBox(height: 12),
              Text(
                item.description,
                style: TextStyle(fontSize: 16),
              ),
            ],
          )),
    );
  }
}
