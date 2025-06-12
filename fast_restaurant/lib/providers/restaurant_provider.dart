import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/restaurant_model.dart';
import '../models/table_model.dart';
// import '../models/menu_item_model.dart';

class RestaurantProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<RestaurantModel> _restaurants = [];
  List<RestaurantModel> _searchResults = [];
  bool _isLoading = false;

  List<RestaurantModel> get restaurants => _restaurants;
  List<RestaurantModel> get searchResults => _searchResults;
  bool get isLoading => _isLoading;

  Future<void> loadRestaurants() async {
    try {
      _isLoading = true;
      notifyListeners();

      final querySnapshot = await _firestore
          .collection('restaurants')
          .where('isActive', isEqualTo: true)
          .orderBy('rating', descending: true)
          .get();

      _restaurants = querySnapshot.docs
          .map((doc) => RestaurantModel.fromMap(doc.data()))
          .toList();
    } catch (e) {
      print('Error loading restaurants: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> searchRestaurants(String query) async {
    if (query.isEmpty) {
      _searchResults = [];
      notifyListeners();
      return;
    }

    try {
      _isLoading = true;
      notifyListeners();

      // Search by restaurant name
      final restaurantQuery = await _firestore
          .collection('restaurants')
          .where('isActive', isEqualTo: true)
          .where('name', isGreaterThanOrEqualTo: query)
          .where('name', isLessThanOrEqualTo: query + '\uf8ff')
          .get();

      // Search by menu items
      final menuQuery = await _firestore
          .collection('restaurants')
          .where('isActive', isEqualTo: true)
          .get();

      Set<RestaurantModel> results = {};

      // Add restaurants found by name
      for (var doc in restaurantQuery.docs) {
        results.add(RestaurantModel.fromMap(doc.data()));
      }

      // Add restaurants found by menu items
      for (var doc in menuQuery.docs) {
        final restaurant = RestaurantModel.fromMap(doc.data());
        final hasMatchingMenu = restaurant.menuItems.any((item) =>
            item.name.toLowerCase().contains(query.toLowerCase()) ||
            item.tags.any((tag) => tag.toLowerCase().contains(query.toLowerCase())));

        if (hasMatchingMenu) {
          results.add(restaurant);
        }
      }

      _searchResults = results.toList();
    } catch (e) {
      print('Error searching restaurants: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> createRestaurant(RestaurantModel restaurant) async {
    try {
      await _firestore
          .collection('restaurants')
          .doc(restaurant.id)
          .set(restaurant.toMap());
      return true;
    } catch (e) {
      print('Error creating restaurant: $e');
      return false;
    }
  }

  Future<bool> updateRestaurant(RestaurantModel restaurant) async {
    try {
      await _firestore
          .collection('restaurants')
          .doc(restaurant.id)
          .update(restaurant.toMap());
      return true;
    } catch (e) {
      print('Error updating restaurant: $e');
      return false;
    }
  }

  Future<List<TableModel>> getAvailableTables(
    String restaurantId,
    DateTime date,
    DateTime time,
  ) async {
    try {
      final restaurantDoc = await _firestore
          .collection('restaurants')
          .doc(restaurantId)
          .get();

      if (!restaurantDoc.exists) return [];

      final restaurant = RestaurantModel.fromMap(restaurantDoc.data()!);
      
      // Check bookings for the specific time
      final bookingsQuery = await _firestore
          .collection('bookings')
          .where('restaurantId', isEqualTo: restaurantId)
          .where('bookingDate', isEqualTo: date.millisecondsSinceEpoch)
          .get();

      final bookedTableIds = bookingsQuery.docs
          .map((doc) => doc.data()['tableId'] as String)
          .toSet();

      return restaurant.tables
          .where((table) => 
              (table.status == TableStatus.available) &&
              (!bookedTableIds.contains(table.id)))
          .toList();
    } catch (e) {
      print('Error getting available tables: $e');
      return [];
    }
  }
}
