import 'package:flutter/material.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:getx/pages/home/home.dart';
import 'package:getx/pages/lists/list.dart';
import 'package:getx/pages/messages/message.dart';
import 'package:getx/pages/users/user.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
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
        body: bodyWidget.elementAt(_selectedIndex),
        bottomNavigationBar: CustomNavigationBar(
          items: buildNavigation,
          onTap: _onItemTapped,
          currentIndex: _selectedIndex,
          selectedColor: const Color.fromARGB(157, 183, 0, 255),
          unSelectedColor: const Color.fromARGB(218, 55, 0, 255),
          strokeColor: const Color.fromARGB(157, 183, 0, 255),
        ));
  }

  List<CustomNavigationBarItem> get buildNavigation {
    return <CustomNavigationBarItem>[
      itemNav(icon: Icons.home, title: "Home"),
      itemNav(icon: Icons.timer, title: "Jadwal"),
      itemNav(icon: Icons.list, title: "Mapel"),
      itemNav(icon: Icons.account_circle, title: "Profile"),
    ];
  }

  List<Widget> get bodyWidget {
    return <Widget>[Home(), ListPage(), Message(), Profile()];
  }

  CustomNavigationBarItem itemNav(
      {required IconData icon, required String title}) {
    return CustomNavigationBarItem(
        icon: Icon(icon),
        title: Text(
          title,
          style: const TextStyle(color: Color.fromARGB(157, 183, 0, 255)),
        ));
  }

  AppBar buildAppBar() {
    return AppBar(
      leading: IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
      centerTitle: true,
      title: const Text(
        "Alexandria",
        style: TextStyle(
            fontFamily: "Gaegu",
            fontSize: 24,
            color: Color.fromARGB(157, 183, 0, 255)),
      ),
      backgroundColor: Colors.white,
      bottomOpacity: 0,
      elevation: 0,
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
      ],
      iconTheme: const IconThemeData(color: Color(0xFFD9D9D9)),
    );
  }
}
