import 'dart:developer';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../presentation/models/service_model.dart';

class CartService {
  SupabaseClient get _client => Supabase.instance.client;

  Future<bool> addMultipleToCart(List<ServiceModel> items) async {
    try {
      if (items.isEmpty) return false;

      final payload = items.map((item) {
        return {
          'name': item.name,
          'quantity': item.quantity,
          'price': item.price.toInt(),
        };
      }).toList();

      log('Adding to cart: $payload');

      final response = await _client.from('cart').insert(payload).select();

      log('Supabase response: $response');
      if (response.isNotEmpty) {
        // getCartItems();
      }
      return response.isNotEmpty;
    } catch (e) {
      log('Add to cart failed: $e');
      return false;
    }
  }

  Future<List<ServiceModel>> getCartItems() async {
    try {
      final response = await _client.from('cart').select().order('id');

      log('Fetch cart response: $response');
      return response
          .map<ServiceModel>((e) => ServiceModel.fromMap(e))
          .toList();
    } catch (e) {
      log('Fetch cart failed: $e');
      return [];
    }
  }
}
