import 'package:batterydoctor/components/customwidgets.dart';
import 'package:batterydoctor/pages/batterymodelpage/batterymodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

showBatteryBrand(BuildContext context, List<DocumentSnapshot> docs) {
  if (docs == null) {
    return Center(child: CircularProgressIndicator());
  }
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
}
