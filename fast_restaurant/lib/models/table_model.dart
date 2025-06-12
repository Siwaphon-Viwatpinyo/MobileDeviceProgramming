enum TableStatus { available, occupied, reserved, maintenance }

class TableModel {
  final String id;
  final String tableNumber;
  final int capacity;
  final TableStatus status;
  final String location;
  final Map<String, dynamic> features;
  final DateTime? reservedUntil;

  TableModel({
    required this.id,
    required this.tableNumber,
    required this.capacity,
    this.status = TableStatus.available,
    this.location = '',
    this.features = const {},
    this.reservedUntil,
  });

  factory TableModel.fromMap(Map<String, dynamic> map) {
    return TableModel(
      id: map['id'] ?? '',
      tableNumber: map['tableNumber'] ?? '',
      capacity: map['capacity'] ?? 2,
      status: TableStatus.values[map['status'] ?? 0],
      location: map['location'] ?? '',
      features: Map<String, dynamic>.from(map['features'] ?? {}),
      reservedUntil: map['reservedUntil'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['reservedUntil'])
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'tableNumber': tableNumber,
      'capacity': capacity,
      'status': status.index,
      'location': location,
      'features': features,
      'reservedUntil': reservedUntil?.millisecondsSinceEpoch,
    };
  }
}