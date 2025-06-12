import 'package:flutter/material.dart';
// import 'package:provider/provider.dart'; // Unused import
import '../../../models/restaurant_model.dart';
// import '../../../models/table_model.dart'; // Unused import
// import '../../../providers/restaurant_provider.dart'; // Unused import
import '../../../utils/app_colors.dart';
// import '../booking_screen.dart'; // TODO: implement or update import if file is added

class RestaurantDetailScreen extends StatefulWidget {
  final RestaurantModel restaurant;

  const RestaurantDetailScreen({super.key, required this.restaurant});

  @override
  State<RestaurantDetailScreen> createState() => _RestaurantDetailScreenState();
  }


class _RestaurantDetailScreenState extends State<RestaurantDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250.0,
            floating: false,
            pinned: true,
            backgroundColor: AppColors.primary,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                widget.restaurant.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              background: widget.restaurant.images.isNotEmpty
                  ? Image.network(
                      widget.restaurant.images.first,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      color: AppColors.primary,
                      child: const Icon(
                        Icons.restaurant,
                        size: 80,
                        color: Colors.white,
                      ),
                    ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                // Restaurant info
                Container(
                  padding: const EdgeInsets.all(16),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.restaurant.name,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Icon(Icons.star, color: Colors.amber, size: 20),
                                    const SizedBox(width: 4),
                                    Text(
                                      '${widget.restaurant.rating.toStringAsFixed(1)} (${widget.restaurant.reviewCount} รีวิว)',
                                      style: TextStyle(color: AppColors.textSecondary),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          if (widget.restaurant.isVip)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Text(
                                'VIP',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Icon(Icons.location_on, color: AppColors.textSecondary, size: 16),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              widget.restaurant.address,
                              style: TextStyle(color: AppColors.textSecondary),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.phone, color: AppColors.textSecondary, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            widget.restaurant.phone,
                            style: TextStyle(color: AppColors.textSecondary),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        widget.restaurant.description,
                        style: TextStyle(color: AppColors.text),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                
                // Tabs
                Container(
                  color: Colors.white,
                  child: TabBar(
                    controller: _tabController,
                    labelColor: AppColors.primary,
                    unselectedLabelColor: AppColors.textSecondary,
                    indicatorColor: AppColors.primary,
                    tabs: const [
                      Tab(text: 'เมนู'),
                      Tab(text: 'โต๊ะ'),
                      Tab(text: 'รีวิว'),
                    ],
                  ),
                ),
                SizedBox(
                  height: 400, // กำหนดความสูงให้ TabBarView แสดงผลได้
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      // เมนูอาหาร
                      ListView.builder(
                        itemCount: widget.restaurant.menuItems.length,
                        itemBuilder: (context, index) {
                          final menu = widget.restaurant.menuItems[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                            child: ListTile(
                              leading: menu.image.isNotEmpty
                                  ? Image.network(menu.image, width: 48, height: 48, fit: BoxFit.cover)
                                  : const Icon(Icons.fastfood, size: 40, color: Colors.orange),
                              title: Text(menu.name),
                              subtitle: Text(menu.description),
                              trailing: Text('${menu.price.toStringAsFixed(0)} ฿'),
                            ),
                          );
                        },
                      ),
                      // รายการโต๊ะ
                      ListView.builder(
                        itemCount: widget.restaurant.tables.length,
                        itemBuilder: (context, index) {
                          final table = widget.restaurant.tables[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                            child: ListTile(
                              leading: const Icon(Icons.table_bar, size: 40, color: Colors.blue),
                              title: Text('โต๊ะ ${table.tableNumber}'),
                              subtitle: Text('ความจุ ${table.capacity} คน'),
                              trailing: Text(_tableStatusText(table.status)),
                            ),
                          );
                        },
                      ),
                      // รีวิว (placeholder)
                      const Center(child: Text('ยังไม่มีรีวิว')), // TODO: แสดงรีวิวจริง
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _tableStatusText(status) {
    switch (status.toString()) {
      case 'TableStatus.available':
        return 'ว่าง';
      case 'TableStatus.occupied':
        return 'ไม่ว่าง';
      case 'TableStatus.reserved':
        return 'จองแล้ว';
      case 'TableStatus.maintenance':
        return 'ปิดปรับปรุง';
      default:
        return '';
    }
  }
}