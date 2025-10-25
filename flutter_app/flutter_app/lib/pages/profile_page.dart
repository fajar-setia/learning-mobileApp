import 'package:flutter/material.dart';
import 'package:flutter_app/feature/import_features.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.pink,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 28),
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          'Profile',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          height: 150,
                          width: 150,
                          margin: EdgeInsets.only(bottom: 12.0, top: 12),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(AppFeaturesImage.logo),
                              fit: BoxFit.cover,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white.withValues(alpha: .2),
                                blurRadius: 15,
                                offset: Offset(0, 3),
                              ),
                            ],
                            border: Border.all(
                              color: Colors.purple.withValues(alpha: .2),
                            ),
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.white.withValues(alpha: .1),
                          ),
                        ),
                        Text(
                          'Fajar Setia Pambudi',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),

                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(top: 2),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: .2),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white.withValues(alpha: .2),
                                blurRadius: 12,
                                offset: Offset(0, 5),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              _buildProfileItem(
                                icon: Icons.edit,
                                title: 'Edit Profile',
                                onTap: () {
                                  print('icon edit di klik');
                                },
                              ),
                              _buildProfileItem(
                                icon: Icons.history,
                                title: 'Riwayat Pesanan',
                                onTap: () {
                                  // Arahkan ke halaman riwayat
                                  print("Riwayat Pesanan diklik");
                                },
                              ),
                              _buildProfileItem(
                                icon: Icons.settings,
                                title: 'Pengaturan Akun',
                                onTap: () {
                                  // Arahkan ke pengaturan akun
                                  print("Pengaturan Akun diklik");
                                },
                              ),
                              _buildProfileItem(
                                icon: Icons.logout,
                                title: 'Logout',
                                color: Colors.red,
                                onTap: () {
                                  // Fungsi logout di sini
                                  print("Logout diklik");
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileItem({
    required IconData icon,
    required String title,
    Color color = Colors.black,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          color: color,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}
