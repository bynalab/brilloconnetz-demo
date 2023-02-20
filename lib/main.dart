import 'package:brilloconnetz/splash_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kDebugMode) {
    print((await getApplicationDocumentsDirectory()).path);
  }

  await GetStorage.init();

  runApp(const BrilloConnetz());
}

class BrilloConnetz extends StatelessWidget {
  const BrilloConnetz({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Montserrat',
      ),
      home: const SplashScreen(),
      initialRoute: SplashScreen.id,
    );
  }
}
