import 'package:ecommerce/UI/viewmodels/base_model.dart';
import 'package:ecommerce/core/models/productData.dart';
import 'package:ecommerce/core/models/productOrderData.dart';
import 'package:ecommerce/core/services/authentificationService.dart';
import 'package:ecommerce/core/services/dialog_service.dart';
import 'package:ecommerce/core/services/orderService.dart';
import 'package:ecommerce/locator.dart';

class ProductCardViewModel extends BaseModel {
  OrderService _orderService = locator<OrderService>();
  DialogService _dialogService = locator<DialogService>();
  AuthentificationService _authentificationService =
      locator<AuthentificationService>();

  void addToWishList(ProductData productData) {
    if (_authentificationService.isConnected)
      _orderService.addItemToWishList(productData);
    else
      _dialogService.showDialog(
          title: "Error",
          description: "Please login before adding products to the cart");
  }

  void addToCart(ProductData productData, bool forRedeeming) {
    if (_authentificationService.isConnected) {
      ProductOrderData order = ProductOrderData(
        chosenSubProduct: 0,
        product: productData,
        price: forRedeeming
            ? 0.0
            : productData.priceWithDiscount * productData.uoms[0].value,
        unitPrice: productData.priceWithDiscount,
        quantity: 1,
        isRedeemed: forRedeeming,
        chosenVariations: [],
        uom: productData.uoms[0],
      );
      _orderService.addItemToOrder(order);
    } else {
      _dialogService.showDialog(
          title: "Error",
          description: "Please login before adding products to the cart");
    }
  }
}
