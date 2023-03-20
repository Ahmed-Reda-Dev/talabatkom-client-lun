import 'package:lun_talabaty_app/core/home/nearby%20markets/model/nearby_markets.dart';

import '../../core/login&register/model/user_model.dart';

abstract class AppStates {}

class AppInitialState extends AppStates {}

//-------Get Location-------
class GetUserLocationLoadingState extends AppStates {}

class GetUserLocationSuccessState extends AppStates {}

class GetUserLocationErrorState extends AppStates {}

class AddMarkerState extends AppStates {}

class RemoveMarkerState extends AppStates {}

class ClearMarkersState extends AppStates {}

//----- Change bottom sheet----//

class ChangeSelectedListButtonState extends AppStates {}

//----- Change Laguage----//

class ChangeLocaleState extends AppStates {}

class ChangeLocaleSuccessState extends AppStates {}

class ChangeLocaleErrorState extends AppStates {}

//----- User Balance -----//

class GetUserBalanceLoadingState extends AppStates {}

class GetUserBalanceSuccessState extends AppStates {
  final String userBalance;

  GetUserBalanceSuccessState(this.userBalance);
}

class GetUserBalanceErrorState extends AppStates {
  final String errorMessage;

  GetUserBalanceErrorState(this.errorMessage);
}

//----- Get user data -----//

class ProfileLoadingState extends AppStates {}

class ProfileSuccessState extends AppStates {
  final UserModel userModel;

  ProfileSuccessState(this.userModel);
}

class ProfileErrorState extends AppStates {
  final String errorMessage;

  ProfileErrorState(this.errorMessage);
}

//_____ Get Nearby Markets _____//

class GetNearbyMarketsLoadingState extends AppStates {}

class GetNearbyMarketsSuccessState extends AppStates {
  final NearbyMarkets markets;

  GetNearbyMarketsSuccessState(this.markets);
}

class GetNearbyMarketsErrorState extends AppStates {
  final String errorMessage;

  GetNearbyMarketsErrorState(this.errorMessage);
}

//_____ Get Popular Markets _____//

class GetPopularMarketsLoadingState extends AppStates {}

class GetPopularMarketsSuccessState extends AppStates {
  final NearbyMarkets markets;

  GetPopularMarketsSuccessState(this.markets);
}

class GetPopularMarketsErrorState extends AppStates {
  final String errorMessage;

  GetPopularMarketsErrorState(this.errorMessage);
}

//_____ Refresh Markets _____//

class RefreshLoadingState extends AppStates {}

class RefreshLoadedState extends AppStates {}

//_____ Check Internet _____//

class HasInternetConnectionState extends AppStates {}

class NoInternetConnectionState extends AppStates {}
