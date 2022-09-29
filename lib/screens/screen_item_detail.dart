import 'package:flutter/material.dart';
import '../models/model_item.dart';

class ItemDetailScreen extends StatelessWidget {
  const ItemDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //* item이 바뀔 때마다 리빌드가 되어야하기에 build 내부에 들어가있어야 합니다
    //* 전달받은 props 받는 방법
    final item = ModalRoute.of(context)!.settings.arguments as Item;
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
                  InkWell(
                    onTap: () {
                      //* 징바구니 담기 기능
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
