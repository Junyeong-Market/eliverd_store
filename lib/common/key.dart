import 'package:flutter/cupertino.dart';

class SplashScreenKeys {
  static final splashScreenPage = Key('__SplashScreenPage__');
  static final splashScreenLogo = Key('__SplashScreenLogo__');
  static final splashScreenBackground = Key('__SplashScreenBackground__');
}

class LoginPageKeys {
  static final loginPage = Key('__LoginPage__');
  static final loginLogo = Key('__LoginLogo__');
  static final loginErrorMsg = Key('__LoginErrorMessage__');
  static final idTextField = Key('__LoginIdTextField__');
  static final passwordTextField = Key('__LoginPasswordTextField__');
  static final loginBtn = Key('__LoginButton__');
  static final signUpBtn = Key('__SignUpButtonFromLoginPage__');
}

class SignUpPageKeys {
  static final signUpPage = Key('__SignUpPage__');
  static final signUpBackBtn = Key('__SignUpBackButton__');
  static final realnameTextField = Key('__SignUpRealnameTextField__');
  static final nicknameTextField = Key('__SignUpNicknameTextField__');
  static final idTextField = Key('__SignUpIdTextField__');
  static final passwordTextField = Key('__SignUpPasswordTextField__');
  static final isSellerSwitch = Key('__SignUpIsSellerSwitch__');
  static final signUpErrorMsg = Key('__SignUpErrorMessage__');
  static final signUpBtn = Key('__SignUpButtonFromSignUpPage__');
}

class HomePageKeys {
  static final homePage = Key('__HomePage__');
  static final stockList = Key('__HomeStockList__');
  static final signOutBtn = Key('__HomeSignOutButton__');
  static final searchProductBtn = Key('__HomeSearchProductButton__');
  static final addStockBtn = Key('__HomeAddStockButton__');
  static final currentStoreName = Key('__HomeCurrentStoreName__');
}

class StoreSelectionPageKeys {
  static final storeSelectionPage = Key('__StoreSelectionPage__');
}

class AddStockPageKeys {
  static final addStockPage = Key('__AddStockPage__');
  static final barcodeImage = Key('__AddStockBarcodeImage__');
  static final productNameTextField = Key('__AddStockNameTextField__');
  static final productPriceTextField = Key('__AddStockPriceTextField__');
  static final productManufacturerTextField = Key('__AddStockManufacturerTextField__');
  static final productAmountTextField = Key('__AddStockAmountTextField__');
  static final productSubmitBtn = Key('__AddStockSubmitButton__');
}

class RegisterStorePageKeys {
  static final registerStorePage = Key('__RegisterStorePage__');
  static final registerStoreBtn = Key('__RegisterStoreButton__');
}

class UpdateStockPageKeys {
  static final updateStockPage = Key('__UpdateStockPage__');
  static final barcodeImage = Key('__UpdateStockBarcodeImage__');
  static final productNameTextField = Key('__UpdateStockNameTextField__');
  static final productPriceTextField = Key('__UpdateStockPriceTextField__');
  static final productManufacturerTextField = Key('__UpdateStockManufacturerTextField__');
  static final productAmountTextField = Key('__UpdateStockAmountTextField__');
  static final productSubmitBtn = Key('__UpdateStockSubmitButton__');
}