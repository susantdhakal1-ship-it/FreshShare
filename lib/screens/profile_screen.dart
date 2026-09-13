import 'package:flutter/material.dart';
import '../navigation/tab_navigator.dart';
import '../theme/app_theme.dart';
import '../widgets/bottom_nav_bar.dart';
import 'impact_screen.dart';
import 'sign_in_screen.dart';
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  static const _brandGreen = Color(0xFF27634F);
  static const _brandGreenLight = Color(0xFFEAF5F0);
  static const _headingDark = Color(0xFF1E232A);
  static const _subText = Color(0xFF9AA0A6);

  bool _notificationsOn = true;

  void _openImpact() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const ImpactScreen()),
    );
  }

  void _logOut() {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Log Out'),
          content: const Text(
            'Are you sure you want to log out?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Close the dialog without logging out.
                Navigator.of(dialogContext).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Close the confirmation dialog first.
                Navigator.of(dialogContext).pop();

                // Clear any saved login or session data here.
                // For example, sign out from Firebase or clear
                // stored authentication information.

                // Go back to the Sign In screen and remove
                // all previous screens from the navigation stack.
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => const SignInScreen(),
                  ),
                      (route) => false,
                );
              },
              child: const Text(
                'Log Out',
                style: TextStyle(
                  color: Color(0xFFF04444),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Profile',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w700,
                  color: _headingDark,
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    _buildOverviewCard(),
                    const SizedBox(height: 20),
                    _buildPreferencesSection(),
                    const SizedBox(height: 20),
                    _buildSupportSection(),
                    const SizedBox(height: 16),
                    _buildLogoutButton(),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
            FreshShareBottomNavBar(
              currentIndex: 3,
              onTap: (i) => navigateToTab(context, i),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: const [
          BoxShadow(
            color: Color(0x08000000),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: const BoxDecoration(
              color: Color(0xFFEE9652),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.person, color: Colors.white, size: 34),
          ),
          const SizedBox(height: 12),
          const Text(
            'Alex Mercer',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w700, color: _headingDark),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
            decoration: BoxDecoration(
              color: _brandGreenLight,
              borderRadius: BorderRadius.circular(AppRadius.pill),
            ),
            child: const Text(
              'RECIPIENT / SHELTER',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.4,
                color: Color(0xFF2F7E5C),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Divider(height: 1, color: Color(0xFFF5F5F4)),
          const SizedBox(height: 14),
          GestureDetector(
            onTap: _openImpact,
            child: Row(
              children: [
                Expanded(
                  child: _StatColumn(value: '24', label: 'Pickups'),
                ),
                Container(width: 1, height: 32, color: const Color(0xFFF5F5F4)),
                Expanded(
                  child: _StatColumn(value: '4.9', label: 'Rating'),
                ),
                Container(width: 1, height: 32, color: const Color(0xFFF5F5F4)),
                Expanded(
                  child: _StatColumn(value: '2025', label: 'Since'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreferencesSection() {
    return _SettingsSection(
      title: 'PREFERENCES',
      children: [
        _SettingsRow(
          icon: Icons.people_outline,
          label: 'Account Details',
          onTap: () {},
        ),
        _SettingsRow(
          icon: Icons.notifications_none,
          label: 'Notification Preferences',
          trailing: Switch.adaptive(
            value: _notificationsOn,
            activeColor: _brandGreen,
            onChanged: (v) => setState(() => _notificationsOn = v),
          ),
        ),
        _SettingsRow(
          icon: Icons.location_on_outlined,
          label: 'Location Settings',
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildSupportSection() {
    return _SettingsSection(
      title: 'SUPPORT & SECURITY',
      children: [
        _SettingsRow(icon: Icons.lock_outline, label: 'Privacy', onTap: () {}),
        _SettingsRow(
          icon: Icons.help_outline,
          label: 'Help & Support',
          onTap: () {},
        ),
        _SettingsRow(
          icon: Icons.info_outline,
          label: 'About FreshShare',
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildLogoutButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _logOut,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFDECEC),
          foregroundColor: const Color(0xFFF04444),
          padding: const EdgeInsets.symmetric(vertical: 14),
          elevation: 0,
          side: const BorderSide(color: Color(0xFFF67C7C)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
        ),
        child: const Text(
          'Log Out',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}

class _StatColumn extends StatelessWidget {
  const _StatColumn({required this.value, required this.label});
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w700,
            color: _ProfileScreenState._brandGreen,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: _ProfileScreenState._subText),
        ),
      ],
    );
  }
}

class _SettingsSection extends StatelessWidget {
  const _SettingsSection({required this.title, required this.children});
  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.6,
              color: Colors.grey.shade600,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: Colors.grey.shade100),
            boxShadow: const [
              BoxShadow(
                color: Color(0x06000000),
                blurRadius: 6,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              for (int i = 0; i < children.length; i++) ...[
                children[i],
                if (i != children.length - 1)
                  const Divider(height: 1, color: Color(0xFFF5F5F4)),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _SettingsRow extends StatelessWidget {
  const _SettingsRow({
    required this.icon,
    required this.label,
    this.onTap,
    this.trailing,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: _ProfileScreenState._brandGreenLight,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon,
                  size: 20, color: _ProfileScreenState._brandGreen),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: _ProfileScreenState._headingDark,
                ),
              ),
            ),
            trailing ??
                Icon(Icons.chevron_right, size: 18, color: Colors.grey.shade400),
          ],
        ),
      ),
    );
  }
}
