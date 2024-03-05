import 'package:ecommerce/core/models/notificationData.dart';
import 'package:ecommerce/core/services/apiService.dart';
import 'package:ecommerce/core/services/authentificationService.dart';
import 'package:ecommerce/locator.dart';

class NotificationService {
  ApiService _apiService = locator<ApiService>();
  AuthentificationService _authentificationService =
      locator<AuthentificationService>();

  List<NotificationData> notifications;
  String errors = "";

  Future<bool> getNotification() async {
    if (!_authentificationService.isConnected) return false;

    try {
      notifications = await _apiService.getDatasWithAuth<NotificationData>(
          urlPath: "settings/getNotification",
          perItemCreation: (item) => NotificationData.fromMap(item));
      errors = "";
      return true;
    } catch (e) {
      notifications = null;
      errors = e.toString();
      return false;
    }
  }

  Future<bool> deleteNotification(int notifId) async {
    try {
      notifications = await _apiService.deleteNotificcation(notifId);
      errors = "";
      return true;
    } catch (e) {
      errors = e.toString();
      return false;
    }
  }
}
