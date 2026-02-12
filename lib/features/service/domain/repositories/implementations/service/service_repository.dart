import 'dart:developer';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handcode_test/shared/providers/supabase_provider/supabase_provider.dart';
import 'package:handcode_test/shared/utils/exceptions.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:handcode_test/features/service/service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'service_repository.g.dart';

@Riverpod(keepAlive: true)
IServiceRepository serviceRepo(Ref ref) => ServiceRepository(ref);

class ServiceRepository implements IServiceRepository {
  ServiceRepository(this.ref) : _supabaseClient = ref.watch(supabaseProvider);

  final Ref ref;
  final SupabaseClient _supabaseClient;

  @override
  Future<List<Servicemodel>> getService() async {
    try {
      final response = await _supabaseClient
          .from('service')
          .select()
          .order('id');

      log('Fetch cart response: $response');
      return response
          .map<Servicemodel>((e) => Servicemodel.fromJson(e))
          .toList();
    } on PostgrestException catch (e) {
      throw AppException(e.message);
    } on AuthException catch (e) {
      throw AppException(e.message);
    } on SocketException catch (e) {
      throw AppException('Unable to connect to the server: ${e.message}');
    } on FunctionException catch (e) {
      throw AppException.fromFunctionException(e);
    } on Exception catch (e) {
      throw AppException('An unexpected error occurred: $e');
    }
  }

  @override
  Future<void> addToCart(List<Servicemodel> services) async {
    try {
      final cartData = services
          .where((s) => s.quantity > 0)
          .map(
            (s) => {
              'id': s.id,
              'name': s.name,
              'stock': s.stock,
              'price': s.price,
              'image_url': s.image,
              'quantity': s.quantity,
            },
          )
          .toList();
      log("cartData: $cartData");
      if (cartData.isEmpty) return;
      await _supabaseClient.from('cart').upsert(cartData, onConflict: 'id');
    } on PostgrestException catch (e) {
      throw AppException(e.message);
    } on AuthException catch (e) {
      throw AppException(e.message);
    } on SocketException catch (e) {
      throw AppException('Unable to connect to the server: ${e.message}');
    } on FunctionException catch (e) {
      throw AppException.fromFunctionException(e);
    } on Exception catch (e) {
      throw AppException('An unexpected error occurred: $e');
    }
  }
}
