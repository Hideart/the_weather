import 'package:get_it/get_it.dart';
import 'package:the_weather/src/cubits/cubits.dart';

class DI {
  static final GetIt _locator = GetIt.instance;

  static void init() {
    DI.registerLazySingleton<OverlayCubit>(
      () => OverlayCubit(),
      instanceName: 'overlays',
    );
  }

  static T registerSingleton<T extends Object>(
    T instance, {
    String? instanceName,
  }) {
    DI._locator.registerSingleton<T>(
      instance,
      instanceName: instanceName,
    );
    return instance;
  }

  static void registerLazySingleton<T extends Object>(
    T Function() factoryFunc, {
    String? instanceName,
  }) {
    DI._locator.registerLazySingleton<T>(
      factoryFunc,
      instanceName: instanceName,
    );
  }

  static T get<T extends Object>({String? instanceName}) {
    return DI._locator<T>(instanceName: instanceName);
  }
}
