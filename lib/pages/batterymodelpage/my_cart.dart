import 'package:batterydoctor/components/customwidgets.dart';
import 'package:batterydoctor/pages/batterymodelpage/battery_order_confirm.dart';
import 'package:batterydoctor/pages/batterymodelpage/orderitems.dart';
import 'package:batterydoctor/pages/home.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
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
  List orderItemList;

  convertOrderList() {
    List orderList = [];
    widget.items.forEach((element) {
      Map orderItem = {
        'brand': element.brand,
        'model': element.model,
        'price': element.price,
        'imgUrl': element.imgUrl,
        'Quantity': element.qty,
      };
      orderList.add(orderItem);
    });
    setState(() {
      orderItemList = orderList;
    });
  }

  postOrder() {
    order.document().setData({
      'orderItemList': orderItemList,
      'customerName': username,
      'address': location,
      'phone': phone,
      'email': email,
      'totalAmount': totalAmount,
    });
    setState(() {
      widget.items.clear();
      totalAmount = 0;
    });
  }

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
    convertOrderList();
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
            colors: [
              Colors.lightGreenAccent,
              Theme.of(context).primaryColor,
            ],
            label: 'Order Now',
            onTap: () {
              if (orderItemList.isNotEmpty) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        fullscreenDialog: true,
                        builder: (context) => OrderConfirm(
                              onTap: postOrder,
                            )));
                // postOrder();
                // showDialog(
                //     context: context,
                //     builder: (context) => CupertinoAlertDialog(
                //           title: Text('Order Confirmed!'),
                //           content: Text(
                //             'ဝယ်ယူအားပေးမှုအတွက်\nကျေးဇူးတင်ရှိပါသည်။',
                //             style: TextStyle(
                //               fontSize: 18.0,
                //             ),
                //           ),
                //           actions: [
                //             FlatButton(
                //               onPressed: () {
                //                 Navigator.pop(context);
                //               },
                //               child: Text('close'),
                //               textColor: Colors.blue,
                //             )
                //           ],
                //         ));
              } else {
                showDialog(
                    context: context,
                    builder: (context) => CupertinoAlertDialog(
                          title: Text('No Order in Your Cart!'),
                          actions: [
                            FlatButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('close'),
                              textColor: Colors.blue,
                            )
                          ],
                        ));
              }
            })
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
              child: widget.items.isEmpty
                  ? Center(
                      child: Text(
                        'No Item in your cart!',
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    )
                  : ListView.builder(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                    textCapitalization: TextCapitalization.words,
                    // onChanged: (value) {},
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
                              // onChanged: (value) {},
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
                    keyboardType: TextInputType.phone,
                    // onChanged: (value) {},
                  ),
                  CustomTextField(
                    icon: Icons.mail_outline,
                    controller: emailController,
                    // onChanged: (value) {},
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
