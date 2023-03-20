import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';
import 'package:lun_talabaty_app/Features/custom/custom_loading.dart';
import 'package:lun_talabaty_app/Features/home/restaurante_detials.dart';
import 'package:lun_talabaty_app/Features/map/map_screen.dart';
import 'package:lun_talabaty_app/core/home/nearby%20markets/model/nearby_markets.dart';
import 'package:lun_talabaty_app/share/cubit/cubit.dart';
import 'package:lun_talabaty_app/share/cubit/states.dart';
import 'package:sizer/sizer.dart';

import '../search/search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isInternet = true;
  late StreamSubscription<ConnectivityResult> _subscription;

  @override
  initState() {
    super.initState();
    requestPermission();
    _subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        setState(() {
          isInternet = false;
        });
      } else {
        setState(() {
          isInternet = true;
        });
        AppCubit.get(context).refresh();
      }
    });
  }

  //using the "mounted" getter to determine if the State is still active

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  void requestPermission() async {
    await Geolocator.requestPermission().then((value) => {
          if (value == LocationPermission.always ||
              value == LocationPermission.whileInUse)
            {
              _refresh(),
            }
        });
  }

  Future _refresh() async {
    AppCubit.get(context)
        .getLocation()
        .then((value) => {
              AppCubit.get(context).getNearbyMarkets(),
              AppCubit.get(context).getPopularMarkets(),
              AppCubit.get(context).getUserBalance(),
            })
        .catchError((error) {
      if (kDebugMode) {
        print(error);
      }
      return error;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = AppCubit.get(context);
        return isInternet
            ? Scaffold(
                backgroundColor: HexColor('#F2F5F7'),
                appBar: AppBar(
                  backgroundColor: HexColor('#F2F5F7'),
                  elevation: 0,
                  leading: Container(),
                  leadingWidth: 0,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 5.h,
                        width: 12.w,
                        padding: EdgeInsets.all(2.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: GestureDetector(
                          onTap: () => ZoomDrawer.of(context)!.toggle(),
                          child: SvgPicture.asset(
                            'assets/svg/drawer.svg',
                            width: 2.w,
                            height: 2.h,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.bottomSheet(
                            barrierColor: Colors.transparent,
                            elevation: 10,
                            BlocBuilder<AppCubit, AppStates>(
                              builder: (context, state) => Container(
                                height: 52.h,
                                width: 100.w,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 5.w,
                                  vertical: 2.h,
                                ),
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                  color: HexColor('#F2F5F7'),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Choose Your Location',
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w900,
                                        color: HexColor('#363537'),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    SizedBox(
                                      height: 28.h,
                                      child: ListView.separated(
                                        itemCount: 5,
                                        separatorBuilder: (context, index) =>
                                            SizedBox(
                                          height: 2.h,
                                        ),
                                        itemBuilder: (context, index) =>
                                            GestureDetector(
                                          onTap: () {
                                            cubit.changeSelectedListButton(
                                                index);
                                          },
                                          child: Container(
                                            height: 12.h,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 5.w, vertical: 2.h),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.location_on,
                                                  color: HexColor('#F5504C'),
                                                  size: 20.sp,
                                                ),
                                                SizedBox(
                                                  width: 3.w,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Text(
                                                      'Maadi, El-Salam',
                                                      style: TextStyle(
                                                        fontSize: 15.sp,
                                                        fontWeight:
                                                            FontWeight.w900,
                                                      ),
                                                    ),
                                                    Text(
                                                      '4 st el slam name of address',
                                                      style: TextStyle(
                                                        fontSize: 13.sp,
                                                        color: HexColor(
                                                                '#363537')
                                                            .withOpacity(0.5),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const Spacer(),
                                                Radio(
                                                  value: index,
                                                  groupValue:
                                                      cubit.selectedListButton,
                                                  activeColor:
                                                      HexColor('#F5504C'),
                                                  onChanged: (value) {
                                                    cubit
                                                        .changeSelectedListButton(
                                                            value!);
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    GestureDetector(
                                      onTap: () =>
                                          Get.to(() => const MapScreen()),
                                      child: Container(
                                        height: 12.h,
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 5.w,
                                          vertical: 2.h,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.location_on,
                                              color: HexColor('#F5504C'),
                                              size: 20.sp,
                                            ),
                                            SizedBox(
                                              width: 3.w,
                                            ),
                                            Text(
                                              'Deliver To Current Location',
                                              style: TextStyle(
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.w900,
                                                color: HexColor('#F5504C'),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.location_on,
                              color: HexColor('#F5504C'),
                              size: 20.sp,
                            ),
                            SizedBox(
                              width: 1.w,
                            ),
                            Column(
                              children: [
                                Text(
                                  'Current Location',
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    color: HexColor('#363537'),
                                  ),
                                ),
                                state is GetUserLocationLoadingState
                                    ? Center(
                                        child: CustomLoadingIndicator(
                                          color: HexColor('#F5504C'),
                                        ),
                                      )
                                    : SizedBox(
                                        width: 50.w,
                                        child: Text(
                                          //print current location
                                          cubit.formattedAddress,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 13.sp,
                                            color: HexColor('#363537'),
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                            Icon(
                              Icons.keyboard_arrow_down,
                              color: HexColor('#363537'),
                              size: 20.sp,
                            ),
                          ],
                        ),
                      ),
                      //locale button to change language when click on it
                      GestureDetector(
                        onTap: () {
                          cubit.isEn = !cubit.isEn;
                          cubit.changeLang();
                        },
                        child: Container(
                          height: 5.h,
                          width: 12.w,
                          padding: EdgeInsets.all(2.w),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Icon(
                            Icons.language,
                            color: HexColor('#F5504C'),
                            size: 20.sp,
                          ),
                        ),
                      ),

                      GestureDetector(
                        onTap: () {
                          Get.to(() => const SearchScreen());
                        },
                        child: Container(
                          height: 5.h,
                          width: 12.w,
                          padding: EdgeInsets.all(2.w),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: SvgPicture.asset(
                            'assets/svg/search.svg',
                            width: 5.w,
                            height: 5.h,
                            //color: HexColor('#F5504C'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                body: RefreshIndicator(
                  onRefresh: () async {
                    cubit.refresh();
                  },
                  child: state is RefreshLoadingState
                      ? Center(
                          child: CustomLoadingIndicator(
                            color: HexColor('#F5504C'),
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                          child: ScrollConfiguration(
                            behavior: const ScrollBehavior(),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  state is GetUserLocationLoadingState
                                      ? Center(
                                          child: CustomLoadingIndicator(
                                            color: HexColor('#F5504C'),
                                          ),
                                        )
                                      : myBalance(
                                          Text(
                                            cubit.userBalanceValue,
                                            style: TextStyle(
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                          state,
                                        ),
                                  Text(
                                    'Receive Method',
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                      color: HexColor('#363537'),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          cubit.changeSelectedListButton(0);
                                        },
                                        child: myRadio(
                                            selectedButton:
                                                cubit.selectedButton,
                                            asset: 'assets/svg/pickup.svg',
                                            text: 'Pickup',
                                            value: 0,
                                            onTap: (value) {
                                              cubit.changeSelectedListButton(
                                                  value!);
                                            }),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          cubit.changeSelectedListButton(1);
                                        },
                                        child: myRadio(
                                            selectedButton:
                                                cubit.selectedButton,
                                            asset: 'assets/svg/Delivery.svg',
                                            text: 'Delivery',
                                            value: 1,
                                            onTap: (value) {
                                              cubit.changeSelectedListButton(
                                                  value!);
                                            }),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 3.h),
                                    child: Text(
                                      'Last Orders',
                                      style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold,
                                        color: HexColor('#363537'),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.2.h,
                                    child: ListView.separated(
                                      scrollDirection: Axis.horizontal,
                                      physics: const BouncingScrollPhysics(),
                                      itemBuilder: (context, index) =>
                                          orderItemBuilder(),
                                      separatorBuilder: (context, index) =>
                                          SizedBox(
                                        width: 5.w,
                                      ),
                                      itemCount: 5,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 2.h),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Nearby',
                                          style: TextStyle(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.bold,
                                            color: HexColor('#363537'),
                                          ),
                                        ),
                                        const Spacer(),
                                        TextButton(
                                          onPressed: () {},
                                          child: Text(
                                            'View All',
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.bold,
                                              color: HexColor('#F5504C'),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  state is GetNearbyMarketsLoadingState
                                      ? Center(
                                          child: CustomLoadingIndicator(
                                            color: HexColor('#F5504C'),
                                          ),
                                        )
                                      : cubit.nearbyMarkets == null
                                          ? Center(
                                              child: CustomLoadingIndicator(
                                                color: HexColor('#F5504C'),
                                              ),
                                            )
                                          : ListView.separated(
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemBuilder: (context, index) =>
                                                  nearbyItemBuilder(
                                                cubit.nearbyMarkets!,
                                                index,
                                              ),
                                              separatorBuilder:
                                                  (context, index) => SizedBox(
                                                height: 2.h,
                                              ),
                                              itemCount: cubit
                                                  .nearbyMarkets!.data!.length,
                                            ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  cubit.popularMarkets == null
                                      ? Center(
                                          child: CustomLoadingIndicator(
                                            color: HexColor('#F5504C'),
                                          ),
                                        )
                                      : SizedBox(
                                          height: 40.h,
                                          child: ListView.separated(
                                            scrollDirection: Axis.horizontal,
                                            physics:
                                                const BouncingScrollPhysics(),
                                            itemBuilder: (context, index) =>
                                                featuresItemBuilder(
                                              cubit.popularMarkets!,
                                              index,
                                            ),
                                            separatorBuilder:
                                                (context, index) => SizedBox(
                                              width: 5.w,
                                            ),
                                            itemCount: 5,
                                          ),
                                        ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                ),
                floatingActionButton: Stack(
                  children: [
                    FloatingActionButton(
                      onPressed: () {},
                      backgroundColor: HexColor('#F5504C'),
                      child: SvgPicture.asset(
                        'assets/svg/bag.svg',
                        height: 4.2.h,
                      ),
                    ),
                    Positioned(
                      right: 0,
                      child: CircleAvatar(
                        radius: 7.sp,
                        backgroundColor: Colors.white,
                        child: Badge.count(
                          backgroundColor: HexColor('#F5504C'),
                          count: 2,
                        ),
                      ),
                    )
                  ],
                ),
              )
            : Scaffold(
                body: Center(
                  child: LottieBuilder.asset(
                    'assets/lottie/no-internet.json',
                    //height: 200,
                    width: double.infinity,
                    fit: BoxFit.fill,
                    repeat: true,
                    reverse: true,
                    animate: true,
                  ),
                ),
              );
      },
    );
  }

  Widget featuresItemBuilder(NearbyMarkets popularMarkets, int index) {
    return Container(
      height: 40.h,
      width: 80.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: popularMarkets.data![index].hasMedia!
                ? Image.network(
                    popularMarkets.data![index].media![0].thumb!,
                    height: 20.h,
                    width: 80.w,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    'assets/images/food.jpg',
                    height: 20.h,
                    width: 80.w,
                    fit: BoxFit.cover,
                  ),
          ),
          Container(
            height: 18.h,
            width: 80.w,
            padding: EdgeInsets.all(3.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(27),
            ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 8.h,
                      width: 18.w,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: ClipRect(
                        child: popularMarkets.data![index].hasMedia!
                            ? Image.network(
                                popularMarkets.data![index].media![0].icon!,
                                height: 8.h,
                                width: 18.w,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                'assets/images/icon.jpg',
                                height: 8.h,
                                width: 18.w,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    SizedBox(
                      width: 3.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      //mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          popularMarkets.data![index].name!,
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w900,
                            color: HexColor('#363537'),
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 4.h,
                              width: 18.w,
                              decoration: BoxDecoration(
                                color: HexColor('#EDEDF4'),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                popularMarkets.data![index].tags![0].name!,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w900,
                                  color: HexColor('#363537'),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 2.5.w,
                            ),
                            popularMarkets.data![index].tags!.length > 1
                                ? Container(
                                    height: 4.h,
                                    width: 18.w,
                                    decoration: BoxDecoration(
                                      color: HexColor('#EDEDF4'),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      'Tasty',
                                      style: TextStyle(
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w900,
                                        color: HexColor('#363537'),
                                      ),
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/svg/stars.svg',
                          height: 3.h,
                        ),
                        SizedBox(
                          width: 2.w,
                        ),
                        Text(
                          '${popularMarkets.data![index].rate!}Rating',
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w700,
                            color: HexColor('#363537'),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/svg/table.svg',
                          height: 2.h,
                        ),
                        SizedBox(
                          width: 2.w,
                        ),
                        Text(
                          '${popularMarkets.data![index].numTable} Table',
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w700,
                            color: HexColor('#363537'),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Image.asset('assets/images/timer.png',
                            height: 4.h, width: 6.w),
                        SizedBox(
                          width: 2.w,
                        ),
                        Text(
                          '${popularMarkets.data![index].avgDeliveryTime} min',
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w700,
                            color: HexColor('#363537'),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget nearbyItemBuilder(NearbyMarkets nearbyMarkets, int index) {
    return GestureDetector(
      onTap: () => Get.to(() => const RestaurantDetails()),
      child: Container(
        height: 22.h,
        width: 102.w,
        padding: EdgeInsets.all(5.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(27),
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 11.h,
                  width: 25.w,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: nearbyMarkets.data![index].hasMedia!
                      ? nearbyMarkets.data![index].media![0].customProperties!
                              .generatedConversions!.thumb!
                          ? ClipRRect(
                              clipBehavior: Clip.antiAlias,
                              borderRadius: BorderRadius.circular(25),
                              child: Image.network(
                                nearbyMarkets.data![index].media![0].thumb!,
                                fit: BoxFit.cover,
                              ),
                            )
                          : ClipRRect(
                              clipBehavior: Clip.antiAlias,
                              borderRadius: BorderRadius.circular(25),
                              child: Image.network(
                                nearbyMarkets.data![index].media![1].icon!,
                                fit: BoxFit.cover,
                              ),
                            )
                      : ClipRRect(
                          clipBehavior: Clip.antiAlias,
                          borderRadius: BorderRadius.circular(25),
                          child: Image.asset(
                            'assets/images/icon.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
                SizedBox(
                  width: 3.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  //mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 50.w,
                      child: Text(
                        nearbyMarkets.data![index].name!,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w900,
                          color: HexColor('#363537'),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Row(
                      children: [
                        Container(
                          height: 4.h,
                          width: 23.w,
                          padding: EdgeInsets.symmetric(horizontal: 2.w),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: HexColor('#EDEDF4'),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            nearbyMarkets.data![index].tags![0].name!,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w900,
                              color: HexColor('#363537'),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 2.5.w,
                        ),
                        nearbyMarkets.data![index].tags!.length > 1
                            ? Container(
                                height: 4.h,
                                width: 23.w,
                                decoration: BoxDecoration(
                                  color: HexColor('#EDEDF4'),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    nearbyMarkets.data![index].tags![1].name!,
                                    style: TextStyle(
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w900,
                                      color: HexColor('#363537'),
                                    ),
                                  ),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 5.h,
                      width: 10.w,
                      padding: EdgeInsets.all(1.w),
                      decoration: BoxDecoration(
                        color: HexColor('#EDEDF4'),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Image.asset(
                        'assets/images/Like.png',
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Container(
                      height: 5.h,
                      width: 10.w,
                      padding: EdgeInsets.all(1.w),
                      decoration: BoxDecoration(
                        color: HexColor('#EDEDF4'),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Image.asset(
                        'assets/images/qr.png',
                        height: 5.h,
                        width: 12.w,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/svg/stars.svg',
                      height: 4.h,
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    Text(
                      '${nearbyMarkets.data![index].rate!} Rating',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                        color: HexColor('#363537'),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/svg/table.svg',
                      height: 3.h,
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    Text(
                      '${nearbyMarkets.data![index].numTable!} Table',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                        color: HexColor('#363537'),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Image.asset('assets/images/timer.png',
                        height: 4.h, width: 8.w),
                    SizedBox(
                      width: 2.w,
                    ),
                    Text(
                      '${nearbyMarkets.data![index].avgDeliveryTime!} min',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                        color: HexColor('#363537'),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 2.w,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget orderItemBuilder() {
    return Container(
      height: 20.h,
      width: 86.w,
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(27),
      ),
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                height: 11.h,
                width: 25.2.w,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(30),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/icon.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                height: 3.h,
                width: 20.w,
                margin: EdgeInsets.only(top: 1.2.h),
                decoration: BoxDecoration(
                  color: HexColor('#31EA5C33'),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: HexColor('#31EA5C'),
                  ),
                ),
                child: Center(
                  child: Text(
                    'Delivered',
                    style: TextStyle(
                      fontSize: 9.sp,
                      color: HexColor('#31EA5C'),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            width: 2.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Buffalo Burger',
                style: TextStyle(
                  fontSize: 13.sp,
                  color: HexColor('#363537'),
                  fontWeight: FontWeight.w900,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 1.5.h),
                child: Text(
                  '250.00 RS',
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: HexColor('#363537'),
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              Text(
                '1 X Half grilled chicken, +2 more',
                style: TextStyle(
                  fontSize: 9.sp,
                  color: HexColor('#363537'),
                  //fontWeight: FontWeight.w900,
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 4.h,
                      width: 25.w,
                      margin: EdgeInsets.only(top: 1.2.h),
                      padding: EdgeInsets.symmetric(horizontal: 2.5.w),
                      decoration: BoxDecoration(
                        color: HexColor('#EDEDF4'),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SvgPicture.asset(
                            'assets/svg/round_arrow.svg',
                            height: 2.h,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 1),
                            child: Text(
                              'Re - order',
                              style: TextStyle(
                                fontSize: 9.sp,
                                color: HexColor('#363537'),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 4.h,
                      width: 25.w,
                      margin: EdgeInsets.only(top: 1.2.h),
                      padding: EdgeInsets.symmetric(horizontal: 2.5.w),
                      decoration: BoxDecoration(
                        color: HexColor('#EDEDF4'),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SvgPicture.asset(
                            'assets/svg/hand.svg',
                            height: 2.h,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 1),
                            child: Text(
                              'Rate order',
                              style: TextStyle(
                                fontSize: 8.sp,
                                color: HexColor('#363537'),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget myRadio({
    required int selectedButton,
    required String asset,
    required String text,
    required Function(int?)? onTap,
    required int value,
  }) {
    return Container(
      height: 7.h,
      width: 50.w,
      padding: EdgeInsets.all(5.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            asset,
            fit: BoxFit.cover,
          ),
          SizedBox(
            width: 2.w,
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: 12.sp,
              color: HexColor('#363537'),
            ),
          ),
          const Spacer(),
          Radio(
            value: value,
            groupValue: selectedButton,
            onChanged: onTap,
            activeColor: HexColor('#F5504C'),
          ),
        ],
      ),
    );
  }

  Widget myBalance(Widget balance, AppStates state) {
    return state is GetUserBalanceLoadingState
        ? CustomLoadingIndicator(
            color: HexColor('#F5504C'),
          )
        : SizedBox(
            height: 25.h,
            width: 200.w,
            child: Stack(
              children: [
                Positioned(
                  top: 9.h,
                  left: 5.w,
                  right: 5.w,
                  child: Container(
                    height: 12.7.h,
                    width: 50.w,
                    decoration: BoxDecoration(
                      color: HexColor('#F5504C').withOpacity(0.2),
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
                Positioned(
                  top: 5.h,
                  child: Container(
                    height: 15.h,
                    width: 105.w,
                    padding: EdgeInsets.all(5.w),
                    decoration: BoxDecoration(
                      color: HexColor('#F5504C'),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 20.w,
                          height: 15.h,
                          child: Stack(
                            children: [
                              Positioned(
                                bottom: 5,
                                child: Container(
                                  height: 5.h,
                                  width: 20.w,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                              ),
                              Center(
                                child: SizedBox(
                                  width: 15.w,
                                  height: 15.h,
                                  child: SvgPicture.asset(
                                    'assets/svg/money.svg',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 4.w,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Available Credit in Wallet',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Row(
                              children: [
                                balance,
                                Text(
                                  ' SAR',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}

//myBehavior
