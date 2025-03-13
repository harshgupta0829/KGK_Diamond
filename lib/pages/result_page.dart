import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kgk_diamonds/bloc/cart_bloc.dart';
import 'package:kgk_diamonds/bloc/diamond_bloc.dart';
import 'package:kgk_diamonds/models/diamonds.dart';
import 'package:badges/badges.dart' as badges;

class ResultPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5), // Light grey background
      appBar: AppBar(
        title: Text(
          'Filtered Diamonds',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF47594C),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          // Sorting PopupMenuButton
          PopupMenuButton<String>(
            icon: Icon(Icons.sort, color: Colors.white),
            onSelected: (value) {
              if (value == 'finalPriceAsc') {
                context
                    .read<DiamondBloc>()
                    .sortDiamonds('finalAmount', ascending: true);
              } else if (value == 'finalPriceDesc') {
                context
                    .read<DiamondBloc>()
                    .sortDiamonds('finalAmount', ascending: false);
              } else if (value == 'caratAsc') {
                context
                    .read<DiamondBloc>()
                    .sortDiamonds('carat', ascending: true);
              } else if (value == 'caratDesc') {
                context
                    .read<DiamondBloc>()
                    .sortDiamonds('carat', ascending: false);
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'caratAsc',
                child: Text('Sort by Carat (Asc)'),
              ),
              PopupMenuItem(
                value: 'caratDesc',
                child: Text('Sort by Carat (Desc)'),
              ),
              PopupMenuItem(
                value: 'finalPriceAsc',
                child: Text('Sort by Final Price (Asc)'),
              ),
              PopupMenuItem(
                value: 'finalPriceDesc',
                child: Text('Sort by Final Price (Desc)'),
              ),
            ],
          ),
          // Cart Icon with Badge
          BlocBuilder<CartBloc, List<Diamond>>(
            builder: (context, cart) {
              return badges.Badge(
                position: badges.BadgePosition.topEnd(top: -10, end: -10),
                badgeContent: Text(
                  cart.length.toString(),
                  style: TextStyle(color: Colors.white),
                ),
                child: IconButton(
                  icon: Icon(Icons.shopping_cart, color: Colors.white),
                  onPressed: () {
                    Navigator.pushNamed(context, '/cart');
                  },
                ),
              );
            },
          ),
          SizedBox(width: 10), // Add spacing
        ],
      ),
      body: BlocBuilder<DiamondBloc, List<Diamond>>(
        builder: (context, diamonds) {
          if (diamonds.isEmpty) {
            return Center(
              child: Text(
                'No diamonds found.',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[600],
                ),
              ),
            );
          }
          return ListView.builder(
            itemCount: diamonds.length,
            itemBuilder: (context, index) {
              final diamond = diamonds[index];
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.all(16),
                  leading:
                      Icon(Icons.diamond, color: Color(0xFF47594C), size: 40),
                  title: Text(
                    'Lot ID: ${diamond.lotId}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8),
                      Text(
                        'Carat: ${diamond.carat}',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      Text(
                        'Lab: ${diamond.lab}',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      Text(
                        'Shape: ${diamond.shape}',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      Text(
                        'Color: ${diamond.color}',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      Text(
                        'Clarity: ${diamond.clarity}',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      Text(
                        'Final Price: ₹${diamond.finalAmount.toStringAsFixed(2)}',
                        style: TextStyle(
                          color: Colors.green[700],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  trailing: BlocBuilder<CartBloc, List<Diamond>>(
                    builder: (context, cart) {
                      final isInCart =
                          cart.any((item) => item.lotId == diamond.lotId);
                      return IconButton(
                        icon: Icon(
                          isInCart
                              ? Icons.remove_shopping_cart
                              : Icons.add_shopping_cart,
                          color: isInCart ? Colors.red : Colors.green,
                          size: 30,
                        ),
                        onPressed: () {
                          if (isInCart) {
                            context.read<CartBloc>().removeFromCart(diamond);
                          } else {
                            context.read<CartBloc>().addToCart(diamond);
                          }
                        },
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
