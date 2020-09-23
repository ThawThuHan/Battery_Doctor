import 'package:batterydoctor/pages/batterymodelpage/my_cart.dart';
import 'package:batterydoctor/pages/batterymodelpage/showbattery_brand.dart';
import 'package:batterydoctor/pages/home.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BatteryHome extends StatefulWidget {
  @override
  _BatteryHomeState createState() => _BatteryHomeState();
}

class _BatteryHomeState extends State<BatteryHome> {
  PageController pageController;
  String selectedBatteryType = 'Wet Battery';
  List<DocumentSnapshot> wetBatteryBrands;

  getWetBatteryBrand() async {
    QuerySnapshot snapshot = await wetBatteryBrand.getDocuments();
    List<DocumentSnapshot> docs = snapshot.documents;
    setState(() {
      wetBatteryBrands = docs;
    });
  }

  @override
  void initState() {
    super.initState();
    pageController = PageController(
      initialPage: 0,
    );
    getWetBatteryBrand();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text(
          'Battery Doctor',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24.0,
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        // centerTitle: true,
        elevation: 0.0,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyCart(orderItems.cartItems)));
              },
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Container(
              // color: Theme.of(context).primaryColor,
              height: 220,
              padding: EdgeInsets.all(8.0),
              child: Carousel(
                borderRadius: true,
                boxFit: BoxFit.fill,
                dotSize: 5.0,
                dotBgColor: Colors.transparent,
                animationCurve: Curves.easeInOut,
                animationDuration: Duration(milliseconds: 800),
                indicatorBgPadding: 2.0,
                images: [
                  NetworkImage(
                      'https://sc01.alicdn.com/kf/HTB1RLPZoUR1BeNjy0Fmq6z0wVXa6/232969933/HTB1RLPZoUR1BeNjy0Fmq6z0wVXa6.jpg'),
                  NetworkImage(
                      'https://northmaintow.net/images/mobile-battery-contra-costa.jpg'),
                  NetworkImage(
                      'https://dlior9lx1k7r2.cloudfront.net/postphoto/6b01f03e-7319-442b-bf03-9ccca36144b0.jpg'),
                ],
              )),
          Container(
            color: Theme.of(context).primaryColor,
            padding: EdgeInsets.only(bottom: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  child: TabContainer(
                    label: 'Wet Battery',
                    isSelected: selectedBatteryType == 'Wet Battery',
                  ),
                  onTap: () {
                    setState(() {
                      selectedBatteryType = 'Wet Battery';
                    });
                    pageController.animateToPage(0,
                        duration: Duration(milliseconds: 400),
                        curve: Curves.bounceInOut);
                  },
                ),
                GestureDetector(
                  child: TabContainer(
                    label: 'Dry Battery',
                    isSelected: selectedBatteryType == 'Dry Battery',
                  ),
                  onTap: () {
                    setState(() {
                      selectedBatteryType = 'Dry Battery';
                    });
                    pageController.animateToPage(1,
                        duration: Duration(milliseconds: 400),
                        curve: Curves.bounceInOut);
                  },
                ),
                GestureDetector(
                  child: TabContainer(
                    label: 'DIM Battery',
                    isSelected: selectedBatteryType == 'DIM Battery',
                  ),
                  onTap: () {
                    setState(() {
                      selectedBatteryType = 'DIM Battery';
                    });
                    pageController.animateToPage(2,
                        duration: Duration(milliseconds: 400),
                        curve: Curves.bounceInOut);
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: PageView(
                physics: NeverScrollableScrollPhysics(),
                controller: pageController,
                children: [
                  showBatteryBrand(context, wetBatteryBrands),
                  showBatteryBrand(context, wetBatteryBrands),
                  showBatteryBrand(context, wetBatteryBrands),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}

class TabContainer extends StatelessWidget {
  final String label;
  final bool isSelected;

  const TabContainer({Key key, this.label, this.isSelected = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: isSelected ? Colors.white : Colors.white54,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Container(
              width: 50,
              height: 4.0,
              color: isSelected ? Colors.white : Colors.transparent,
            ),
          )
        ],
      ),
    );
  }
}
