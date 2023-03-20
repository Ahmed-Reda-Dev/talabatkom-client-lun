import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lun_talabaty_app/share/cubit/cubit.dart';
import 'package:sizer/sizer.dart';

import '../../../share/cubit/states.dart';
import '../../../share/locale/cache_helper.dart';
import '../../register&login/login_screen.dart';

class DrawerMenu extends StatelessWidget {
  final ValueSetter setIndex;
  const DrawerMenu({Key? key, required this.setIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(
      builder: (context, state) {
        final cubit = AppCubit.get(context);
        return Padding(
          padding: EdgeInsets.all(2.w),
          child: SafeArea(
            child: SizedBox(
              width: 100.w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 3.w, vertical: 7.h),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 20.0.sp,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.person,
                            //size using sizer
                            size: 30.sp,
                          ),
                        ),
                        //wait until name is available
                        state == ProfileLoadingState()
                            ? Container()
                            : Container(
                                width: 45.w,
                                padding: EdgeInsets.only(left: 3.w),
                                child: Text(
                                  cubit.userModel!.data!.name!,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 2.0.h,
                  ),
                  Column(
                    children: [
                      drawerMenuItem(
                          Container(
                            height: 7.h,
                            width: 15.w,
                            padding: EdgeInsets.all(3.7.w),
                            child: SvgPicture.asset(
                              'assets/svg/drawer/home.svg',
                              width: 5.w,
                              height: 5.h,
                            ),
                          ),
                          'Home',
                          0),
                      //my orders
                      drawerMenuItem(
                          Container(
                              height: 7.h,
                              width: 15.w,
                              padding: EdgeInsets.all(3.7.w),
                              child: SvgPicture.asset(
                                  'assets/svg/drawer/order.svg')),
                          'My Orders',
                          1),
                      //my walletes
                      drawerMenuItem(
                          Container(
                              height: 7.h,
                              width: 15.w,
                              padding: EdgeInsets.all(3.7.w),
                              child: SvgPicture.asset(
                                  'assets/svg/drawer/wallet.svg')),
                          'My Wallet',
                          2),
                      //offers
                      drawerMenuItem(
                          Container(
                              height: 7.h,
                              width: 15.w,
                              padding: EdgeInsets.all(3.7.w),
                              child: SvgPicture.asset(
                                  'assets/svg/drawer/offers.svg')),
                          'Offers',
                          3),
                      // notifications
                      drawerMenuItem(
                          Container(
                              height: 7.h,
                              width: 15.w,
                              padding: EdgeInsets.all(3.7.w),
                              child: SvgPicture.asset(
                                  'assets/svg/drawer/notification.svg')),
                          'Notifications',
                          4),
                      //about
                      drawerMenuItem(
                          Container(
                              height: 7.h,
                              width: 15.w,
                              padding: EdgeInsets.all(3.7.w),
                              child: SvgPicture.asset(
                                  'assets/svg/drawer/about.svg')),
                          'About',
                          5),
                      //Privacy Policy
                      drawerMenuItem(
                          Container(
                              height: 7.h,
                              width: 15.w,
                              padding: EdgeInsets.all(3.7.w),
                              child: SvgPicture.asset(
                                  'assets/svg/drawer/privacy.svg')),
                          'Privacy Policy',
                          6),
                      //Contact Us
                      drawerMenuItem(
                          Container(
                              height: 7.h,
                              width: 15.w,
                              padding: EdgeInsets.all(3.7.w),
                              child: SvgPicture.asset(
                                  'assets/svg/drawer/contactus.svg')),
                          'Contact Us',
                          7),
                      //FAQs
                      drawerMenuItem(
                          Container(
                              height: 7.h,
                              width: 15.w,
                              padding: EdgeInsets.all(3.7.w),
                              child: SvgPicture.asset(
                                  'assets/svg/drawer/faq.svg')),
                          'FAQ',
                          8),
                    ],
                  ),
                  SizedBox(
                    height: 2.0.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        'assets/svg/drawer/settings.svg',
                        width: 5.w,
                        height: 3.5.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 3.w),
                        child: Text(
                          'Settings |',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          CacheHelper.removeData(key: 'token').then((value) {
                            Get.offAll(() => const LoginScreen());
                          });
                        },
                        child: Padding(
                          padding: EdgeInsets.only(left: 3.w),
                          child: Text(
                            'Logout\t\t\t',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Version 2.0.10',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      Image.asset(
                        'assets/images/logo.png',
                        width: 12.w,
                        height: 7.h,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget drawerMenuItem(Widget myWidget, String title, int index) {
    return ListTile(
      leading: myWidget,

      minLeadingWidth: 0.0,
      title: Text(
        title,
        style: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
      // onTap: () {
      //   widget.setIndex(index);
      // },
    );
  }
}
