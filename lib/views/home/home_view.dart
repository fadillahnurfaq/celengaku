import 'package:celenganku/models/home_view_tab_model.dart';
import 'package:celenganku/views/achieved/achieved_view.dart';
import 'package:celenganku/views/home/widgets/change_theme_dialog.dart';
import 'package:celenganku/views/ongoing/ongoing_view.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _views.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  final List<HomeViewTabModel> _views = [
    const HomeViewTabModel(
      tab: Tab(
        text: "Berlangsung",
      ),
      view: OngoingView(),
    ),
    const HomeViewTabModel(
      tab: Tab(
        text: "Tercapai",
      ),
      view: AchievedView(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Celenganku"),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return showChangeThemeDialog(context);
                },
              );
            },
            icon: const Icon(Icons.brightness_medium),
          ),
          PopupMenuButton(
            itemBuilder: (ctx) => [
              PopupMenuItem(
                onTap: () {},
                child: const Text("Beri Nilai Aplikasi"),
              )
            ],
          )
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: _views.map((e) => e.tab).toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _views.map((e) => e.view).toList(),
      ),
    );
  }
}
