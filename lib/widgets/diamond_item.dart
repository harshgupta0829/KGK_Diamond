import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kgk_diamonds/bloc/cart_bloc.dart';
import 'package:kgk_diamonds/models/diamonds.dart';

class DiamondItem extends StatelessWidget {
  final Diamond diamond;

  DiamondItem({required this.diamond});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text('Lot ID: ${diamond.lotId}'),
        subtitle:
            Text('Carat: ${diamond.carat}, Price: ${diamond.finalAmount}'),
        trailing: IconButton(
          icon: Icon(Icons.add_shopping_cart),
          onPressed: () {
            context.read<CartBloc>().addToCart(diamond);
            Navigator.pushNamed(context, '/cart');
          },
        ),
      ),
    );
  }
}
