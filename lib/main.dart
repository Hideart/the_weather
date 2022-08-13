import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:the_weather/assets/themes/default/default_theme.dart';
import 'package:path_provider/path_provider.dart';
import 'package:the_weather/packages/widgets/dismiss_keyboard.dart';
import 'package:the_weather/src/app_state/geo/geo_cubit.dart';
import 'package:the_weather/src/screens/router.dart';
import 'package:the_weather/src/utils/service_locator.dart';

Future initApp() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Change app orientation to the portrait mode
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );

  // Set translucent status bar
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
}

Future main() async {
  await initApp();
  await dotenv.load(fileName: '.env');

  final storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );

  HydratedBlocOverrides.runZoned(
    () {
      DI.init();
      return runApp(const TheWeatherApp());
    },
    storage: storage,
  );
}

class TheWeatherApp extends StatelessWidget {
  const TheWeatherApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final geoStateCubit = DI.get<GeoStateCubit>(instanceName: 'geo_state');
    final router = appRouter(geoStateCubit);
    return BlocProvider<GeoStateCubit>(
      create: (_) => geoStateCubit,
      child: DismissKeyboard(
        child: MaterialApp.router(
          theme: lightThemeData,
          debugShowCheckedModeBanner: false,
          routeInformationProvider: router.routeInformationProvider,
          routeInformationParser: router.routeInformationParser,
          routerDelegate: router.routerDelegate,
        ),
      ),
    );
  }
}
