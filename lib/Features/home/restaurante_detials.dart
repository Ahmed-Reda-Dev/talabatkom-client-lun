import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';
import 'package:lun_talabaty_app/Features/search/search_screen.dart';
import 'package:sizer/sizer.dart';

class RestaurantDetails extends StatefulWidget {
  const RestaurantDetails({super.key});

  @override
  State<RestaurantDetails> createState() => _RestaurantDetailsState();
}

class _RestaurantDetailsState extends State<RestaurantDetails> {
  HexColor color1 = HexColor('#F5504C');
  HexColor color2 = HexColor('#F2F5F7');
  HexColor color3 = HexColor('#F2F5F7');
  HexColor color4 = HexColor('#F2F5F7');
  HexColor color5 = HexColor('#F2F5F7');

  final itemKey = GlobalKey();

  Future scrollToItem() async {
    final context = itemKey.currentContext!;
    await Scrollable.ensureVisible(
      context,
      duration: const Duration(seconds: 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#F2F5F7'),
      appBar: AppBar(
        backgroundColor: HexColor('#F2F5F7'),
        elevation: 0,
        title: Text(
          'Restaurant Details',
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w900,
          ),
        ),
        centerTitle: true,
        leadingWidth: 25.w,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 22.sp,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        actions: [
          GestureDetector(
            onTap: () => Get.to(() => const SearchScreen()),
            child: Container(
              //height: .h,
              width: 15.w,
              margin: EdgeInsets.only(right: 5.w, bottom: 0.5.h),

              padding: EdgeInsets.all(3.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.w),
              ),
              child: SvgPicture.asset(
                'assets/svg/search.svg',
                width: 20.sp,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 40.h,
              child: Stack(
                children: [
                  SizedBox(
                    height: 25.h,
                    width: double.infinity,
                    //image
                    child: Image.asset(
                      'assets/images/food.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 5.w),
                      height: 20.h,
                      padding: EdgeInsets.all(5.w),
                      decoration: BoxDecoration(
                        color: HexColor('#F2F5F7'),
                        borderRadius: BorderRadius.circular(5.w),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5.w),
                            child: Image.asset(
                              'assets/images/icon.jpg',
                              width: 25.w,
                              height: 12.h,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            width: 4.w,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Restaurant Name',
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w900,
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
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: TextButton(
                                      onPressed: () {},
                                      child: Text(
                                        'Burgers',
                                        style: TextStyle(
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w900,
                                          color: HexColor('#363537'),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 2.5.w,
                                  ),
                                  Container(
                                    height: 4.h,
                                    width: 23.w,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: TextButton(
                                      onPressed: () {},
                                      child: Text(
                                        'Tasty',
                                        style: TextStyle(
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w900,
                                          color: HexColor('#363537'),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Spacer(),
                          Container(
                            height: 7.h,
                            width: 15.w,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              //strong inner shadow effect for contianer
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.grey,
                                  spreadRadius: -5,
                                  blurRadius: 50,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: const Icon(Icons.menu_book_outlined),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 30.w,
                  height: 15.h,
                  child: Card(
                    elevation: 10,
                    color: Colors.red.withOpacity(0.8),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.w),
                    ),
                    child: Column(
                      children: [
                        LottieBuilder.asset(
                          'assets/lottie/hot.json',
                          width: 20.w,
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Text(
                          'Hot Offers',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 30.w,
                  height: 15.h,
                  child: Card(
                    elevation: 10,
                    color: Colors.white,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.w),
                    ),
                    child: Column(
                      children: [
                        SvgPicture.asset('assets/svg/stars.svg', width: 13.w),
                        SizedBox(
                          height: 1.h,
                        ),
                        Text(
                          'Rating',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w900,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          '4.5 star',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w900,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 7.w),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          color1 = HexColor('#F5504C');
                          color2 = HexColor('F2F5F7');
                          color3 = HexColor('F2F5F7');
                          color4 = HexColor('F2F5F7');
                          color5 = HexColor('F2F5F7');
                        });
                      },
                      child: Column(
                        children: [
                          Text(
                            'Most selling',
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Container(
                            height: 0.5.h,
                            width: 20.w,
                            decoration: BoxDecoration(
                              color: color1,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: GestureDetector(
                        onTap: () {
                          scrollToItem();
                          setState(() {
                            color2 = HexColor('#F5504C');
                            color1 = HexColor('F2F5F7');
                            color3 = HexColor('F2F5F7');
                            color4 = HexColor('F2F5F7');
                            color5 = HexColor('F2F5F7');
                          });
                        },
                        child: Column(
                          children: [
                            Text(
                              'Salads',
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Container(
                              height: 0.5.h,
                              width: 20.w,
                              decoration: BoxDecoration(
                                color: color2,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          color3 = HexColor('#F5504C');
                          color1 = HexColor('F2F5F7');
                          color2 = HexColor('F2F5F7');
                          color4 = HexColor('F2F5F7');
                          color5 = HexColor('F2F5F7');
                        });
                      },
                      child: Column(
                        children: [
                          Text(
                            'Ramdan offers',
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Container(
                            height: 0.5.h,
                            width: 20.w,
                            decoration: BoxDecoration(
                              color: color3,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                color4 = HexColor('#F5504C');
                                color1 = HexColor('F2F5F7');
                                color3 = HexColor('F2F5F7');
                                color2 = HexColor('F2F5F7');
                                color5 = HexColor('F2F5F7');
                              });
                            },
                            child: Text(
                              'Sandwitches',
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Container(
                            height: 0.5.h,
                            width: 20.w,
                            decoration: BoxDecoration(
                              color: color4,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          color5 = HexColor('#F5504C');
                          color1 = HexColor('F2F5F7');
                          color3 = HexColor('F2F5F7');
                          color4 = HexColor('F2F5F7');
                          color2 = HexColor('F2F5F7');
                        });
                      },
                      child: Column(
                        children: [
                          Text(
                            'Meals',
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Container(
                            height: 0.5.h,
                            width: 20.w,
                            decoration: BoxDecoration(
                              color: color5,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 7.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Most Selling',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => itemsBuilder(),
                    separatorBuilder: (context, index) => SizedBox(height: 3.h),
                    itemCount: 5,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 3.h),
                    child: Text(
                      key: itemKey,
                      'Salads',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => itemsBuilder(),
                    separatorBuilder: (context, index) => SizedBox(height: 3.h),
                    itemCount: 5,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget itemsBuilder() {
    return Container(
      height: 25.h,
      width: 100.w,
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              'assets/images/icon.jpg',
              height: 17.h,
              width: 27.w,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            width: 3.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 3.h,
              ),
              Text(
                'Chicken Burger',
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Text(
                'Half Chicken, rice , vegetables',
                style: TextStyle(
                  fontSize: 11.sp,
                  color: Colors.grey.withOpacity(0.8),
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Row(
                children: [
                  SizedBox(
                    height: 3.5.h,
                    width: 4.h,
                    //padding: EdgeInsets.all(1.w),
                    child: SvgPicture.asset(
                      'assets/svg/cal.svg',
                    ),
                  ),
                  SizedBox(
                    width: 1.w,
                  ),
                  Text(
                    '30',
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    width: 1.w,
                  ),
                  Text('calroies',
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: Colors.grey.withOpacity(0.8),
                      )),
                ],
              ),
              const Spacer(),
              Text(
                '87.00 R.S',
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w900,
                  color: HexColor('#F5504C'),
                ),
              ),
              SizedBox(
                height: 4.h,
              ),
            ],
          ),
          const Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 3.h,
              ),
              Container(
                height: 5.h,
                width: 10.w,
                padding: EdgeInsets.all(1.w),
                child: Image.asset(
                  'assets/images/Like.png',
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
              Container(
                height: 5.h,
                width: 5.h,
                decoration: BoxDecoration(
                  color: HexColor('#EDEDF4'),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Icon(
                    Icons.add_rounded,
                    color: HexColor('#F5504C'),
                    size: 25.sp,
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
