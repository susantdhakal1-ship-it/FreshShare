import 'package:flutter/material.dart';

/// Placeholder data model. Swap this out for whatever your backend
/// returns (Firestore doc, REST payload, etc).
class FoodListing {
  const FoodListing({
    required this.id,
    required this.title,
    required this.vendorName,
    required this.badgeLabel,
    required this.badgeColor,
    required this.badgeTextColor,
    required this.imageUrl,
    required this.distanceMiles,
    required this.pickupWindow,
    required this.category,
    this.freshnessScore,
    this.quantityLabel,
    this.freshnessState,
    this.address,
    this.description,
  });

  final String id;
  final String title;
  final String vendorName;
  final String badgeLabel;
  final Color badgeColor;
  final Color badgeTextColor;
  final String imageUrl;
  final double distanceMiles;
  final String pickupWindow;
  final String category;
  final int? freshnessScore;
  final String? quantityLabel;
  final String? freshnessState;
  final String? address;
  final String? description;
}

/// Sample data mirroring the HTML mockups, so the UI renders without
/// a backend wired up yet. Replace with a real data source later.
final List<FoodListing> sampleListings = [
  FoodListing(
    id: 'veggie-box',
    title: 'Assorted Organic Veggie Box',
    vendorName: 'Green Grove Grocery',
    badgeLabel: 'SUPER FRESH',
    badgeColor: const Color(0xFFE2F7EB),
    badgeTextColor: const Color(0xFF237B52),
    imageUrl:
        'https://images.unsplash.com/photo-1540420773420-3366772f4999?w=400',
    distanceMiles: 0.4,
    pickupWindow: 'Pickup 5:00 – 6:30 PM',
    category: 'Groceries',
  ),
  FoodListing(
    id: 'bakery-pack',
    title: 'Surplus Pastries & Sourdough',
    vendorName: 'Golden Hearth Bakery',
    badgeLabel: 'BAKERY',
    badgeColor: const Color(0xFFFFEDD5),
    badgeTextColor: const Color(0xFFC2410C),
    imageUrl:
        'https://images.unsplash.com/photo-1509440159596-0249088772ff?w=400',
    distanceMiles: 0.7,
    pickupWindow: 'Pickup 6:00 – 7:30 PM',
    category: 'Bakeries',
    freshnessScore: 92,
    quantityLabel: '3 packs available',
    freshnessState: 'Excellent',
    address: '154 Spruce St, 1.2 miles away',
    description:
        'A delicious combination of croissants, cinnamon rolls, and one '
        'fresh boule of rustic sourdough bread baked fresh this morning. '
        'All delicious and perfectly safe to consume!',
  ),
];
