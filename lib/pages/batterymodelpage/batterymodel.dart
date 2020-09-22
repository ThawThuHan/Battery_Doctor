import 'package:batterydoctor/pages/batterymodelpage/battery_detail.dart';
import 'package:batterydoctor/pages/batterymodelpage/buynow.dart';
import 'package:batterydoctor/pages/home.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BatteryModel extends StatefulWidget {
  final brand;

  BatteryModel({this.brand});

  @override
  _BatteryModelState createState() => _BatteryModelState();
}

class _BatteryModelState extends State<BatteryModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        elevation: 0.0,
        title: Text(
          '${widget.brand} Brand',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        // automaticallyImplyLeading: false,
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
            ),
          )
        ],
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: batteries
            .document('w4m1yJ1mtsKlpAirP3gT')
            .collection(widget.brand)
            .getDocuments(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: Container(child: CircularProgressIndicator()));
          }
          List<DocumentSnapshot> docs = snapshot.data.documents;
          List<Widget> children = docs.map((DocumentSnapshot e) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BatteryDetail(
                            doc: e,
                          )),
                );
              },
              child: Container(
                padding: EdgeInsets.all(8.0),
                child: Material(
                  elevation: 10.0,
                  borderRadius: BorderRadius.circular(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(12),
                            topLeft: Radius.circular(12),
                          ),
                          child: Hero(
                            tag: e['model'],
                            child: CachedNetworkImage(
                              imageUrl: e['imgUrl'],
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(12.0),
                              bottomLeft: Radius.circular(12.0),
                            )),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              '${e['model']}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              '${e['price']} KS',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList();
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 100 / 120,
            ),
            itemBuilder: (context, index) {
              return children[index];
            },
            itemCount: children.length,
          );
        },
      ),
    );
  }
}
