import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../models/car_model.dart';

class FirebaseDB {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//--------------------------------------------------------------------------------------
//********  cars Functions**********/
//--------------------------------------------------------------------------------------

  // Add a new car with auto-generated ID
  Future<bool> addcar(CarModel car) async {
    try {
      DocumentReference docRef =
          await _firestore.collection('cars').add(car.toMap());
      car = await getcarById(docRef.id);
      return true;
    } catch (e) {
      debugPrint('Error adding car: $e');
      return false;
    }
  }

  // Fetch cars where ownerId matches the given user ID and isArchived is false
  // Fetch cars where ownerId matches the given user ID
  Future<List<CarModel>> getUserActivecars(String uid) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('cars')
          .where('ownerId', isEqualTo: uid)
          .where('isArchived', isEqualTo: false)
          .get();

      return querySnapshot.docs
          .map((doc) =>
              CarModel.fromMap(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    } catch (e) {
      debugPrint('Error fetching cars: $e');
      rethrow;
    }
  }

  // Fetch cars where ownerId matches the given user ID
  Future<List<CarModel>> getUsercars(String uid) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('cars')
          .where('ownerId', isEqualTo: uid)
          .get();

      return querySnapshot.docs
          .map((doc) =>
              CarModel.fromMap(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    } catch (e) {
      debugPrint('Error fetching cars: $e');
      rethrow;
    }
  }

  // Fetch all cars
  Future<List<CarModel>> getAllcars() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('cars').get();
      return querySnapshot.docs
          .map((doc) =>
              CarModel.fromMap(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    } catch (e) {
      debugPrint('Error fetching cars: $e');
      rethrow;
    }
  }

  // Update an existing car
  Future<void> updatecar(CarModel car) async {
    try {
      // Reference to the 'cars' collection and the specific document to update
      _firestore.collection('cars').doc(car.id).update(car.toMap());

      debugPrint('Car updated successfully');
    } catch (e) {
      debugPrint('Error updating car: $e');
    }
  }

  Future<CarModel> getcarById(String carId) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection('cars').doc(carId).get();
      if (doc.exists) {
        return CarModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      } else {
        throw Exception('Car not found');
      }
    } catch (e) {
      throw Exception('Error fetching car: $e');
    }
  }

  // Method to delete a car
  Future<void> deletecar(String carId) async {
    try {
      //delete car
      await _firestore.collection('cars').doc(carId).delete();
    } catch (e) {
      debugPrint('Error deleting car: $e');
      rethrow;
    }
  }

}
