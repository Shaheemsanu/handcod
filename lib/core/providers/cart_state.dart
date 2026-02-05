import 'package:handcode_test/presentation/models/service_model.dart';

class CartState {
  final List<ServiceModel> items;
  final bool isLoading;

  const CartState({
    required this.items,
    this.isLoading = false,
  });

  CartState copyWith({
    List<ServiceModel>? items,
    bool? isLoading,
  }) {
    return CartState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
