import 'package:flutter/material.dart';
import 'package:milma_admin_app/new_pg.dart'; // Import the AddItemPage

class ProductsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 10, // Set the number of products as needed
        itemBuilder: (context, index) {
          // Replace the placeholder data with your actual product data
          String productName = "Product $index";
          String category = "Category $index";
          double price = 19.99 + index * 5;

          return Card(
            child: Container(
              child: ListTile(
                leading: Container(
                  width: 100,
                  height: 100,
                  child: Image.network(
                    'https://placekitten.com/100/100', // Replace with your image URL
                    fit: BoxFit.cover,
                  ),
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productName,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(category),
                    Text('\$$price'),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        // Redirect to the "Add Items" page
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AddItemPage()),
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        // Delete the item
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Deleted: $productName'),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
