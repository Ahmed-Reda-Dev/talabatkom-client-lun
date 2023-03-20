import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#F5F5F5'),
      appBar: AppBar(
        backgroundColor: HexColor('#F5F5F5'),
        elevation: 0,
        leading: Container(),
        leadingWidth: 0,
        title: Row(
          children: [
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Search your favorite restaurant...',
                  hintStyle: TextStyle(
                    color: HexColor('#363537').withOpacity(0.5),
                    fontSize: 12.sp,
                  ),
                  border: InputBorder.none,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: HexColor('#363537').withOpacity(0.0),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: HexColor('#363537').withOpacity(0.0),
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: Container(
                    padding: const EdgeInsets.all(10),
                    child: SvgPicture.asset(
                      'assets/svg/search.svg',
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 2.w),
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Container(
                height: 6.5.h,
                width: 6.5.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(
                  Icons.close,
                  size: 27.sp,
                ),
              ),
            ),
          ],
        ),
      ),
      //tab bar with 2 tabs
      body: DefaultTabController(
        animationDuration: const Duration(milliseconds: 300),
        length: 2,
        child: Column(
          children: [
            Container(
              color: HexColor('#F5F5F5'),
              child: TabBar(
                padding: EdgeInsets.symmetric(
                  horizontal: 28.w,
                  vertical: 1.h,
                ),
                indicatorColor: Colors.transparent,
                labelColor: HexColor('#F5504C'),
                unselectedLabelColor: HexColor('#363537').withOpacity(0.5),
                labelStyle: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                ),
                tabs: [
                  Tab(
                    child: Text(
                      'Restaurants',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Dishes',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                physics: const BouncingScrollPhysics(),
                children: [
                  //tab 1
                  ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) => restaurantsItemBuilder(),
                    separatorBuilder: (context, index) =>
                        SizedBox(height: 2.5.h),
                    itemCount: 10,
                  ),
                  //tab 2
                  ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) => dishesItemBuilder(),
                    separatorBuilder: (context, index) =>
                        SizedBox(height: 2.5.h),
                    itemCount: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container restaurantsItemBuilder() {
    return Container(
      height: 15.h,
      width: 100.w,
      margin: EdgeInsets.symmetric(
        horizontal: 5.w,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 7.w,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            height: 10.h,
            width: 10.h,
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage(
                  'assets/images/icon.jpg',
                ),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          SizedBox(width: 3.w),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Buffalo Burger',
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 0.5.h),
              Row(
                children: [
                  Container(
                    height: 4.h,
                    width: 19.w,
                    decoration: BoxDecoration(
                      color: HexColor('#EDEDF4'),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Burgers',
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w600,
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
                    width: 19.w,
                    decoration: BoxDecoration(
                      color: HexColor('#EDEDF4'),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Tasty',
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w600,
                          color: HexColor('#363537'),
                        ),
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

  Widget dishesItemBuilder() {
    return Container(
      height: 15.h,
      width: 100.w,
      margin: EdgeInsets.symmetric(
        horizontal: 5.w,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 7.w,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            height: 10.h,
            width: 10.h,
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage(
                  'assets/images/icon.jpg',
                ),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          SizedBox(width: 3.w),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Buffalo Burger',
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 0.5.h),
              Row(
                children: [
                  Container(
                    height: 4.h,
                    width: 19.w,
                    decoration: BoxDecoration(
                      color: HexColor('#EDEDF4'),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Burgers',
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w600,
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
                    width: 19.w,
                    decoration: BoxDecoration(
                      color: HexColor('#EDEDF4'),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Tasty',
                        style: TextStyle(
                          fontSize: 10.sp,
                          //height: 0.9,
                          fontWeight: FontWeight.w600,
                          color: HexColor('#363537'),
                        ),
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
}
