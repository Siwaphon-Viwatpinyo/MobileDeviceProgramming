import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import '../models/booking_model.dart';

class BookingProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Uuid _uuid = const Uuid();

  List<BookingModel> _userBookings = [];
  bool _isLoading = false;

  List<BookingModel> get userBookings => _userBookings;
  bool get isLoading => _isLoading;

  Future<void> loadUserBookings(String userId) async {
    try {
      _isLoading = true;
      notifyListeners();

      final querySnapshot = await _firestore
          .collection('bookings')
          .where('userId', isEqualTo: userId)
          .orderBy('bookingTime', descending: true)
          .get();

      _userBookings = querySnapshot.docs
          .map((doc) => BookingModel.fromMap(doc.data()))
          .toList();
    } catch (e) {
      print('Error loading user bookings: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> createBooking({
    required String userId,
    required String restaurantId,
    required String tableId,
    required DateTime bookingDate,
    required DateTime bookingTime,
    required int partySize,
    String specialRequests = '',
  }) async {
    try {
      final booking = BookingModel(
        id: _uuid.v4(),
        userId: userId,
        restaurantId: restaurantId,
        tableId: tableId,
        bookingDate: bookingDate,
        bookingTime: bookingTime,
        partySize: partySize,
        specialRequests: specialRequests,
        status: BookingStatus.confirmed,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await _firestore
          .collection('bookings')
          .doc(booking.id)
          .set(booking.toMap());

      return true;
    } catch (e) {
      print('Error creating booking: $e');
      return false;
    }
  }

  Future<bool> cancelBooking(String bookingId, String reason) async {
    try {
      await _firestore.collection('bookings').doc(bookingId).update({
        'status': BookingStatus.cancelled.index,
        'cancellationReason': reason,
        'updatedAt': DateTime.now().millisecondsSinceEpoch,
      });

      return true;
    } catch (e) {
      print('Error cancelling booking: $e');
      return false;
    }
  }

  Future<List<BookingModel>> getRestaurantBookings(
    String restaurantId,
    DateTime date,
  ) async {
    try {
      final querySnapshot = await _firestore
          .collection('bookings')
          .where('restaurantId', isEqualTo: restaurantId)
          .where('bookingDate', isEqualTo: date.millisecondsSinceEpoch)
          .get();

      return querySnapshot.docs
          .map((doc) => BookingModel.fromMap(doc.data()))
          .toList();
    } catch (e) {
      print('Error getting restaurant bookings: $e');
      return [];
    }
  }
}
