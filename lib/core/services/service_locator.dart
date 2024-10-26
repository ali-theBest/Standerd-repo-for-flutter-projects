import 'package:get_it/get_it.dart';
import 'connectivity_service.dart';
import 'local_storage_service.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton<ConnectivityService>(() => ConnectivityService());
  getIt.registerLazySingleton<LocalStorageService>(() => LocalStorageService());

}
