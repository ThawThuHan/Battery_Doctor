import 'package:batterydoctor/pages/batterymodelpage/batterymodel.dart';
import 'package:batterydoctor/pages/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class WetBattery extends StatelessWidget {
//   @override
//   _WetBatteryState createState() => _WetBatteryState();
// }
//
// class _WetBatteryState extends State<WetBattery> {
  // getBrand() async {
  //   QuerySnapshot brands = await wetBatteryBrand.getDocuments();
  // }

  // @override
  // void initState() {
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: wetBatteryBrand.getDocuments(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: Container(
              child: CircularProgressIndicator(),
            ),
          );
        }
        List<DocumentSnapshot> docs = snapshot.data.documents;
        List<Widget> children = docs.map((e) {
          return InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BatteryModel(
                      brand: e['name'],
                    ),
                  ));
            },
            child: BrandWidget(
              imgUrl: e['imgUrl'],
            ),
          );
        }).toList();
        return GridView.count(
          crossAxisCount: 3,
          children: children,
        );
      },
    );
  }
}

class BrandWidget extends StatelessWidget {
  final String imgUrl;

  BrandWidget({this.imgUrl});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      child: Container(
        height: 80.0,
        width: 80.0,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: CachedNetworkImageProvider(imgUrl), fit: BoxFit.fill),
        ),
      ),
    );
  }
}
