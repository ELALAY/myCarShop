
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../components/my_textfields/my_numberfield.dart';
import '../components/my_textfields/my_textfield.dart';
import '../models/car_model.dart';

class NewCarFormScreen extends StatefulWidget {
  const NewCarFormScreen({super.key});

  @override
  NewCarFormScreenState createState() => NewCarFormScreenState();
}

class NewCarFormScreenState extends State<NewCarFormScreen> {
  TextEditingController modelController = TextEditingController();
  TextEditingController makerController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController kilometersController = TextEditingController();
  TextEditingController descirptionController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();

  String transmission = 'Automatic';
  String fuelType = 'Petrol';
  List<File> images = [];
  bool isLoading = true;

  @override
  void initState() {
    isLoading = false;
    super.initState();
  }

  // Function to pick images from gallery
  Future<void> pickImages() async {
    final pickedFiles = await _picker.pickMultiImage();
    if (pickedFiles != null) {
      setState(() {
        // Ensure we only take a sublist if there are more than 6 images
        if (pickedFiles.length > 6) {
          images =
              pickedFiles.map((file) => File(file.path)).toList().sublist(0, 6);
        } else {
          images = pickedFiles.map((file) => File(file.path)).toList();
        }
      });
    }
  }

  // Function to upload images to Firebase Storage
  Future<List<String>> uploadImages() async {
    List<String> downloadUrls = [];
    for (File image in images) {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      UploadTask uploadTask =
          FirebaseStorage.instance.ref('car_images/$fileName').putFile(image);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      downloadUrls.add(downloadUrl);
    }
    return downloadUrls;
  }

  // Function to save car data to Firestore
  Future<void> saveCar() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      List<String> imageUrls = await uploadImages();

      CarModel newCar = CarModel(
          ownerId: 'Aymane',
          model: modelController.text,
          make: makerController.text,
          year: int.parse(yearController.text),
          price: double.parse(priceController.text),
          kilometers: int.parse(kilometersController.text),
          description: descirptionController.text,
          images: imageUrls,
          transmission: transmission,
          fuelType: fuelType);

      // ignore: use_build_context_synchronously
      Navigator.pop(context); // Go back after successful submission
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post a New Car'),
        actions: [
          IconButton(onPressed: saveCar, icon: const Icon(Icons.check))
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Model
                      MyTextField(
                          controller: modelController,
                          label: 'Model',
                          color: Colors.deepPurple,
                          enabled: true),
                      // Maker
                      MyTextField(
                          controller: makerController,
                          label: 'Maker',
                          color: Colors.deepPurple,
                          enabled: true),
                      // Year
                      MyNumberField(
                          controller: yearController,
                          label: 'Year',
                          color: Colors.deepPurple,
                          enabled: true),
                      // Price
                      MyNumberField(
                          controller: priceController,
                          label: 'Price',
                          color: Colors.deepPurple,
                          enabled: true),
                      // Kilometers
                      MyNumberField(
                          controller: kilometersController,
                          label: 'Kilometers',
                          color: Colors.deepPurple,
                          enabled: true),
                      // Description
                      MyTextField(
                          controller: descirptionController,
                          label: 'Description',
                          color: Colors.deepPurple,
                          enabled: true),
                      // Transmission
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.deepPurple),
                            ),
                            labelText: 'Transmission',
                            labelStyle: TextStyle(color: Colors.deepPurple),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.deepPurple),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.deepPurple),
                            ),
                          ),
                          value: transmission,
                          items: ['Automatic', 'Manual'].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              transmission = value!;
                            });
                          },
                        ),
                      ),
                      // Fuel Type
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.deepPurple),
                            ),
                            labelText: 'Transmission',
                            labelStyle: TextStyle(color: Colors.deepPurple),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.deepPurple),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.deepPurple),
                            ),
                          ),
                          value: fuelType,
                          items: ['Petrol', 'Diesel', 'Electric']
                              .map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              fuelType = value!;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text('Upload Car Images:'),
                      ElevatedButton(
                        onPressed: pickImages,
                        child: const Text('Select Images'),
                      ),
                      images.isNotEmpty
                          ? GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3, // 3 images per row
                                crossAxisSpacing: 4.0,
                                mainAxisSpacing: 4.0,
                              ),
                              itemCount: images.length,
                              itemBuilder: (context, index) {
                                return Image.file(
                                  images[index],
                                  fit: BoxFit.cover,
                                );
                              },
                            )
                          : const Text('No images selected'),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
