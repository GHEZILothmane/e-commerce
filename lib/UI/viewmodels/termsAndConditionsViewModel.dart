import 'package:ecommerce/UI/viewmodels/base_model.dart';
import 'package:ecommerce/core/models/failure.dart';
import 'package:ecommerce/core/services/apiService.dart';
import 'package:ecommerce/locator.dart';
import 'package:dartz/dartz.dart';

class TermsAndConditionsViewModel extends BaseModel {
  ApiService _apiService = locator<ApiService>();

  Either<Failure, dynamic> terms;

  void init() async {
    setState(ViewState.Busy);

    await Task(
      () => _apiService.getSetting("terms"),
    ).attempt().mapLeftToFailure().run().then((value) => terms = value);

    setState(ViewState.Idle);
  }
}
