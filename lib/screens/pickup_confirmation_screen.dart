import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../models/reservation.dart';
import '../navigation/tab_navigator.dart';
import '../theme/app_theme.dart';
import '../widgets/bottom_nav_bar.dart';

class PickupConfirmationScreen extends StatelessWidget {
  const PickupConfirmationScreen({
    super.key,
    required this.reservation,
    this.confirmationCode = 'FSH-482901',
  });

  final Reservation reservation;
  final String confirmationCode;

  static const _brandGreen = Color(0xFF1E6B4B);

  void _copyCode(BuildContext context) {
    Clipboard.setData(ClipboardData(text: confirmationCode));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Confirmation code copied')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F6EB),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 4),
                    _buildStatusBanner(),
                    const SizedBox(height: 16),
                    _buildDetailsCard(context),
                    const SizedBox(height: 16),
                    _buildInstructionBox(),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
            FreshShareBottomNavBar(
              currentIndex: 1,
              onTap: (i) => navigateToTab(context, i),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
  return SizedBox(
    height: 56,
    child: Row(
      children: [
        const SizedBox(width: 16),
        GestureDetector(
          onTap: () => Navigator.of(context).maybePop(),
          child: Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Color(0x14000000),
                  blurRadius: 4,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: const Icon(
              Icons.arrow_back,
              size: 20,
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              'Pickup Confirmation',
              style: AppTextStyles.h1.copyWith(fontSize: 19),
            ),
          ),
        ),
        // Same width as the back button so the title stays centered.
        const SizedBox(width: 56),
      ],
    ),
  );
}


  Widget _buildStatusBanner() {
    final isConfirmed = reservation.status == ReservationStatus.confirmed;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFE4EFE3),
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      child: Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: const BoxDecoration(
              color: Color(0xFF1A7747),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            isConfirmed ? 'Ready for Pickup' : 'Awaiting Confirmation',
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1A7747),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: Color(0x08000000),
            blurRadius: 12,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            reservation.vendorName,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: _brandGreen,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            reservation.itemTitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1F2937),
              height: 1.25,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            reservation.timeWindow,
            style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
          ),
          const SizedBox(height: 20),
          const Divider(height: 1, color: Color(0xFFF3F4F6)),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF8F5EC),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: QrImageView(
                data: confirmationCode,
                size: 144,
                backgroundColor: Colors.white,
                eyeStyle: const QrEyeStyle(
                  eyeShape: QrEyeShape.square,
                  color: Colors.black,
                ),
                dataModuleStyle: const QrDataModuleStyle(
                  dataModuleShape: QrDataModuleShape.square,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'CONFIRMATION CODE',
            style: AppTextStyles.label.copyWith(
              color: Colors.grey.shade400,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () => _copyCode(context),
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF8D6),
                borderRadius: BorderRadius.circular(AppRadius.sm),
                border: Border.all(color: const Color(0xFFF5E6A3)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    confirmationCode,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.copy_outlined,
                      size: 20, color: _brandGreen),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInstructionBox() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.7),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 2),
            child: Icon(Icons.info_outline, size: 20, color: _brandGreen),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Show this to the donor at pickup. They will scan the QR '
              'code or verify the code to complete the request.',
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade600,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
