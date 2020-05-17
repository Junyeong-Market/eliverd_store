import 'package:flutter/material.dart';

import 'package:Eliverd/common/string.dart';
import 'package:Eliverd/common/color.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('엘리버드')
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              title: Text(addProduct),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.payment),
              title: Text(checkOut),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.remove),
              title: Text(removeProduct),
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: eliverdTappedColor,
          onTap: _onItemTapped
      ),
    );
  }
}
