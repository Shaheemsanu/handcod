import 'package:flutter_riverpod/legacy.dart';
import 'package:handcode_test/core/providers/cart_state.dart';
import 'package:handcode_test/core/services/cart_service.dart';
import 'package:handcode_test/presentation/models/service_model.dart';

final cartProvider = StateNotifierProvider<CartNotifier, CartState>(
  (ref) => CartNotifier(CartService()),
);

class CartNotifier extends StateNotifier<CartState> {
  final CartService _cartService;

  CartNotifier(this._cartService) : super(const CartState(items: []));

  void addService(ServiceModel service) {
    final index = state.items.indexWhere((e) => e.name == service.name);

    if (index == -1) {
      state = state.copyWith(
        items: [...state.items, service.copyWith(quantity: 1)],
      );
    } else {
      state = state.copyWith(
        items: [
          for (final item in state.items)
            if (item.name == service.name)
              item.copyWith(quantity: item.quantity + 1)
            else
              item,
        ],
      );
    }
  }

  void removeService(ServiceModel service) {
    final index = state.items.indexWhere((e) => e.name == service.name);

    if (index == -1) return;

    final item = state.items[index];

    if (item.quantity == 1) {
      state = state.copyWith(
        items: state.items.where((e) => e.name != service.name).toList(),
      );
    } else {
      state = state.copyWith(
        items: [
          for (final e in state.items)
            if (e.name == service.name)
              e.copyWith(quantity: e.quantity - 1)
            else
              e,
        ],
      );
    }
  }

  Future<bool> syncCartToServer() async {
    state = state.copyWith(isLoading: true);

    final success = await _cartService.addMultipleToCart(state.items);

    state = state.copyWith(isLoading: false);

    return success;
  }

  Future<void> loadCartFromSupabase() async {
    state = state.copyWith(isLoading: true);

    final items = await _cartService.getCartItems();

    state = state.copyWith(items: items, isLoading: false);
  }

  int get totalItems => state.items.fold(0, (sum, item) => sum + item.quantity);

  double get totalPrice =>
      state.items.fold(0, (sum, item) => sum + item.price * item.quantity);
}
