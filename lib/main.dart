import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:passtore/assets/themes/themes.dart';
import 'package:passtore/src/widgets/modals.widget.dart';
import 'package:passtore/src/widgets/themed-screen-wrapper.widget.dart';
import 'package:passtore/src/widgets/themed-text.widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:passtore/src/screens/main.screen.dart';
import 'package:passtore/src/services/services.dart';
//import 'package:flutter_services_binding/flutter_services_binding.dart';

Future initApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  // FlutterServicesBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  // Change app orientation to the portrait mode
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );

  // Set translucent status bar
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
}

void main() async {
  initApp();

  final storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );

  HydratedBlocOverrides.runZoned(
    () {
      DI.init();
      return runApp(
        EasyLocalization(
          startLocale: new Locale(Platform.localeName.split('_')[0], ''),
          supportedLocales: const [Locale('en', ''), Locale('ru', '')],
          path: 'lib/assets/translations',
          fallbackLocale: const Locale('en', ''),
          child: PasstoreApp(),
        ),
      );
    },
    storage: storage,
  );
}

class PasstoreApp extends StatelessWidget {
  // final ModalsCubit modalsState = DI.get<ModalsCubit>(instanceName: 'modals');

  PasstoreApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>(
          create: (_) => DI.get<ThemeCubit>(instanceName: 'theme'),
        ),
        BlocProvider<StorageCubit>(
          create: (_) => DI.get<StorageCubit>(instanceName: 'safeStorage'),
        ),
        // BlocProvider<ModalsCubit>(
        //   create: (_) => DI.get<ModalsCubit>(instanceName: 'modals'),
        // ),
      ],
      child: MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        home: Scaffold(
          body: MainScreen(),
          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                heroTag: 'modals',
                child: const Icon(Icons.telegram),
                onPressed: () =>
                    DI.get<ThemeCubit>(instanceName: 'theme').changeTheme(
                          AvailableTheme.main,
                        ),
                // () => modalsState.add(
                //   const ThemedModal(
                //     id: 'testModal',
                //     child: Text('modal testing'),
                //   ),
                // ),
              ),
              const SizedBox(height: 10),
              FloatingActionButton(
                heroTag: 'themes',
                child: const Icon(Icons.abc_rounded),
                onPressed: () =>
                    DI.get<ThemeCubit>(instanceName: 'theme').changeTheme(
                          AvailableTheme.dark,
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}