import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';

class AddItemPage extends StatefulWidget {
  @override
  _AddItemPageState createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  List<File> _imageFiles = []; // List to store selected image files
  String? _selectedCategory;

  TextEditingController productNameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController timeRequiredController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  // Function to handle image selection using image picker
  Future<void> _pickImages() async {
    final picker = ImagePicker();
    List<XFile>? pickedFiles = await picker.pickMultiImage();

    if (pickedFiles != null) {
      setState(() {
        _imageFiles = pickedFiles.map((file) => File(file.path)).toList();
      });
    }
  }

  // Function to build a row of image widgets
  Widget buildImageRow() {
    return Row(
      children: _imageFiles.map((file) => buildImageWidget(file)).toList(),
    );
  }

  // Function to build an image widget
  Widget buildImageWidget(File imageFile) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Image.file(
        imageFile,
        width: 100,
        height: 100,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<String> categories = ['Starter', 'Main Course', 'Dessert', 'Shakes'];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop(); // Navigate back when back button is pressed
          },
        ),
        title: Text('Add Item'), // You can customize the title as needed
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text(
                "Add product images",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                ),
              ),
              SizedBox(height: 20),
              buildImageRow(), // Display selected images
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  _pickImages(); // Open image picker when button is pressed
                },
                child: Text('Select Images'),
              ),
              SizedBox(height: 20),
              buildRow("Product Name", "Enter product name", productNameController, labelFontSize: 20),
              SizedBox(height: 10),
              buildRow("Price", "Enter price", priceController, inputType: TextInputType.number, labelFontSize: 20),
              SizedBox(height: 10),
              buildRow("Time Required", "Enter time required (HH:MM)", timeRequiredController, inputType: TextInputType.datetime, labelFontSize: 20),
              SizedBox(height: 10),
              buildCategoryDropdown("Category", categories), // Updated to dropdown menu
              SizedBox(height: 10),
              buildRow("Description", "Enter description", descriptionController, maxLines: 2, labelFontSize: 20),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      clearFields();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      onPrimary: Colors.indigo,
                    ),
                    child: Text('Clear'),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Add your next button onPressed logic here
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.indigo,
                      onPrimary: Colors.white,
                    ),
                    child: Text('Next'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildRow(String label, String hintText, TextEditingController controller, {int maxLines = 1, TextInputType inputType = TextInputType.text, double labelFontSize = 16}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Text(
            "$label:",
            style: TextStyle(
              fontSize: labelFontSize,
              fontWeight: FontWeight.bold,
              color: Colors.indigo,
            ),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          flex: 2,
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText,
              border: OutlineInputBorder(),
            ),
            maxLines: maxLines,
            keyboardType: inputType,
            inputFormatters: inputType == TextInputType.datetime ? [TimeInputFormatter()] : null,
          ),
        ),
      ],
    );
  }

  Widget buildCategoryDropdown(String label, List<String> categories) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Text(
            "$label:",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.indigo,
            ),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          flex: 2,
          child: DropdownButtonFormField<String>(
            value: _selectedCategory,
            items: categories.map((String category) {
              return DropdownMenuItem<String>(
                value: category,
                child: Text(category),
              );
            }).toList(),
            onChanged: (String? value) {
              setState(() {
                _selectedCategory = value;
              });
            },
            decoration: InputDecoration(
              hintText: "Select category",
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }

  void clearFields() {
    productNameController.clear();
    priceController.clear();
    timeRequiredController.clear();
    descriptionController.clear();
    setState(() {
      _selectedCategory = null;
      _imageFiles.clear();
    });
  }
}

class TimeInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final newText = newValue.text;

    if (newText.isEmpty) {
      return newValue.copyWith(text: '');
    }

    final buffer = StringBuffer();

    for (int i = 0; i < newText.length; i++) {
      if (i > 0 && i % 2 == 0) {
        buffer.write(':');
      }

      buffer.write(newText[i]);

      if (i == 4) {
        break;
      }
    }

    return newValue.copyWith(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.length),
    );
  }
}
