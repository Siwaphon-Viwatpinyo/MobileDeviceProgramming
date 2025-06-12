import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/restaurant_provider.dart';
import '../../utils/app_colors.dart';
// import '../../widgets/restaurant_card.dart'; // TODO: implement or update import if file is added
import 'restaurant_detail_screen.dart';
// import 'my_bookings_screen.dart'; // TODO: implement or update import if file is added
import '../auth/login_screen.dart';

class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen({super.key});

  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  final _searchController = TextEditingController();
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<RestaurantProvider>(context, listen: false).loadRestaurants();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onSearch(String query) {
    Provider.of<RestaurantProvider>(context, listen: false).searchRestaurants(query);
  }

  Future<void> _signOut() async {
    await Provider.of<AuthProvider>(context, listen: false).signOut();
    if (mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const LoginScreen()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      _buildHomeTab(),
      // TODO: Implement MyBookingsScreen or update import if file is added
      Center(child: Text('ยังไม่มีหน้าการจองของฉัน')),
      _buildProfileTab(),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Restaurant Queue'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'หน้าหลัก',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'การจองของฉัน',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'โปรไฟล์',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.primary,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildHomeTab() {
    return Consumer<RestaurantProvider>(
      builder: (context, restaurantProvider, _) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Search bar
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'ค้นหาร้านอาหารหรือเมนู...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: AppColors.surface,
                ),
                onChanged: _onSearch,
              ),
              const SizedBox(height: 20),
              
              // Restaurant list
              Expanded(
                child: restaurantProvider.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : _searchController.text.isNotEmpty
                        ? _buildSearchResults(restaurantProvider.searchResults)
                        : _buildRestaurantList(restaurantProvider.restaurants),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSearchResults(List restaurants) {
    if (restaurants.isEmpty) {
      return const Center(
        child: Text('ไม่พบผลการค้นหา'),
      );
    }

    return ListView.builder(
      itemCount: restaurants.length,
      itemBuilder: (context, index) {
        final restaurant = restaurants[index];
        // TODO: Implement RestaurantCard widget or update import if file is added
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            leading: const Icon(Icons.restaurant, color: Colors.deepOrange),
            title: Text(restaurant.name ?? 'ไม่ทราบชื่อร้าน'),
            subtitle: Text(restaurant.address ?? ''),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => RestaurantDetailScreen(restaurant: restaurant),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildRestaurantList(List restaurants) {
    if (restaurants.isEmpty) {
      return const Center(
        child: Text('ไม่มีร้านอาหารในขณะนี้'),
      );
    }

    return ListView.builder(
      itemCount: restaurants.length,
      itemBuilder: (context, index) {
        final restaurant = restaurants[index];
        // TODO: Implement RestaurantCard widget or update import if file is added
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            leading: const Icon(Icons.restaurant, color: Colors.deepOrange),
            title: Text(restaurant.name ?? 'ไม่ทราบชื่อร้าน'),
            subtitle: Text(restaurant.address ?? ''),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => RestaurantDetailScreen(restaurant: restaurant),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildProfileTab() {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, _) {
        final user = authProvider.userModel;
        
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: AppColors.primary,
                            child: Text(
                              user?.name.substring(0, 1).toUpperCase() ?? 'U',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user?.name ?? 'ผู้ใช้',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  user?.email ?? '',
                                  style: TextStyle(
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                                Text(
                                  user?.phone ?? '',
                                  style: TextStyle(
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              
              ListTile(
                leading: Icon(Icons.settings, color: AppColors.primary),
                title: const Text('ตั้งค่า'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Navigate to settings
                },
              ),
              
              ListTile(
                leading: Icon(Icons.help_outline, color: AppColors.primary),
                title: const Text('ช่วยเหลือ'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Navigate to help
                },
              ),
              
              ListTile(
                leading: Icon(Icons.logout, color: AppColors.error),
                title: const Text('ออกจากระบบ'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: _signOut,
              ),
            ],
          ),
        );
      },
    );
  }
}