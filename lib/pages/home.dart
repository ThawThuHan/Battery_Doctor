import 'package:batterydoctor/pages/battery_home.dart';
import 'package:batterydoctor/pages/battery_service.dart';
import 'package:batterydoctor/pages/user_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'battery_change.dart';
import 'batterymodelpage/orderitems.dart';

final wetBatteryBrand = Firestore.instance.collection('WetBatteryBrand');
final userInfo = Firestore.instance.collection('Users');
final batteries = Firestore.instance.collection('Batteries');
OrderItems orderItems = OrderItems();

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PageController pageController;
  int pageIndex = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  onPageChanged(int index) {
    setState(() {
      pageIndex = index;
    });
  }

  onTap(int index) {
    setState(() {
      pageController.animateToPage(
        index,
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
        children: [
          BatteryHome(),
          BatteryService(),
          BatteryChange(),
          UserPage(),
        ],
        controller: pageController,
        onPageChanged: onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: Colors.white,
        currentIndex: pageIndex,
        onTap: (int index) {
          onTap(index);
        },
        activeColor: Theme.of(context).primaryColor,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.servicestack),
            title: Text('Service'),
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.exchangeAlt),
            title: Text('Changes'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text('Account'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }
}
