import 'package:flutter/material.dart';
import 'package:pixelarticons/pixel.dart';
import 'package:provider/provider.dart';
import 'package:ryc_desafio_do_modulo_basico/components/main_app_bar.dart';
import 'package:ryc_desafio_do_modulo_basico/providers/player_stats_provider.dart';
import 'package:ryc_desafio_do_modulo_basico/screens/shop_screen.dart';
import 'package:ryc_desafio_do_modulo_basico/screens/task_list_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  static final List<Widget> _tabViews = [
    const TaskListScreen(),
    const ShopScreen(),
  ];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      initialIndex: 0,
      vsync: this,
    );
    context.read<PlayerStatsProvider>().loadStats();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: TabBarView(
          controller: _tabController,
          children: _tabViews,
        ),
      ),
      bottomNavigationBar: TabBar(
        controller: _tabController,
        tabs: const [
          Tab(
            icon: Icon(
              Pixel.notesmultiple,
              size: 30,
            ),
            text: 'Tasks',
          ),
          Tab(
            icon: Icon(
              Pixel.coin,
              size: 30,
            ),
            text: 'Shop',
          )
        ],
      ),
    );
  }
}
