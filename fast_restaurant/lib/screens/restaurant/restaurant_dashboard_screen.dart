import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

class RestaurantDashboardScreen extends StatelessWidget {
  const RestaurantDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Replace with real restaurant data and logic
    return Scaffold(
      appBar: AppBar(
        title: const Text('แดชบอร์ดร้านอาหาร'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.store, size: 80, color: Colors.deepOrange),
            const SizedBox(height: 20),
            const Text(
              'แดชบอร์ดร้านอาหาร',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'ฟีเจอร์สำหรับเจ้าของร้าน/พนักงาน',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              icon: const Icon(Icons.list),
              label: const Text('ดูรายการจอง'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                // TODO: Navigate to booking list screen
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('ยังไม่เปิดใช้งานฟีเจอร์นี้')),
                );
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.restaurant_menu),
              label: const Text('จัดการเมนูอาหาร'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                // TODO: Navigate to menu management screen
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('ยังไม่เปิดใช้งานฟีเจอร์นี้')),
                );
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.table_bar),
              label: const Text('จัดการโต๊ะ'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                // TODO: Navigate to table management screen
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('ยังไม่เปิดใช้งานฟีเจอร์นี้')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
