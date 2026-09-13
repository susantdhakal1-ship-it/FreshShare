import 'package:flutter/material.dart';
import '../models/food_listing.dart';
import '../navigation/tab_navigator.dart';
import '../theme/app_theme.dart';
import '../widgets/bottom_nav_bar.dart';
import '../models/reservation.dart';
import 'pickup_confirmation_screen.dart';
class ItemDetailScreen extends StatelessWidget {
  const ItemDetailScreen({super.key, required this.listing});

  final FoodListing listing;

  void _reserve(BuildContext context) {
  final reservation = Reservation(
    id: 'res-${DateTime.now().millisecondsSinceEpoch}',
    vendorName: listing.vendorName,
    itemTitle: listing.title,
    timeWindow: listing.pickupWindow,
    status: ReservationStatus.confirmed,
    imageUrl: listing.imageUrl,
    isUpcoming: true,
  );

  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (_) => PickupConfirmationScreen(
        reservation: reservation,
      ),
    ),
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHero(context),
                  Transform.translate(
                    offset: const Offset(0, -16),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(24)),
                      ),
                      padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
                      child: _buildContent(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          FreshShareBottomNavBar(
            currentIndex: 0,
            onTap: (i) => navigateToTab(context, i),
          ),
        ],
      ),
    );
  }

  Widget _buildHero(BuildContext context) {
    return Stack(
      children: [
        AspectRatio(
          aspectRatio: 4 / 3,
          child: Image.network(
            listing.imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              color: Colors.grey.shade200,
              child: const Icon(Icons.image_not_supported_outlined, size: 40),
            ),
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _HeroIconButton(
                  icon: Icons.arrow_back,
                  onTap: () => Navigator.of(context).maybePop(),
                ),
                _HeroIconButton(icon: Icons.share_outlined, onTap: () {}),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _Badge(label: listing.category.toUpperCase()),
            if (listing.freshnessScore != null) ...[
              const SizedBox(width: 8),
              _Badge(label: '${listing.freshnessScore}% FRESHNESS SCORE'),
            ],
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Text(listing.vendorName,
                style: AppTextStyles.cardSubtitle.copyWith(fontSize: 13.5)),
            const SizedBox(width: 6),
            const Icon(Icons.verified, size: 16, color: AppColors.textGreen),
          ],
        ),
        const SizedBox(height: 8),
        Text(listing.title, style: AppTextStyles.h1),
        const SizedBox(height: 16),
        const Divider(height: 1, color: Color(0xFFE5E7EB)),
        const SizedBox(height: 20),
        if (listing.quantityLabel != null || listing.freshnessState != null)
          Row(
            children: [
              if (listing.quantityLabel != null)
                Expanded(
                  child: _InfoCard(
                    label: 'QUANTITY LEFT',
                    child: Text(listing.quantityLabel!,
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF064E3B))),
                  ),
                ),
              if (listing.quantityLabel != null && listing.freshnessState != null)
                const SizedBox(width: 12),
              if (listing.freshnessState != null)
                Expanded(
                  child: _InfoCard(
                    label: 'FRESHNESS STATE',
                    child: Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Color(0xFF059669),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(listing.freshnessState!,
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF064E3B))),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        const SizedBox(height: 24),
        _DetailRow(
          icon: Icons.access_time,
          iconBg: const Color(0xFFFFF7ED),
          iconColor: const Color(0xFFFB923C),
          title: 'Pickup Window',
          subtitle: listing.pickupWindow,
        ),
        const SizedBox(height: 16),
        _DetailRow(
          icon: Icons.location_on_outlined,
          iconBg: const Color(0xFFECFDF5),
          iconColor: AppColors.textGreen,
          title: listing.vendorName,
          subtitle: listing.address ?? '',
        ),
        if (listing.description != null) ...[
          const SizedBox(height: 24),
          Text("What's in the pack?", style: AppTextStyles.sectionTitle),
          const SizedBox(height: 8),
          Text(listing.description!, style: AppTextStyles.body),
        ],
        const SizedBox(height: 24),
        Builder(builder: (context) {
          return SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => _reserve(context),
              icon: const Icon(Icons.calendar_today, size: 18),
              label: Text('Reserve Pickup', style: AppTextStyles.button),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.darkGreen,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                elevation: 0,
              ),
            ),
          );
        }),
      ],
    );
  }
}

class _HeroIconButton extends StatelessWidget {
  const _HeroIconButton({required this.icon, required this.onTap});
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          shape: BoxShape.circle,
          boxShadow: const [
            BoxShadow(
              color: Color(0x33000000),
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Icon(icon, size: 20, color: const Color(0xFF262626)),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.detailBadgeBg,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.4,
          color: Color(0xFF065F46),
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.label, required this.child});
  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.detailCardBg,
        border: Border.all(color: AppColors.detailCardBorder),
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppTextStyles.label),
          const SizedBox(height: 4),
          child,
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: iconBg,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, size: 20, color: iconColor),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textDark)),
              const SizedBox(height: 2),
              Text(subtitle,
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade500)),
            ],
          ),
        ),
      ],
    );
  }
}
