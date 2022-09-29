import 'package:flutter/material.dart';
import "package:provider/provider.dart";
import 'package:shoppingmall_app/providers/provider_item.dart';
import 'package:shoppingmall_app/providers/provider_search_query.dart';
import "package:palestine_console/palestine_console.dart";

//! 이미 ItemProvider에 상품 전체 정보를 넣어서 관리하고 있기에
//* Firebase와 다시 한번 통신하지 않아도 됩니다
class ItemSearchScreen extends StatelessWidget {
  const ItemSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final itemProvider = Provider.of<ItemProvider>(context);
    final searchQueryProvider = Provider.of<SearchQueryProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onChanged: (text) {
            searchQueryProvider.updateText(text);
          },
          autofocus: true,
          decoration: InputDecoration(
            hintText: "검색어를 입력하세요.",
            border: InputBorder.none,
          ),
          maxLines: 1,
          cursorColor: Colors.grey,
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              //! 계속 업데이트하기 위해 search에도 items 변수에 notifyListeners()를 달았는데
              //* 버튼 누를때마다에만 이게 달라져서... 요거를 항상 리스닝하려면
              //! build 위에 달아야하는게 아닐까?
              //! 에러 발생: build 위에 notifyListener()를 사용할수는 없다
              //! setState() or markNeedsBuild() called during build.
              itemProvider.search(searchQueryProvider.text);

              Print.blue("검색할 Query: ${searchQueryProvider.text}");
              Print.green("검색 결과: ${itemProvider.searchItems.map(
                (searchItem) {
                  Print.green(searchItem.title);
                  Print.green(searchItem.description);
                  Print.green(searchItem.brand);
                  Print.green(searchItem.price.toString());
                  Print.green(searchItem.registerDate);
                  Print.white("-----");
                },
              )}");
            },
            icon: Icon(Icons.search_rounded),
          )
        ],
      ),
      body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2 / 3,
          ),
          itemCount: itemProvider.searchItems.length,
          itemBuilder: ((context, index) {
            return GridTile(
                child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/item_detail',
                    arguments: itemProvider.searchItems[index]);
              },
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(itemProvider.searchItems[index].imageUrl),
                    Text(
                      itemProvider.searchItems[index].title,
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
          })),
    );
  }
}
