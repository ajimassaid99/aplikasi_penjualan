import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solusi_penjualan_pangan/bloc/keranjang/keranjang_bloc.dart';
import 'package:solusi_penjualan_pangan/bloc/login/login_bloc.dart';
import 'package:solusi_penjualan_pangan/bloc/logout/logout_bloc.dart';
import 'package:solusi_penjualan_pangan/bloc/lupa_Password/lupa_password_bloc.dart';
import 'package:solusi_penjualan_pangan/bloc/register/sing_up_bloc.dart';
import 'package:solusi_penjualan_pangan/bloc/riwayat/riwayat_bloc.dart';
import 'package:solusi_penjualan_pangan/bloc/saran/saran_bloc.dart';
import 'package:solusi_penjualan_pangan/bloc/store/store_bloc.dart';
import 'package:solusi_penjualan_pangan/bloc/store_detail/store_detail_bloc.dart';
import 'package:solusi_penjualan_pangan/bloc/tambah_product/tambah_produk_bloc.dart';
import 'package:solusi_penjualan_pangan/page/welcome.dart'; // Import your 'PenjualPage'
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://wcyjnrugrqrufpapzeli.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6IndjeWpucnVncnFydWZwYXB6ZWxpIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTg0MTgxNzYsImV4cCI6MjAxMzk5NDE3Nn0.rd6w2CU-DU1-czlGbq8SHZnDN03kcN8qockvSk2EJ7E',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<SingUpBloc>(
            create: (context) => SingUpBloc(),
          ),
          BlocProvider<SaranBloc>(
            create: (context) => SaranBloc(),
          ),
          BlocProvider<RiwayatBloc>(
            create: (context) => RiwayatBloc(),
          ),
          BlocProvider<KeranjangBloc>(
            create: (context) => KeranjangBloc(),
          ),
          BlocProvider<StoreBloc>(
            create: (context) => StoreBloc(),
          ),
          BlocProvider<StoreDetailBloc>(
            create: (context) => StoreDetailBloc(),
          ),
          BlocProvider<LoginBloc>(
            create: (context) => LoginBloc(), 
          ),
          BlocProvider<LupaPasswordBloc>(
            create: (context) => LupaPasswordBloc(),
          ),
          BlocProvider<LogoutBloc>(
            create: (context) => LogoutBloc(),
          ),
          BlocProvider<TambahProdukBloc>(
            create: (context) => TambahProdukBloc(),
          ),
        ],
        child: MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: WelcomePage()));
  }
}
