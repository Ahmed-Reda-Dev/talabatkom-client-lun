import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';
import 'package:lun_talabaty_app/Features/register&login/OTP_verification.dart';
import 'package:lun_talabaty_app/share/components/components.dart';
import 'package:sizer/sizer.dart';

class RecoverPassword extends StatefulWidget {
  const RecoverPassword({super.key});

  @override
  State<RecoverPassword> createState() => _RecoverPassword();
}

final _phoneTextController = TextEditingController();
final formKey = GlobalKey<FormState>();

class _RecoverPassword extends State<RecoverPassword> {
  late FlCountryCodePicker countryPicker = const FlCountryCodePicker();
  CountryCode? countryCode;

  @override
  void initState() {
    super.initState();
    countryPicker = const FlCountryCodePicker();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Form(
        key: formKey,
        child: Scaffold(
          backgroundColor: HexColor('#EDEDF4'),
          body: SafeArea(
            child: ScrollConfiguration(
              behavior: const ScrollBehavior(),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(4.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      logoComponent(
                        //context: context,
                        image: Center(
                          child: LottieBuilder.asset(
                            'assets/lottie/forget.json',
                            height: 30.h,
                          ),
                        ),
                        onTap: () => Get.back(),
                        title1: 'Reset Password',
                        subtitle1:
                            'You will receive 4 digit code for phone number verification.',
                      ),
                      myCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Phone Number',
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: HexColor('#707070'),
                              ),
                            ),
                            phoneWidget(
                              context: context,
                              phoneTextController: _phoneTextController,
                              countryCode: countryCode,
                              countryPicker: countryPicker,
                              setState: setState,
                              fieldWidth: 90.w,
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 6.h),
                              child: SizedBox(
                                width: 100.w,
                                height: 7.h,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      _phoneTextController.clear();
                                      Get.to(() => const OTPVerification());
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: HexColor('#F5504C'),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: Text(
                                    'Send OTP',
                                    style: TextStyle(
                                      color: HexColor('#EDEDF4'),
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 2.h),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Already have an account?',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: HexColor('#707070'),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: Text(
                                      'Login',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: HexColor('#F5504C'),
                                      ),
                                    ),
                                  ),
                                ],
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
        ),
      ),
    );
  }
}
