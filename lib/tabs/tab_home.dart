import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "../providers/provider_item.dart";

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  //* 상품 정보를 데이터베이스에서 가져올 때 얼마나 걸릴지 모르기 때문에
  //* Futurebuilder를 사용합니다
  @override
  Widget build(BuildContext context) {
    //* UI도 소비해야하기 때문에 listen = true
    final itemProvider = Provider.of<ItemProvider>(context);

    return FutureBuilder(
        //* future로 등록된 함수가 실행되는 동안 나머지 UI를 빌드한다(논블록어싱크)
        future: itemProvider.fetchItems(),
        builder: (context, snapshot) {
          if (itemProvider.items.length == 0) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2 / 3,
                ),
                itemCount: itemProvider.items.length,
                itemBuilder: ((context, index) {
                  return GridTile(
                      child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/item_detail',
                          arguments: itemProvider.items[index]);
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(itemProvider.items[index].imageUrl),
                          Text(
                            itemProvider.items[index].title,
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            itemProvider.items[index].price.toString() + "원",
                            style: TextStyle(fontSize: 16, color: Colors.red),
                          )
                        ],
                      ),
                    ),
                  ));
                }));
          }
        });
  }
}
