import 'package:shop_app/models/cart_model.dart';
import 'package:shop_app/models/favorite_model.dart';
import 'package:shop_app/models/login_model.dart';

abstract class HomeStates {}

class HomeInitialState extends HomeStates {}

class ChangeHomeNavIndexState extends HomeStates {}

class GetHomeDataLoadingSate extends HomeStates {}

class GetHomeDataSuccessSate extends HomeStates {}

class GetHomeDataErrorSate extends HomeStates {}

class GetCategorySuccessSate extends HomeStates {}

class GetCategoryErrorSate extends HomeStates {}

class ChangeFavState extends HomeStates {}
class ChangeCarState extends HomeStates {}

class ChangeFavSuccessState extends HomeStates {
  FavoriteModel model;

  ChangeFavSuccessState(this.model);
}

class ChangeCartErrorState extends HomeStates {}

class ChangeCartState extends HomeStates {}

class ChangeCartSuccessState extends HomeStates {
  CartChangeModel model;

  ChangeCartSuccessState(this.model);
}

class ChangeFavErrorState extends HomeStates {}

class GetFavSuccessState extends HomeStates {}

class GetFavErrorState extends HomeStates {}

class GetCartSuccessState extends HomeStates {}

class GetCartErrorState extends HomeStates {}

class ChangeThemeMode extends HomeStates {}

class ChangeImage extends HomeStates {}

class GetProfileSuccessState extends HomeStates {}

class GetProfileErrorState extends HomeStates {}

class UpdateProfileSuccessState extends HomeStates {
  late LoginModel model;

  UpdateProfileSuccessState(this.model);
}

class UpdateProfileErrorState extends HomeStates {}

class UpdateProfileLoadingState extends HomeStates {}

class ChangeVisibility extends HomeStates {}

class SignUpLoadingState extends HomeStates {}

class SignUpSuccessState extends HomeStates {
  LoginModel model;

  SignUpSuccessState(this.model);
}

class SignUpErrorState extends HomeStates {}

class ChangeLanguage extends HomeStates {}

class GetSearchSuccess extends HomeStates {}

class GetSearchLoading extends HomeStates {}

class GetSearchError extends HomeStates {}