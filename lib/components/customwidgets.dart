import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Function onTap;
  final String label;
  final List<Color> colors;

  const CustomButton({
    Key key,
    this.onTap,
    this.label,
    this.colors,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: colors),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key key,
    @required this.icon,
    @required this.controller,
    this.keyboardType,
    this.textCapitalization,
    this.onChanged,
  }) : super(key: key);

  final TextEditingController controller;
  final IconData icon;
  final Function onChanged;
  final TextInputType keyboardType;
  final TextCapitalization textCapitalization;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              icon,
              color: Theme.of(context).primaryColor,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: TextField(
                autocorrect: false,
                keyboardType: keyboardType,
                controller: controller,
                onChanged: onChanged,
                textCapitalization: textCapitalization,
                decoration: InputDecoration(),
              ),
            ),
          ),
        ],
      ),
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
