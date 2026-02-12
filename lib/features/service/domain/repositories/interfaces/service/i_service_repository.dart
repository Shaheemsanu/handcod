import 'package:handcode_test/features/service/domain/models/servicemodel/servicemodel_model.dart';

abstract class IServiceRepository {
  Future<List<Servicemodel>> getService();
  Future<void> addToCart(List<Servicemodel> services);
}
