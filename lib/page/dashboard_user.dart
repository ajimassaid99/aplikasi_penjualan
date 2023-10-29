import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solusi_penjualan_pangan/bloc/logout/logout_bloc.dart';
import 'package:solusi_penjualan_pangan/page/welcome.dart';

class DashboardUserPage extends StatefulWidget {
  const DashboardUserPage({Key? key}) : super(key: key);

  @override
  State<DashboardUserPage> createState() => _DashboardUserPageState();
}

class _DashboardUserPageState extends State<DashboardUserPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
        return Scaffold(
          appBar: AppBar(
            title: const Text("Dashboard User"),
          ),
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  // Your dashboard content here

                  // Add a Logout button
                  ElevatedButton(
                    onPressed: () {
                      context.read<LogoutBloc>().add(const LogoutEvent());
                    },
                    child: const Text("Logout"),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
