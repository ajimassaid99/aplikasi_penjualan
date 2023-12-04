import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solusi_penjualan_pangan/bloc/logout/logout_bloc.dart';
import 'package:solusi_penjualan_pangan/page/home_penjual.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:solusi_penjualan_pangan/page/pesan_masuk.dart';
import 'package:solusi_penjualan_pangan/page/pesanan.dart';
import 'package:solusi_penjualan_pangan/page/riwayat_pesanan.dart';
import 'package:solusi_penjualan_pangan/page/saran.dart';
import 'package:solusi_penjualan_pangan/page/welcome.dart';

class DashboardPenjualPage extends StatefulWidget {
  const DashboardPenjualPage({super.key});

  @override
  State<DashboardPenjualPage> createState() => _DashboardPenjualPageState();
}

class _DashboardPenjualPageState extends State<DashboardPenjualPage> {
  @override
  Widget build(BuildContext context) {
    PersistentTabController _controller;

    _controller = PersistentTabController(initialIndex: 0);

    return BlocConsumer<LogoutBloc, LogoutState>(
      listener: (context, state) {
        if (state is LogoutError) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Logout Gagal, Silahkan Coba Lagi"),
            ),
          );
        } else if (state is LogoutSucces) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const WelcomePage(),
            ),
            (route) => false,
          );
        }
      },
      builder: (context, state) {
        if (state is LogoutLoading) {
          return Container(
            color: Colors.white,
            child: const Center(child: CircularProgressIndicator()),
          );
        }
        return PersistentTabView(
          context,
          controller: _controller,
          screens: _buildScreens(),
          items: _navBarsItems(),
          confineInSafeArea: true,
          backgroundColor:
              const Color(0xFF22692D), // Default is Color(0xFF22692D).
          handleAndroidBackButtonPress: true, // Default is true.
          resizeToAvoidBottomInset:
              true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
          stateManagement: true, // Default is true.
          hideNavigationBarWhenKeyboardShows:
              true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
          decoration: NavBarDecoration(
            borderRadius: BorderRadius.circular(30.0),
            colorBehindNavBar: const Color(0xFF22692D),
          ),
          popAllScreensOnTapOfSelectedTab: true,
          popActionScreens: PopActionScreensType.all,
          itemAnimationProperties: const ItemAnimationProperties(
            // Navigation Bar's items animation properties.
            duration: Duration(milliseconds: 200),
            curve: Curves.ease,
          ),
          screenTransitionAnimation: const ScreenTransitionAnimation(
            // Screen transition animation on change of selected tab.
            animateTabTransition: true,
            curve: Curves.ease,
            duration: Duration(milliseconds: 200),
          ),
          navBarStyle: NavBarStyle.style1,
        );
      },
    );
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.home),
        title: ("Home"),
        activeColorPrimary: CupertinoColors.white,
        inactiveColorPrimary: CupertinoColors.black,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.compass),
        title: ("Notif"),
        activeColorPrimary: CupertinoColors.white,
        inactiveColorPrimary: CupertinoColors.black,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.document_scanner),
        title: ("Riwayat"),
        activeColorPrimary: CupertinoColors.white,
        inactiveColorPrimary: CupertinoColors.black,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.message),
        title: ("Saran"),
        activeColorPrimary: CupertinoColors.white,
        inactiveColorPrimary: CupertinoColors.black,
      ),
    ];
  }

  List<Widget> _buildScreens() {
    return [
      const HomePenjual(),
      PesananList(),
      PesananMasukNotification(
        jenisPembayaran: 'RP 2000000',
        jumlahPesanan: 2,
        onProses: () {},
      ),
      SaranList()
    ];
  }
}
