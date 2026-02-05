import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:handcode_test/core/constants/colors.dart';
import 'package:handcode_test/core/routes/route_names.dart';
import 'package:handcode_test/core/services/auth_service.dart';
import 'package:handcode_test/presentation/widgets/account_option_tile.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "My Account",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),

              _buildProfileHeader(),

              const SizedBox(height: 25),

              _buildWalletCard(),

              const SizedBox(height: 25),

              AccountOptionTile(
                icon: Icons.contact_page_rounded,
                title: "Edit Profile",
                onTap: () {},
              ),
              AccountOptionTile(
                icon: Icons.location_on,
                title: "Saved Address",
                onTap: () {},
              ),
              AccountOptionTile(
                icon: Icons.description,
                title: "Terms & Conditions",
                onTap: () {},
              ),
              AccountOptionTile(
                icon: Icons.privacy_tip,
                title: "Privacy Policy",
                onTap: () {},
              ),
              AccountOptionTile(
                icon: Icons.people_alt,
                title: "Refer a friend",
                onTap: () {},
              ),
              AccountOptionTile(
                icon: Icons.phone,
                title: "Customer Support",
                onTap: () {},
              ),
              AccountOptionTile(
                icon: Icons.logout,
                title: "Log Out",
                onTap: () {
                  showLogoutDialog(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Row(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: AppColors.avatarGreen,
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.center,
          child: const Text(
            "FE",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Fathima Ebrahim",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              "+91 908 786 4233",
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildWalletCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.lightMintBg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Wallet",
            style: TextStyle(
              color: AppColors.avatarGreen,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              "Balance - 125",
              style: TextStyle(
                color: AppColors.avatarGreen,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> showLogoutDialog(BuildContext context) async {
    final authService = AuthService();

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          backgroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.logout, size: 48, color: Colors.red),
                const SizedBox(height: 16),
                const Text(
                  "Logout?",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Are you sure you want to log out of your account?",
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Cancel"),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        onPressed: () async {
                          await authService.signOut();
                          if (!context.mounted) return;
                          Navigator.pop(context);
                          context.go(RouteNames.login);
                        },
                        child: const Text(
                          "Logout",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
