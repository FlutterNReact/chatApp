import 'package:chatapp/providers/auth_provider.dart';
import 'package:chatapp/providers/storage_provider.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';

final storage = Storage();
final auth = AuthProvider(storage: storage);
Future initProviders() async {
  await Future.wait([
    storage.init(),
    Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    )
  ]);
  return Future.wait(
    [
      auth.init(),
      initializeDateFormatting(),
    ],
  );
}
