import 'package:flutter/material.dart';
import 'add_items.dart';
import 'products.dart'; // Import the ProductsPage
import 'orders.dart'; // Import the OrdersPage

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(),
        '/orders': (context) => OrdersPage(),
        '/products': (context) => ProductsPage(),
        '/add_items': (context) => AddItemPage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  bool isDeliveryCompleted = false;

  Widget _buildBody() {
    switch (_currentIndex) {
      case 0:
        return OrdersPage();
      case 1:
        return ProductsPage();
      case 2:
      // Return a disabled button if delivery is completed
        return isDeliveryCompleted ? DisabledAddItemButton() : AddItemPage();
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 21, 39, 75),
        title: Text(
          'Happiness Corner',
          style: TextStyle(color: Colors.white), // Set text color to white
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.home,
            color: Colors.white, // Set icon color to white
          ),
          onPressed: () {
            // Add your home icon onPressed logic here
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.notifications,
              color: Colors.white, // Set icon color to white
            ),
            onPressed: () {
              // Add your notification icon onPressed logic here
            },
          ),
        ],
      ),
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Colors.indigo,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart), // Remove explicit color setting
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category), // Remove explicit color setting
            label: 'Products',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add), // Remove explicit color setting
            label: 'Add Item',
          ),
        ],
      ),
    );
  }
}

class DisabledAddItemButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: null,
      child: Text(
        'Add Item (Disabled)',
        style: TextStyle(color: Colors.grey), // Set text color to grey
      ),
    );
  }
}
