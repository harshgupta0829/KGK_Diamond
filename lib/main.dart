import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kgk_diamonds/bloc/cart_bloc.dart';
import 'package:kgk_diamonds/bloc/diamond_bloc.dart';
import 'pages/filter_page.dart';
import 'pages/result_page.dart';
import 'pages/cart_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => DiamondBloc()),
        BlocProvider(create: (_) => CartBloc()..loadCart()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => FilterPage(),
          '/result': (context) => ResultPage(),
          '/cart': (context) => CartPage(),
        },
        initialRoute: '/',
      ),
    );
  }
}
