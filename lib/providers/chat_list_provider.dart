import 'package:chatapp/providers/auth_provider.dart';
import 'package:chatapp/providers/storage_provider.dart';
import 'package:flutter/material.dart';

class ChatList {}

class Chat {}

class ChatListProvider extends ValueNotifier<List<ChatList>> {
  ChatListProvider({required this.storage, required this.auth}) : super([]);
  final Storage storage;
  final AuthProvider auth;
  Future init() async {
    // value = storage.getString('isLogin') == true;
  }
}

class ChatProvider extends ValueNotifier<List<Chat>> {
  ChatProvider(String chatListId, {required this.storage, required this.auth})
      : super([]);
  final Storage storage;
  final AuthProvider auth;
  Future init() async {
    // value = storage.getString('isLogin') == true;
  }
}
