import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:handcode_test/features/service/domain/models/servicemodel/servicemodel_model.dart';
import 'package:handcode_test/features/service/domain/repositories/implementations/service/service_repository.dart';
import 'package:handcode_test/features/service/domain/repositories/interfaces/service/i_service_repository.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'service_notifier.freezed.dart';
part 'service_notifier.g.dart';
part 'service_state.dart';

@Riverpod()
class ServiceNotifier extends _$ServiceNotifier {
  final FormGroup form = FormGroup({
    'id': FormControl<int>(validators: [Validators.required]),
    'name': FormControl<String>(validators: [Validators.required]),
    'quantity': FormControl<int>(
      validators: [Validators.required],
      nonNullable: true,
    ),
    'order': FormControl<int>(validators: [Validators.required]),
    'category': FormControl<String>(validators: [Validators.required]),
    'stock': FormControl<int>(validators: [Validators.required]),
    'price': FormControl<int>(validators: [Validators.required]),
    'image': FormControl<String>(),
  });
  late IServiceRepository _serviceRepository;
  @override
  Future<ServiceState> build() async {
    _serviceRepository = ref.watch(serviceRepoProvider);

    final services = await _serviceRepository.getService();

    return ServiceState(services: services);
  }

  Future<void> loadServices(Servicemodel service) async {
    form.patchValue({
      'id': service.id,
      'name': service.name,
      'quantity': service.quantity,
      'order': service.order,
      'price': service.price,
      'image': service.image,
      'stock': service.stock,
    });
  }

  void updateQuantity(int serviceId, int quantity) {
    form.controls['quantity']?.updateValue(quantity);
    final currentState = state.value;

    if (currentState == null) return;

    final updatedServices = currentState.services.map((service) {
      if (service.id == serviceId) {
        if (quantity >= 0 && quantity <= (service.stock ?? 0)) {
          return service.copyWith(quantity: quantity);
        }
      }
      return service;
    }).toList();

    state = AsyncData(currentState.copyWith(services: updatedServices));
  }

  Future<void> addItemsToCart(VoidCallback onNavigate) async {
    final currentState = state.value;
    if (currentState == null || totalItems == 0) return;

    state = AsyncData(currentState.copyWith(isUploading: true));

    try {
      await _serviceRepository.addToCart(currentState.services);

      state = AsyncData(currentState.copyWith(isUploading: false));
      onNavigate(); // Proceed to navigation after success
    } catch (e) {
      state = AsyncData(
        currentState.copyWith(isUploading: false, error: e.toString()),
      );
    }
  }

  int get totalItems =>
      state.value?.services.fold(
        0,
        (sum, item) => (sum ?? 0) + (item.quantity),
      ) ??
      0;

  double get totalPrice =>
      state.value?.services.fold(
        0,
        (sum, item) => (sum ?? 0) + (item.price ?? 0) * (item.quantity),
      ) ??
      0;

  // Future<void> addService() async {
  //   if (!form.valid) {
  //     form.markAllAsTouched();
  //     return;
  //   }

  //   final model = Servicemodel(

  //     name: form.control('name').value,
  //     quantity: form.control('quantity').value,
  //     price: form.control('price').value,
  //     image: form.control('image').value,
  //   );

  //   await _serviceRepository.getService(model);

  //   await loadServices(); // refresh list
  //   form.reset();
  // }
}
