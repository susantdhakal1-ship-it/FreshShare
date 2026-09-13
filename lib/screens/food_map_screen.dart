import 'package:flutter/material.dart';
import '../models/food_listing.dart';
import '../navigation/tab_navigator.dart';
import '../theme/app_theme.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/stylized_map_background.dart';
import 'item_detail_screen.dart';

class FoodMapScreen extends StatefulWidget {
  const FoodMapScreen({super.key});

  @override
  State<FoodMapScreen> createState() => _FoodMapScreenState();
}

class _FoodMapScreenState extends State<FoodMapScreen> {
  String _activeCategory = 'All';
  final _categories = const ['All', 'Cafés', 'Groceries', 'Bakeries'];

  final _pins = const [
    MapPinData(
      id: 'veggie-box',
      dx: 0.18,
      dy: 0.18,
      color: AppColors.mapGreen,
      icon: Icons.eco,
    ),
    MapPinData(
      id: 'bakery-pack',
      dx: 0.32,
      dy: 0.48,
      color: AppColors.accentOrange,
      icon: Icons.bakery_dining,
    ),
    MapPinData(
      id: 'apple-stand',
      dx: 0.5,
      dy: 0.32,
      color: AppColors.accentOrange,
      icon: Icons.apple,
    ),
    MapPinData(
      id: 'grocery-store',
      dx: 0.62,
      dy: 0.5,
      color: AppColors.mapGreen,
      icon: Icons.storefront,
    ),
  ];

  List<FoodListing> get _filteredListings {
    if (_activeCategory == 'All') return sampleListings;
    return sampleListings
        .where((l) => l.category == _activeCategory)
        .toList();
  }

  void _openDetail(FoodListing listing) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => ItemDetailScreen(listing: listing)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mapCream,
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  child: StylizedMapBackground(
                    pins: _pins,
                    onPinTap: (pin) {
                      final match = sampleListings
                          .where((l) => l.id == pin.id)
                          .toList();
                      if (match.isNotEmpty) _openDetail(match.first);
                    },
                  ),
                ),
                SafeArea(
                  bottom: false,
                  child: _buildTopControls(),
                ),
              ],
            ),
          ),
          _buildBottomSheet(),
          FreshShareBottomNavBar(
            currentIndex: 0,
            onTap: (i) => navigateToTab(context, i),
          ),
        ],
      ),
    );
  }

  Widget _buildTopControls() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(AppRadius.pill),
              border: Border.all(color: Colors.grey.shade100),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x0F000000),
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(Icons.search, color: Colors.grey.shade700, size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(vertical: 12),
                      hintText: 'Search surplus food near you...',
                      hintStyle: TextStyle(
                        color: Colors.grey.shade400,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                Icon(Icons.tune, color: Colors.grey.shade700, size: 20),
              ],
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 38,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _categories.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, i) {
                final cat = _categories[i];
                final selected = cat == _activeCategory;
                return GestureDetector(
                  onTap: () => setState(() => _activeCategory = cat),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    decoration: BoxDecoration(
                      color: selected ? AppColors.mapGreen : Colors.white,
                      borderRadius: BorderRadius.circular(AppRadius.pill),
                      border: selected
                          ? null
                          : Border.all(color: Colors.grey.shade200),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      cat,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight:
                            selected ? FontWeight.w600 : FontWeight.w500,
                        color: selected ? Colors.white : Colors.grey.shade700,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSheet() {
    return Container(
      color: AppColors.mapCream,
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Surplus Food Nearby', style: AppTextStyles.sectionTitle),
                Text('List View', style: AppTextStyles.link),
              ],
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 112,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: _filteredListings.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, i) {
                return _ListingCard(
                  listing: _filteredListings[i],
                  onTap: () => _openDetail(_filteredListings[i]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ListingCard extends StatelessWidget {
  const _ListingCard({required this.listing, required this.onTap});

  final FoodListing listing;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 290,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(color: Colors.grey.shade100),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0A000000),
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                listing.imageUrl,
                width: 88,
                height: 88,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: 88,
                  height: 88,
                  color: Colors.grey.shade200,
                  child: const Icon(Icons.image_not_supported_outlined),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: listing.badgeColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          listing.badgeLabel,
                          style: AppTextStyles.badge.copyWith(
                            color: listing.badgeTextColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(listing.vendorName,
                          style: AppTextStyles.cardSubtitle,
                          overflow: TextOverflow.ellipsis),
                      Text(
                        listing.title,
                        style: AppTextStyles.cardTitle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.location_on,
                              size: 13, color: AppColors.mapGreen),
                          const SizedBox(width: 4),
                          Text('${listing.distanceMiles} miles',
                              style: AppTextStyles.metaText),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          const Icon(Icons.access_time,
                              size: 13, color: AppColors.accentOrange),
                          const SizedBox(width: 4),
                          Text(listing.pickupWindow,
                              style: AppTextStyles.metaText),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
