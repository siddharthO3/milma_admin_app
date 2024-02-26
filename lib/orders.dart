import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class OrdersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return OrderCard();
        },
      ),
    );
  }
}

class OrderCard extends StatefulWidget {
  @override
  _OrderCardState createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  bool isPreparing = false;
  bool isDelivering = false;

  void _showPreparingToast() {
    Fluttertoast.showToast(
      msg: 'Order must be in "Preparing" status before starting delivery.',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.grey[600]!,
      textColor: Colors.white,
    );
  }

  void _showDeliveryLockedToast() {
    Fluttertoast.showToast(
      msg: 'Order "Preparing" status is locked while delivery is ongoing.',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.grey[600]!,
      textColor: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Item Name',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('Quantity'),
            Text('Customer Name'),
            Text('Order Time'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Preparing Status',
                  style: TextStyle(color: Colors.indigo),
                ),
                Switch(
                  value: isPreparing,
                  onChanged: (value) {
                    // Only allow changing "Preparing" if delivery is not ongoing
                    if (!isDelivering) {
                      setState(() {
                        isPreparing = value;
                      });
                    } else {
                      _showDeliveryLockedToast();
                    }
                  },
                  activeTrackColor: Colors.green,
                  activeColor: Colors.green,
                  inactiveTrackColor: Colors.red,
                  inactiveThumbColor: Colors.red,
                  thumbColor: MaterialStateProperty.all<Color>(Colors.white),
                ),
                Text(
                  'Delivery Status',
                  style: TextStyle(color: Colors.indigo),
                ),
                Switch(
                  value: isDelivering,
                  onChanged: (value) {
                    setState(() {
                      // Prevent changing "Delivery Status" if "Preparing Status" is not green
                      if (isPreparing || !value) {
                        isDelivering = value;
                      } else {
                        _showPreparingToast();
                      }
                    });
                  },
                  activeTrackColor: Colors.green,
                  activeColor: Colors.green,
                  inactiveTrackColor: Colors.grey,
                  inactiveThumbColor: Colors.grey,
                  thumbColor: MaterialStateProperty.all<Color>(Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
