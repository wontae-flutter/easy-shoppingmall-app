import 'package:flutter/material.dart';
import "../tabs/tabs.dart";
import 'package:palestine_console/palestine_console.dart';

//* 네비게이션 탭을 선택할 때마다 Body의 내용이 바뀌어야하므로 Stf을 사용합니다
//* <Widget>tabs을 만들고 setState()로 currentIndex를 바꾼다는 것
class IndexScreen extends StatefulWidget {
  const IndexScreen({super.key});

  @override
  State<IndexScreen> createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  int _currentIndex = 0;
  final List<Widget> _tabs = [
    HomeTab(),
    ItemSearchTab(),
    CartTab(),
    ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    //* body 전체가 리빌드되어야합니다
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Shopping mall"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        iconSize: 30,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        selectedLabelStyle: TextStyle(fontSize: 12),
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            //* appBar에 검색창을 놓고 싶은데 ItemSearchTab을 사용하면
            //* appBar가 indexScreen의 것으로 유지되기 때문에
            // 검색창에 한해서만 탭을 활용하는게 아니라 아예 SearchScreen으로 보내버린다.
            //! 대부분의 쇼핑몰 앱에서 사용하는 방식
            if (index == 1) {
              setState(() {
                _currentIndex = 0;
              });
              Navigator.pushNamed(context, "/item_search");
            }
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: '검색'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: '장바구니'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '프로필'),
        ],
      ),
      body: _tabs[_currentIndex],
    );
  }
}
