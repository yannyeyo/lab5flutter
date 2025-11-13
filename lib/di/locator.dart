import 'package:get_it/get_it.dart';
import '../services/item_service.dart';

final di = GetIt.instance;

void setupLocator() {
  di.registerLazySingleton<ItemService>(() => ItemService());
}
