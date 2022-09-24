import 'package:flutter/material.dart';
import "../tabs/tabs.dart";

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
    CartTab(),
    ItemSearchTab(),
    MyPageTab(),
  ];

  @override
  Widget build(BuildContext context) {
    //* body 전체가 리빌드되어야합니다
    return Scaffold(
      appBar: AppBar(
        title: Text("Hello"),
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
