import 'package:batterydoctor/components/customwidgets.dart';
import 'package:batterydoctor/pages/batterymodelpage/orderitems.dart';
import 'package:batterydoctor/pages/home.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyCart extends StatefulWidget {
  final List<Item> items;

  MyCart(this.items);

  @override
  _MyCartState createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  TextEditingController locationController;
  TextEditingController phoneController;
  TextEditingController userController;
  TextEditingController emailController;
  String email = '';
  String id = '';
  String location = '';
  String phone = '';
  String username = '';
  Timestamp timeStamp;
  int totalAmount = 0;

  getUserInfo() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    DocumentSnapshot snapshot = await userInfo.document(user.uid).get();
    setState(() {
      email = snapshot['email'];
      id = snapshot['id'];
      location = snapshot['location'];
      phone = snapshot['phone'];
      username = snapshot['username'];
      timeStamp = snapshot['timestamp'];
      locationController.text = location;
      phoneController.text = phone;
      userController.text = username;
      emailController.text = email;
    });
  }

  getItemsTotalAmount() {
    int total = 0;
    for (Item item in widget.items) {
      total = total + (item.price * item.qty);
    }
    totalAmount = total;
  }

  @override
  void initState() {
    super.initState();
    locationController = TextEditingController();
    phoneController = TextEditingController();
    userController = TextEditingController();
    emailController = TextEditingController();
    getUserInfo();
    getItemsTotalAmount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: Text(
            'Total : Ks $totalAmount/-',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        CustomButton(
          label: 'Order Now',
          onTap: () {},
        )
      ],
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              'My Cart',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Icon(
                FontAwesomeIcons.shoppingCart,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  int price = widget.items[index].price;
                  String imgUrl = widget.items[index].imgUrl;
                  String model = widget.items[index].model;
                  int qty = widget.items[index].qty;
                  return Card(
                    child: Container(
                      height: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.remove_circle,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                totalAmount = totalAmount - (price * qty);
                                orderItems.removeItem(
                                    item: widget.items[index]);
                              });
                            },
                          ),
                          Container(
                            child: CachedNetworkImage(
                              imageUrl: imgUrl,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8.0,
                              horizontal: 8.0,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  model,
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text("$price Ks"),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(FontAwesomeIcons.plus),
                                iconSize: 15.0,
                                onPressed: () {
                                  setState(() {
                                    widget.items[index].addqty();
                                    getItemsTotalAmount();
                                  });
                                },
                                splashRadius: 15.0,
                              ),
                              Text(
                                '$qty',
                                style: TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                              IconButton(
                                icon: Icon(FontAwesomeIcons.minus),
                                iconSize: 15.0,
                                onPressed: qty <= 1
                                    ? null
                                    : () {
                                        setState(() {
                                          widget.items[index].minusqty();
                                          getItemsTotalAmount();
                                        });
                                      },
                                splashRadius: 15.0,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: widget.items.length,
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  CustomTextField(
                    icon: Icons.account_circle,
                    controller: userController,
                    onChanged: (value) {},
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.location_on,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: TextField(
                              controller: locationController,
                              onChanged: (value) {},
                              maxLines: 2,
                              decoration: InputDecoration(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  CustomTextField(
                    icon: Icons.phone_iphone,
                    controller: phoneController,
                    onChanged: (value) {},
                  ),
                  CustomTextField(
                    icon: Icons.mail_outline,
                    controller: emailController,
                    onChanged: (value) {},
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    locationController.dispose();
    phoneController.dispose();
    userController.dispose();
    emailController.dispose();
    super.dispose();
  }
}

// Card(
// child: Row(
// children: [
// Expanded(
// child: ListTile(
// leading: CachedNetworkImage(
// imageUrl: imgUrl,
// errorWidget: (context, url, error) =>
// Icon(Icons.error),
// ),
// title: Text('$model'),
// subtitle: Text('$price Ks'),
// trailing: Text(
// '$qty',
// style: TextStyle(
// fontWeight: FontWeight.w500,
// fontSize: 18.0,
// ),
// ),
// ),
// ),
// IconButton(
// icon: Icon(
// Icons.clear,
// // color: Colors.grey,
// ),
// onPressed: () {
// setState(() {
// totalAmount = totalAmount - (price * qty);
// orderItems.removeItem(item: widget.items[index]);
// });
// },
// )
// ],
// ),
// );
