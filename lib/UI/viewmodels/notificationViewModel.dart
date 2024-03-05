import 'package:ecommerce/UI/viewmodels/base_model.dart';
import 'package:ecommerce/core/services/apiService.dart';
import 'package:ecommerce/core/services/dialog_service.dart';
import 'package:ecommerce/locator.dart';

class NotificationViewModel extends BaseModel {
  ApiService _apiService = locator<ApiService>();
  DialogService _dialogService = locator<DialogService>();

  void init(int notifId) async {
    try {
      await _apiService.markNotifAsRead(notifId);
    } catch (e) {
      _dialogService.showDialog(
          title: "Error", description: "Couldn't mark notification as read");
    }
  }
}
