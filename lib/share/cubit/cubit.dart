import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lun_talabaty_app/core/home/nearby%20markets/model/nearby_markets.dart';
import 'package:lun_talabaty_app/share/cubit/states.dart';
import 'package:lun_talabaty_app/share/remote/end_points.dart';

import '../../core/home/balance/model/user_balance.dart';
import '../../core/login&register/model/user_model.dart';
import '../locale/cache_helper.dart';
import '../remote/dio_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  late GoogleMapController mapController;

  LatLng? currentPosition;

  //request permission for location
  void requestPermission() async {
    await Geolocator.requestPermission();
  }

  //get user location
  String formattedAddress = "";
  Future<void> getLocation() async {
    emit(GetUserLocationLoadingState());
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    currentPosition = LatLng(position.latitude, position.longitude);

    List<Placemark> placemarks = await placemarkFromCoordinates(
        currentPosition!.latitude, currentPosition!.longitude);
    Placemark placemark = placemarks[0];
    formattedAddress =
        '${placemark.thoroughfare}, ${placemark.subAdministrativeArea}';
    //print("العنواااان" + formattedAddress);

    emit(GetUserLocationSuccessState());

    if (kDebugMode) {
      print(currentPosition!.latitude);
    }
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  //markers for map
  Set<Marker> markers = {};
  void addMarker(LatLng latLng) {
    markers.add(
      Marker(
        markerId: MarkerId(latLng.toString()),
        position: latLng,
        icon: BitmapDescriptor.defaultMarker,
      ),
    );
    emit(AddMarkerState());
  }

  void removeMarker(LatLng latLng) {
    markers.removeWhere((element) => element.position == latLng);
    emit(RemoveMarkerState());
  }

  void clearMarkers() {
    markers.clear();
    emit(ClearMarkersState());
  }

  int selectedListButton = 1;
  int selectedButton = 0;

  void changeSelectedListButton(int index) {
    selectedListButton = index;
    emit(ChangeSelectedListButtonState());
  }

//User Balance
  UserBalance? userBalance;
  String userBalanceValue = "";

  void getUserBalance() {
    emit(GetUserBalanceLoadingState());
    try {
      Api.get(
        path: MYBALANCE,
        data: {
          'api_token': TOKEN,
        },
      ).then((value) {
        userBalance = UserBalance.fromJson(value.data);
        debugPrint(userBalance!.data!.balance.toString());
        if (userBalance!.success == true) {
          userBalanceValue = userBalance!.data!.balance!.toStringAsFixed(2);
          emit(GetUserBalanceSuccessState(
            userBalanceValue,
          ));
        } else {
          emit(GetUserBalanceErrorState(
            userBalance!.message!,
          ));
        }
      }).catchError((error) {
        debugPrint(error.toString());
        emit(GetUserBalanceErrorState(
          error.toString(),
        ));
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  //Get user data
  UserModel? userModel;
  void getProfileData() {
    emit(ProfileLoadingState());
    try {
      Api.get(
        path: PROFILE,
        data: {
          'api_token': TOKEN,
        },
      ).then((value) {
        userModel = UserModel.fromJson(value.data);
        if (userModel!.data!.name != null && userModel!.success == true) {
          emit(ProfileSuccessState(
            userModel!,
          ));
        } else {
          emit(ProfileErrorState(
            userModel!.message!,
          ));
        }
      }).catchError((error) {
        emit(ProfileErrorState(
          error.toString(),
        ));
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  //Get Nearby Markets
  NearbyMarkets? nearbyMarkets;
  void getNearbyMarkets() {
    emit(GetNearbyMarketsLoadingState());
    try {
      if (currentPosition != null) {
        Api.get(
          path: NEARBYMARKETS,
          data: {
            'myLat': currentPosition!.latitude,
            'myLon': currentPosition!.longitude,
          },
        ).then((value) {
          nearbyMarkets = NearbyMarkets.fromJson(value.data);
          emit(GetNearbyMarketsSuccessState(
            nearbyMarkets!,
          ));
          debugPrint(nearbyMarkets!.message);
          debugPrint('الطووووووووول${nearbyMarkets!.data!.length}');
        }).catchError((error) {
          debugPrint('ايرور$error');
        });
      } else {
        getLocation();
      }
    } catch (e) {
      debugPrint('errooorrr$e');
    }
  }

  //Get popular markets
  NearbyMarkets? popularMarkets;
  void getPopularMarkets() {
    emit(GetPopularMarketsLoadingState());
    try {
      if (currentPosition != null) {
        Api.get(
          path: NEARBYMARKETS,
          data: {
            'myLat': currentPosition!.latitude,
            'myLon': currentPosition!.longitude,
            'rate_order_by': true,
            'order_by_type': 'asc',
          },
        ).then((value) {
          popularMarkets = NearbyMarkets.fromJson(value.data);
          emit(GetPopularMarketsSuccessState(
            popularMarkets!,
          ));
          debugPrint(popularMarkets!.message);
          debugPrint('الطووووووووول${popularMarkets!.data!.length}');
        }).catchError((error) {
          debugPrint('ايرور$error');
        });
      } else {
        getLocation();
      }
    } catch (e) {
      debugPrint('errooorrr$e');
    }
  }

//change lang header when press button
  bool isEn = true;
  void changeLang() {
    if (isEn) {
      CacheHelper.removeData(key: 'lang');
      CacheHelper.saveData(key: 'lang', value: 'en').then((value) {
        if (value!) {
          getProfileData();
          getUserBalance();
          getPopularMarkets();
          getNearbyMarkets();
          emit(ChangeLocaleState());
        }
      });
    } else {
      CacheHelper.removeData(key: 'lang');
      CacheHelper.saveData(key: 'lang', value: 'ar').then((value) {
        if (value!) {
          getProfileData();
          getUserBalance();
          getPopularMarkets();
          getNearbyMarkets();
          emit(ChangeLocaleState());
        }
      });
    }
  }

//refresh funiction
  Future<void> refresh() {
    emit(RefreshLoadingState());
    return Future.delayed(
      const Duration(seconds: 2),
      () {
        getProfileData();
        getUserBalance();
        getPopularMarkets();
        getNearbyMarkets();
        emit(RefreshLoadedState());
      },
    );
  }
}
