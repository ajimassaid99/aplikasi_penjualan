import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solusi_penjualan_pangan/bloc/logout/logout_bloc.dart';

class DashboardPenjualPage extends StatefulWidget {
  const DashboardPenjualPage({super.key});

  @override
  State<DashboardPenjualPage> createState() => _DashboardPenjualPageState();
}

class _DashboardPenjualPageState extends State<DashboardPenjualPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LogoutBloc, LogoutState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        return const Scaffold(
          body: SingleChildScrollView(
            child: Center(child: Text("DashBoard Penjual")),
          ),
        );
      },
    );
  }
}
