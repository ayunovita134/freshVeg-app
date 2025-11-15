import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/history_item.dart';

class HistoryService {
  static const String _historyKey = 'history_list';

  static Future<void> saveHistoryItem(HistoryItem item) async {
    final prefs = await SharedPreferences.getInstance();
    final historyList = await getHistoryList();
    historyList.add(item);
    final jsonList = historyList.map((e) => e.toJson()).toList();
    await prefs.setString(_historyKey, json.encode(jsonList));
  }

  static Future<List<HistoryItem>> getHistoryList() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_historyKey);
    if (jsonString == null) return [];
    final jsonList = json.decode(jsonString) as List;
    return jsonList.map((e) => HistoryItem.fromJson(e)).toList();
  }
}
