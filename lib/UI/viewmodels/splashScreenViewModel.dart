import 'package:ecommerce/UI/viewmodels/base_model.dart';
import 'package:ecommerce/core/managers/Routes.dart';
import 'package:ecommerce/core/services/authentificationService.dart';
import 'package:ecommerce/core/services/localDatabaseService.dart';
import 'package:ecommerce/core/services/navigation_service.dart';
import 'package:ecommerce/core/services/notificationService.dart';
import 'package:ecommerce/core/services/orderService.dart';
import 'package:ecommerce/core/services/paymentService.dart';
import 'package:ecommerce/locator.dart';

class SplashScreenViewModel extends BaseModel {
  NavigationService _navigationService = locator<NavigationService>();
  LocalDatabaseService _localDatabaseService = locator<LocalDatabaseService>();
  AuthentificationService _authentificationService =
      locator<AuthentificationService>();
  OrderService _orderService = locator<OrderService>();
  PaymentService _paymentService = locator<PaymentService>();
  NotificationService _notificationService = locator<NotificationService>();

  initApp() async {
    await _localDatabaseService.initDB();
    try {
      _orderService.loadData();
    } catch (e) {
      _orderService.resetCart();
    }

    if (_authentificationService.isConnected) {
      await _notificationService.getNotification();
      try {
        await _authentificationService.getUser();
      } catch (e) {
        _authentificationService.logOut();
      }
    }
    _paymentService.init();

    _navigationService.navigateToAndErasePrevious(RoutesManager.homePage);
  }
}
