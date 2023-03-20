import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';
import 'package:lun_talabaty_app/share/components/components.dart';
import 'package:lun_talabaty_app/Features/register&login/register_detial_screen.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:sizer/sizer.dart';

class OTPVerification extends StatefulWidget {
  const OTPVerification({super.key});

  @override
  State<OTPVerification> createState() => _OTPVerificationState();
}

final _otpController = OtpFieldController();
String otpValue = '';

class _OTPVerificationState extends State<OTPVerification> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: HexColor('#EDEDF4'),
        body: SafeArea(
            child: Padding(
          padding: EdgeInsets.all(4.h),
          child: ScrollConfiguration(
            behavior: const ScrollBehavior(),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  logoComponent(
                    onTap: () => Get.back(),
                    image: Center(
                      child: LottieBuilder.asset(
                        'assets/lottie/verfication.json',
                        fit: BoxFit.cover,
                        width: 30.h,
                        repeat: false,
                      ),
                    ),
                    title1: 'OTP Verification',
                    subtitle1:
                        'You will receive 4 digit code for phone number verification',
                  ),
                  myCard(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 2.h,
                        ),
                        OTPTextField(
                          controller: _otpController,
                          length: 4,
                          width: 80.w,
                          fieldWidth: 15.w,
                          otpFieldStyle: OtpFieldStyle(
                            backgroundColor: Colors.white,
                            borderColor: HexColor('##31EA5C'),
                            focusBorderColor: HexColor('##31EA5C'),
                            enabledBorderColor: HexColor('##31EA5C'),
                          ),
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                              fontSize: 15.sp, fontWeight: FontWeight.bold),
                          textFieldAlignment: MainAxisAlignment.spaceAround,
                          fieldStyle: FieldStyle.box,
                          onChanged: (value) => setState(() {
                            otpValue = value;
                          }),
                          onCompleted: (pin) {
                            setState(() {
                              otpValue = pin;
                            });
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 7.h),
                          child: SizedBox(
                            width: 100.w,
                            height: 7.h,
                            child: ElevatedButton(
                              onPressed: () {
                                if (otpValue.length == 4) {
                                  _otpController.clear();
                                  setState(() {
                                    otpValue = '';
                                  });
                                  Get.to(() => RegisterDetialScreen());
                                } else {
                                  Get.snackbar('Error', 'Please enter the code',
                                      snackPosition: SnackPosition.TOP,
                                      backgroundColor: Colors.red,
                                      colorText: Colors.white,
                                      icon: const Icon(
                                        Icons.error,
                                        color: Colors.white,
                                      ));
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: HexColor('#F5504C'),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Text(
                                'Next',
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
                          padding: EdgeInsets.only(top: 5.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Didn\'t have code?',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: HexColor('#707070'),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  //Get.back();
                                },
                                child: Text(
                                  'Send again',
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
        )),
      ),
    );
  }
}
