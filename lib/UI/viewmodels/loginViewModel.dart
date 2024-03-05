import 'package:ecommerce/UI/viewmodels/base_model.dart';
import 'package:ecommerce/core/managers/Routes.dart';
import 'package:ecommerce/core/services/authentificationService.dart';
import 'package:ecommerce/core/services/dialog_service.dart';
import 'package:ecommerce/core/services/navigation_service.dart';
import 'package:ecommerce/locator.dart';
import 'package:flutter/material.dart';

class LoginViewModel extends BaseModel {
  AuthentificationService _authentificationService =
      locator<AuthentificationService>();
  DialogService _dialogService = locator<DialogService>();
  NavigationService _navigationService = locator<NavigationService>();

  final formKey = GlobalKey<FormState>();

  String auth = "";
  String password = "";

  void login() async {
    if (!formKey.currentState.validate() && state == ViewState.Busy) return;

    formKey.currentState.save();
    setState(ViewState.Busy);

    try {
      if (await _authentificationService.connect(auth, password)) {
        _navigationService.navigateToAndErasePrevious(RoutesManager.homePage);
      }
    } catch (e) {
      await _dialogService.showDialog(
          title: "error", description: e.toString());
    }

    setState(ViewState.Idle);
  }
}
