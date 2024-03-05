/*
 * Deppendency ingection manager
*/

import 'package:ecommerce/core/services/apiService.dart';
import 'package:ecommerce/core/services/authentificationService.dart';
import 'package:ecommerce/core/services/dialog_service.dart';
import 'package:ecommerce/core/services/localDatabaseService.dart';
import 'package:ecommerce/core/services/navigation_service.dart';
import 'package:ecommerce/core/services/orderService.dart';
import 'package:ecommerce/core/services/paymentService.dart';
import 'package:ecommerce/core/services/notificationService.dart';
import 'package:ecommerce/core/services/phoneVerificationService.dart';

import 'package:get_it/get_it.dart';

//! Global locator variable
GetIt locator = GetIt.instance;

//! Function to be called before the runApp function
void setupLocator() {
  //Add services here
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => LocalDatabaseService());
  locator.registerLazySingleton(() => OrderService());
  locator.registerLazySingleton(() => AuthentificationService());
  locator.registerLazySingleton(() => ApiService());
  locator.registerLazySingleton(() => PaymentService());
  locator.registerLazySingleton(() => NotificationService());
  locator.registerLazySingleton(() => PhoneVerficationService());
}
