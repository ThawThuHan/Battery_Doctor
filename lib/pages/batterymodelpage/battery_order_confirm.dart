import 'dart:async';
import 'package:batterydoctor/components/customwidgets.dart';
import 'package:flutter/material.dart';

class OrderConfirm extends StatefulWidget {
  final Function onTap;

  OrderConfirm({this.onTap});

  @override
  _OrderConfirmState createState() => _OrderConfirmState();
}

class _OrderConfirmState extends State<OrderConfirm> {
  int count;
  Timer _timer;

  _startTimer() {
    count = 20;
    if (_timer != null) {
      _timer.cancel();
    }

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (count > 0) {
          count--;
        } else {
          _timer.cancel();
          widget.onTap();
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Order Confirm',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
        ),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 0.0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            count == 0
                ? CircleAvatar(
                    radius: 30.0,
                    backgroundImage: AssetImage('assets/images/checksign.png'),
                  )
                : Text(
                    '$count sec',
                    style: TextStyle(
                      fontSize: 50.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
            count == 0
                ? Text(
                    'ဝယ်ယူအားပေးမှုအတွက် ကျေးဇူးတင်ရှိပါသည်။',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Theme.of(context).primaryColor,
                    ),
                  )
                : Text(
                    'သင့်၏ Order ကို စက္ကန့် ၂၀ အတွင်း cancel ပြုလုပ်နိုင်ပါသည်။',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                count == 0
                    ? Text('')
                    : CustomButton(
                        colors: [
                          Colors.lightGreenAccent,
                          Theme.of(context).primaryColor,
                        ],
                        label: 'Order Confirm',
                        onTap: () {
                          setState(() {
                            count = 0;
                            _timer.cancel();
                          });
                          // widget.onTap();
                        },
                      ),
                SizedBox(
                  width: 10.0,
                ),
                count == 0
                    ? CustomButton(
                        colors: [
                          Theme.of(context).primaryColor,
                          Colors.lightGreenAccent
                        ],
                        label: 'Close',
                        onTap: () {
                          Navigator.popUntil(context, (route) => route.isFirst);
                        },
                      )
                    : CustomButton(
                        colors: [
                          Colors.pink,
                          Colors.red,
                        ],
                        label: 'Order Cancel',
                        onTap: () {
                          _timer.cancel();
                          Navigator.pop(context);
                        },
                      ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
