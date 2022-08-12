import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:the_weather/assets/themes/default_theme.dart';
import 'package:the_weather/src/screens/home_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:the_weather/src/cubits/overlay_cubit.dart';
import 'package:the_weather/src/services/locator_service.dart';
import 'package:the_weather/src/widgets/modals_container_widget.dart';

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
    return MultiBlocProvider(
      providers: [
        BlocProvider<OverlayCubit>(
          create: (_) => DI.get<OverlayCubit>(instanceName: 'overlays'),
        ),
      ],
      child: MaterialApp(
        theme: lightThemeData,
        debugShowCheckedModeBanner: false,
        home: Stack(
          children: [
            Scaffold(
              body: HomeScreen(),
            ),
            const Material(
              type: MaterialType.transparency,
              child: ModalsContainer(),
            ),
          ],
        ),
      ),
    );
  }
}
