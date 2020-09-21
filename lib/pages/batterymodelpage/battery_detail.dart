import 'package:batterydoctor/components/customwidgets.dart';
import 'package:batterydoctor/pages/batterymodelpage/buynow.dart';
import 'package:batterydoctor/pages/batterymodelpage/orderitems.dart';
import 'package:batterydoctor/pages/home.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BatteryDetail extends StatefulWidget {
  final DocumentSnapshot doc;

  BatteryDetail({this.doc});

  @override
  _BatteryDetailState createState() => _BatteryDetailState(doc: this.doc);
}

class _BatteryDetailState extends State<BatteryDetail> {
  final DocumentSnapshot doc;
  int count = 1;

  _BatteryDetailState({this.doc});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: [
        Text(
          'Quantity : ',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
        IconButton(
          onPressed: () {
            setState(() {
              count++;
            });
          },
          icon: Icon(
            FontAwesomeIcons.plus,
            size: 18.0,
          ),
        ),
        Text(
          '$count',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        IconButton(
          onPressed: count <= 1
              ? null
              : () {
                  setState(() {
                    count--;
                  });
                },
          icon: Icon(
            FontAwesomeIcons.minus,
            size: 18.0,
          ),
        ),
        Builder(
          builder: (context) => CustomButton(
            label: 'Add To Cart',
            onTap: () {
              Item item = Item(
                  model: doc['model'],
                  imgUrl: doc['imgUrl'],
                  price: doc['price'],
                  qty: count);
              orderItems.addItem(item: item);
              final snackbar = SnackBar(
                content: Text('Item successfully added to Cart!'),
                duration: Duration(milliseconds: 1000),
              );
              Scaffold.of(context).showSnackBar(snackbar);
            },
          ),
        )
      ],
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          '${doc['model']}',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        elevation: 0.0,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: IconButton(
              icon: Icon(
                Icons.shopping_cart,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BuyNow(orderItems.cartItems)));
              },
            ),
          )
        ],
      ),
      body: Container(
        child: ListView(
          children: [
            Hero(
              tag: doc['model'],
              child: CachedNetworkImage(
                fit: BoxFit.fill,
                width: double.infinity,
                imageUrl: doc['imgUrl'],
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            ListTile(
              title: Text(
                "${doc['model']}",
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              subtitle: Text(
                'Ks - ${doc['price']}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26.0,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Divider(
                color: Colors.black,
                height: 2.0,
                thickness: 1.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Specifications',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  productDetailText(
                      label: 'Product Model', value: '${doc['model']}'),
                  productDetailText(
                      label: 'Capacity', value: '${doc['capacity']} AH'),
                  productDetailText(
                      label: 'Voltage', value: '${doc['voltage']} V'),
                  productDetailText(label: 'Size', value: '${doc['size']}'),
                  productDetailText(
                      label: 'Standard', value: '${doc['standard']}'),
                  productDetailText(
                      label: 'Made In', value: '${doc['madeIn']}'),
                  productDetailText(
                      label: 'Battery Type', value: '${doc['type']}'),
                  productDetailText(
                      label: 'Used for', value: '${doc['usefor']}'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Padding productDetailText({String label, String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Row(
        children: [
          Text(
            '$label :',
            style: TextStyle(
              // color: Color(0xff2e7d32),
              color: Theme.of(context).primaryColor,
              fontSize: 18.0,
              fontWeight: FontWeight.w900,
            ),
          ),
          Text(
            ' $value',
            style: TextStyle(
              // color: Color(0xff2e7d32),
              // color: ,
              fontSize: 18.0,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
