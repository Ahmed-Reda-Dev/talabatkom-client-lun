import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lun_talabaty_app/share/components/components.dart';
import 'package:sizer/sizer.dart';

class RegisterDetialScreen extends StatelessWidget {
  RegisterDetialScreen({super.key});

  final _nameTextController = TextEditingController();
  final _passTextController = TextEditingController();
  final _confirmPassTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#EDEDF4'),
      body: SafeArea(
        child: ScrollConfiguration(
          behavior: const ScrollBehavior(),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(4.h),
              child: Column(
                children: [
                  logoComponent(
                    isRow: true,
                    onTap: () => Get.back(),
                    image: Image.asset(
                      'assets/images/logo.png',
                      color: HexColor('#F5504C'),
                      height: 30.h,
                      width: 50.h,
                    ),
                    title1: 'Welcome To ',
                    title2: 'Talbatkom',
                    subtitle1: 'By creating an account you agree',
                    subtitle2: 'to the privacy policy and to the ',
                    subtitle3: 'terms of use.',
                  ),
                  myCard(
                    height: 53.h,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Username',
                          style: TextStyle(
                            color: HexColor('#707070'),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        myTextFormField(
                          textController: _nameTextController,
                          keyboardType: TextInputType.name,
                          hintText: 'Type your name',
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Text(
                          'Password',
                          style: TextStyle(
                            color: HexColor('#707070'),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        myTextFormField(
                          textController: _passTextController,
                          keyboardType: TextInputType.visiblePassword,
                          hintText: '••••••••',
                          suffixIcon: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.remove_red_eye),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your password';
                            } else if (value.length < 8) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Text(
                          'Confirm Password',
                          style: TextStyle(
                            color: HexColor('#707070'),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        myTextFormField(
                          textController: _confirmPassTextController,
                          keyboardType: TextInputType.visiblePassword,
                          hintText: '••••••••',
                          suffixIcon: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.remove_red_eye),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your password';
                            } else if (value.length < 8) {
                              return 'Password must be at least 6 characters';
                            } else if (value != _passTextController.text) {
                              return 'Password does not match';
                            }
                            return null;
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5.h),
                          child: SizedBox(
                            width: 100.w,
                            height: 7.h,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: HexColor('#F5504C'),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Text(
                                'Register',
                                style: TextStyle(
                                  color: HexColor('#EDEDF4'),
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
