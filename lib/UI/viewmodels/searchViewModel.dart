import 'package:ecommerce/UI/viewmodels/base_model.dart';
import 'package:ecommerce/core/models/failure.dart';
import 'package:ecommerce/core/models/productData.dart';
import 'package:ecommerce/core/services/apiService.dart';
import 'package:ecommerce/locator.dart';
import 'package:dartz/dartz.dart';

class SearchViewModel extends BaseModel {
  ApiService _apiService = locator<ApiService>();

  bool productsAreLoading = false;
  Either<Failure, List<ProductData>> products;

  void getProductsSearch(String search) async {
    productsAreLoading = true;
    notifyListeners();

    await Task(() => _apiService.getDatas<ProductData>(
            urlPath: "backend/searchProduct/$search",
            perItemCreation: (item) => ProductData.fromMap(item)))
        .attempt()
        .mapLeftToFailure()
        .run()
        .then((value) => products = value);

    productsAreLoading = false;
    notifyListeners();
  }
}
