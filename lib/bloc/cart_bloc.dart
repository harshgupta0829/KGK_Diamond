import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kgk_diamonds/models/diamonds.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CartBloc extends Cubit<List<Diamond>> {
  CartBloc() : super([]);

  void loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    final cartJson = prefs.getString('cart');
    if (cartJson != null) {
      final cart = (json.decode(cartJson) as List)
          .map((item) => Diamond.fromJson(item))
          .toList();
      emit(cart);
    }
  }

  void addToCart(Diamond diamond) async {
    final updatedCart = List<Diamond>.from(state)..add(diamond);
    emit(updatedCart);
    await _saveCart(updatedCart);
  }

  void removeFromCart(Diamond diamond) async {
    final updatedCart = List<Diamond>.from(state)..remove(diamond);
    emit(updatedCart);
    await _saveCart(updatedCart);
  }

  Future<void> _saveCart(List<Diamond> cart) async {
    final prefs = await SharedPreferences.getInstance();
    final cartJson = json.encode(cart.map((d) => d.toJson()).toList());
    await prefs.setString('cart', cartJson);
  }
}
