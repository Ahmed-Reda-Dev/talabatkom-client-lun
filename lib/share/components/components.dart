import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';

Widget phoneWidget({
  required BuildContext context,
  required TextEditingController phoneTextController,
  required FlCountryCodePicker countryPicker,
  required Function setState,
  CountryCode? countryCode,
  double? width,
  double? height,
  double? fieldWidth,
}) =>
    Row(
      children: [
        SizedBox(
          width: fieldWidth ?? 95.w,
          child: TextFormField(
            keyboardType: TextInputType.phone,
            controller: phoneTextController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              prefixIcon: SizedBox(
                width: 33.w,
                child: GestureDetector(
                  onTap: () async {
                    final result = await countryPicker.showPicker(
                      context: context,
                      initialSelectedLocale: 'SA',
                    );
                    if (result != null) {
                      setState(() {
                        countryCode = result;
                      });
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 19.w,
                        height: 6.8.h,
                        margin: EdgeInsets.only(
                          left: 0.4.w,
                        ),
                        padding: EdgeInsets.only(
                          left: 0.8.w,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(7),
                            bottomLeft: Radius.circular(7),
                          ),
                          color: HexColor('#EDEDF4'),
                        ),
                        child: Row(
                          children: [
                            countryCode == null
                                ? SvgPicture.asset(
                                    'assets/svg/Flag.svg',
                                    width: 12.w,
                                  )
                                : Image.asset(
                                    countryCode.flagUri,
                                    package: 'fl_country_code_picker',
                                    width: 10.w,
                                  ),
                            const Icon(
                              Icons.arrow_drop_down,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        //height: 7.h,
                        //width: 10.w,
                        color: Colors.white,
                        alignment: Alignment.center,
                        child: Text(
                          countryCode == null ? ' +966' : countryCode.dialCode,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: HexColor('#707070'),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                  color: Colors.white,
                  width: 2.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                  color: Colors.white,
                  width: 2.0,
                ),
              ),
            ),
            validator: (value) {
              //validate phone number with country code
              if (value!.isEmpty) {
                return 'Phone number is required';
              } else if (value.length < 9) {
                return 'Phone number must be at least 9 characters';
              } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                return 'Phone number must contain only numbers';
              }
              return null;
            },
          ),
        ),
      ],
    );

Widget logoComponent({
  //required BuildContext context,
  required Function? onTap,
  required Widget image,
  required String title1,
  String? title2,
  required String subtitle1,
  String? subtitle2,
  String? subtitle3,
  bool isRow = false,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        height: 7.h,
        width: 15.w,
        padding: EdgeInsets.only(
          left: 2.w,
        ),
        decoration: BoxDecoration(
          color: HexColor('#707070').withOpacity(0.2),
          borderRadius: BorderRadius.circular(15),
        ),
        child: GestureDetector(
          onTap: () {
            onTap!();
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: HexColor('#707070'),
          ),
        ),
      ),
      image,
      SizedBox(
        height: 2.5.h,
      ),
      isRow
          ? Row(
              children: [
                Text(
                  title1,
                  style: TextStyle(
                    fontSize: 25.sp,
                    color: HexColor('#363537'),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  title2!,
                  style: TextStyle(
                    wordSpacing: 1,
                    fontSize: 31.sp,
                    color: HexColor('#F5504C'),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            )
          : Text(
              title1,
              style: TextStyle(
                fontSize: 37.sp,
                color: HexColor('#363537'),
                fontWeight: FontWeight.bold,
              ),
            ),
      isRow
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  subtitle1,
                  softWrap: true,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: HexColor('#707070'),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      subtitle2!,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: HexColor('#707070'),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        subtitle3!,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: HexColor('#F5504C'),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )
          : Text(
              subtitle1,
              style: TextStyle(
                fontSize: 12.sp,
                color: HexColor('#707070'),
              ),
            ),
      SizedBox(
        height: 3.h,
      ),
    ],
  );
}

Widget myCard({
  required Widget child,
  double? height,
  double? width,
}) =>
    Center(
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(
            color: Colors.white,
            width: 0.3.w,
          ),
        ),
        child: Container(
          height: height ?? 40.h,
          width: width ?? 100.w,
          padding: EdgeInsets.all(5.w),
          decoration: BoxDecoration(
            color: HexColor('#EDEDF4'),
            borderRadius: BorderRadius.circular(15),
          ),
          child: child,
        ),
      ),
    );

Widget myTextFormField({
  required TextEditingController textController,
  required TextInputType keyboardType,
  String? hintText,
  Widget? suffixIcon,
  bool isPassword = false,
  required String? Function(String?)? validator,
  AutovalidateMode? autovalidateMode,
}) =>
    TextFormField(
      controller: textController,
      keyboardType: keyboardType,
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: hintText,
        fillColor: Colors.white,
        filled: true,
        suffixIcon: suffixIcon,
        suffixIconColor: Colors.grey,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        hintStyle: TextStyle(
          fontSize: 15.sp,
          color: Colors.grey,
          fontWeight: FontWeight.bold,
        ),
      ),
      validator: validator,
      autovalidateMode: autovalidateMode,
    );

Widget myButton({
  required String text,
  required Function onPressed,
  double? height,
}) =>
    Padding(
      padding: EdgeInsets.only(top: height ?? 5.h),
      child: SizedBox(
        width: 100.w,
        height: 7.h,
        child: ElevatedButton(
          onPressed: () {
            onPressed();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: HexColor('#F5504C'),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: HexColor('#EDEDF4'),
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
