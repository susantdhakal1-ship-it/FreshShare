import 'package:flutter/material.dart';

enum ReservationStatus { confirmed, pendingApproval, completed }

extension ReservationStatusX on ReservationStatus {
  String get label {
    switch (this) {
      case ReservationStatus.confirmed:
        return 'CONFIRMED';
      case ReservationStatus.pendingApproval:
        return 'PENDING APPROVAL';
      case ReservationStatus.completed:
        return 'COMPLETED';
    }
  }

  Color get bg {
    switch (this) {
      case ReservationStatus.confirmed:
      case ReservationStatus.completed:
        return const Color(0xFFE7F6EC);
      case ReservationStatus.pendingApproval:
        return const Color(0xFFFFF3E5);
    }
  }

  Color get textColor {
    switch (this) {
      case ReservationStatus.confirmed:
      case ReservationStatus.completed:
        return const Color(0xFF237048);
      case ReservationStatus.pendingApproval:
        return const Color(0xFFD37827);
    }
  }
}

class Reservation {
  const Reservation({
    required this.id,
    required this.vendorName,
    required this.itemTitle,
    required this.timeWindow,
    required this.status,
    required this.imageUrl,
    required this.isUpcoming,
  });

  final String id;
  final String vendorName;
  final String itemTitle;
  final String timeWindow;
  final ReservationStatus status;
  final String imageUrl;

  /// true = shows under "Upcoming" tab, false = "Past Pickups"
  final bool isUpcoming;
}

final List<Reservation> sampleReservations = [
  Reservation(
    id: 'res-1',
    vendorName: 'The Daily Crust Bakeries',
    itemTitle: 'Artisan Surplus Pastry & Sourdough',
    timeWindow: 'Today, 4:00 – 5:30 PM',
    status: ReservationStatus.confirmed,
    imageUrl:
        'https://images.unsplash.com/photo-1509440159596-0249088772ff?w=200',
    isUpcoming: true,
  ),
  Reservation(
    id: 'res-2',
    vendorName: 'Green Grove Grocery',
    itemTitle: 'Fresh Grocery Veggie & Fruit Overflow',
    timeWindow: 'Today, 5:00 – 6:30 PM',
    status: ReservationStatus.pendingApproval,
    imageUrl:
        'https://images.unsplash.com/photo-1540420773420-3366772f4999?w=200',
    isUpcoming: true,
  ),
  Reservation(
    id: 'res-3',
    vendorName: 'Corner Deli & Cafe',
    itemTitle: 'Gourmet Deli Roasted Sandwiches',
    timeWindow: 'Tomorrow, 11:30 AM – 1:00 PM',
    status: ReservationStatus.completed,
    imageUrl:
        'https://images.unsplash.com/photo-1481070555726-e2fe8357725c?w=200',
    isUpcoming: false,
  ),
];
