import 'package:flutter/material.dart';
import '../screens/food_map_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/reservations_screen.dart';
import '../screens/scanner_screen.dart';

/// Index mapping used by [FreshShareBottomNavBar] across every screen:
/// 0 = Map, 1 = Reservations, 2 = Scan, 3 = Profile.
///
/// Uses `pushReplacement` so switching tabs doesn't pile up an
/// ever-growing stack of tab screens. Detail screens (item detail, scan
/// results) should still use a normal `push` so the back button returns
/// to the tab the user came from.
void navigateToTab(BuildContext context, int index) {
  late final Widget screen;
  switch (index) {
    case 0:
      screen = const FoodMapScreen();
      break;
    case 1:
      screen = const ReservationsScreen();
      break;
    case 2:
      screen = const ScannerScreen();
      break;
    case 3:
    default:
      screen = const ProfileScreen();
      break;
  }
  Navigator.of(context).pushReplacement(
    MaterialPageRoute(builder: (_) => screen),
  );
}
