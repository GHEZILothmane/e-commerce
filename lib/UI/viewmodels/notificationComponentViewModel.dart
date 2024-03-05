import 'package:ecommerce/UI/viewmodels/base_model.dart';
import 'package:ecommerce/core/models/notificationData.dart';
import 'package:ecommerce/core/services/authentificationService.dart';
import 'package:ecommerce/core/services/dialog_service.dart';
import 'package:ecommerce/core/services/notificationService.dart';
import 'package:ecommerce/locator.dart';

class NotificationComponentViewModel extends BaseModel {
  AuthentificationService _authentificationService =
      locator<AuthentificationService>();
  NotificationService _notificationService = locator<NotificationService>();
  DialogService _dialogService = locator<DialogService>();

  bool get isConnected => _authentificationService.isConnected;

  bool notificationsAreLoading = false;
  List<NotificationData> get notifications =>
      _notificationService.notifications;
  String get errors => _notificationService.errors;

  Future getNotifications() async {
    notificationsAreLoading = true;
    notifyListeners();

    await _notificationService.getNotification();

    notificationsAreLoading = false;
    notifyListeners();
  }

  deleteNotification(NotificationData data) async {
    if ((await _dialogService.showConfirmationDialog(
            title: "Error",
            description: "Do you really want to delete this notification",
            confirmationTitle: "Yes",
            cancelTitle: "No"))
        .confirmed) {
      bool result = await _notificationService.deleteNotification(data.id);
      if (result) {
        _dialogService.showDialog(
            title: "Success", description: "Notification deleted successfully");
        getNotifications();
      } else
        _dialogService.showDialog(
            title: "Error",
            description: "Error : ${_notificationService.errors}");
    }
  }
}
