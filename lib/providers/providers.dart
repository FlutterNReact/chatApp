import 'package:chatapp/providers/auth_provider.dart';
import 'package:chatapp/providers/chat_list_provider.dart';
import 'package:chatapp/providers/storage_provider.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';

final storage = Storage();
final auth = AuthProvider(storage: storage);
final chatList = ChatListProvider(storage: storage, auth: auth);
Future initProviders() async {
  await storage.init();
  return Future.wait(
    [
      Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      auth.init(),
      chatList.init(),
      initializeDateFormatting()
    ],
  );
}
