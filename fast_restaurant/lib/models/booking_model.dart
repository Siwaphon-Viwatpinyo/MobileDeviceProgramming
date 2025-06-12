enum BookingStatus { pending, confirmed, cancelled, completed, noShow }

class BookingModel {
  final String id;
  final String userId;
  final String restaurantId;
  final String tableId;
  final DateTime bookingDate;
  final DateTime bookingTime;
  final int partySize;
  final String specialRequests;
  final BookingStatus status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? cancellationReason;

  BookingModel({
    required this.id,
    required this.userId,
    required this.restaurantId,
    required this.tableId,
    required this.bookingDate,
    required this.bookingTime,
    required this.partySize,
    this.specialRequests = '',
    this.status = BookingStatus.pending,
    required this.createdAt,
    required this.updatedAt,
    this.cancellationReason,
  });

  factory BookingModel.fromMap(Map<String, dynamic> map) {
    return BookingModel(
      id: map['id'] ?? '',
      userId: map['userId'] ?? '',
      restaurantId: map['restaurantId'] ?? '',
      tableId: map['tableId'] ?? '',
      bookingDate: DateTime.fromMillisecondsSinceEpoch(map['bookingDate'] ?? 0),
      bookingTime: DateTime.fromMillisecondsSinceEpoch(map['bookingTime'] ?? 0),
      partySize: map['partySize'] ?? 1,
      specialRequests: map['specialRequests'] ?? '',
      status: BookingStatus.values[map['status'] ?? 0],
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] ?? 0),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] ?? 0),
      cancellationReason: map['cancellationReason'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'restaurantId': restaurantId,
      'tableId': tableId,
      'bookingDate': bookingDate.millisecondsSinceEpoch,
      'bookingTime': bookingTime.millisecondsSinceEpoch,
      'partySize': partySize,
      'specialRequests': specialRequests,
      'status': status.index,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
      'cancellationReason': cancellationReason,
    };
  }

  bool canCancel() {
    final now = DateTime.now();
    final timeDifference = bookingTime.difference(now);
    return timeDifference.inHours >= 3 && status == BookingStatus.confirmed;
  }
}
