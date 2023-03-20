import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:lottie/lottie.dart';
import 'package:lun_talabaty_app/Features/custom/custom_loading.dart';
import 'package:lun_talabaty_app/Features/register&login/recover_password.dart';
import 'package:lun_talabaty_app/Features/register&login/otp_send.dart';
import 'package:lun_talabaty_app/core/login&register/cubit/cubit.dart';
import 'package:lun_talabaty_app/core/login&register/cubit/login_states.dart';
import 'package:sizer/sizer.dart';

import '../../share/components/components.dart';
import '../../share/locale/cache_helper.dart';
import '../home/drawer/zoom_drawer.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

final _phoneTextController = TextEditingController();
final passwordTextController = TextEditingController();

final formKey = GlobalKey<FormState>();
var isDeviceConnected = false;

class _LoginScreenState extends State<LoginScreen> {
  late FlCountryCodePicker countryPicker = const FlCountryCodePicker();
  CountryCode? countryCode;

  var subscription = Connectivity()
      .onConnectivityChanged
      .listen((ConnectivityResult result) async {
    if (result != ConnectivityResult.none) {
      isDeviceConnected = await InternetConnectionChecker().hasConnection;
    }
  });

  @override
  void initState() {
    super.initState();
    countryPicker = const FlCountryCodePicker();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          debugPrint(state.userModel.message!);
          debugPrint(state.userModel.data!.token!);
          _phoneTextController.clear();
          passwordTextController.clear();
          CacheHelper.saveData(
                  key: 'token', value: state.userModel.data!.token!)
              .then((value) {
            final token = state.userModel.data!.token!;
            debugPrint(token);
          });
          Get.offAll(() => const ZDrawer());
        } else if (state is LoginErrorState) {
          debugPrint(state.error.toString());
          Get.snackbar('Error', LoginCubit.get(context).userModel!.message!,
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.red,
              colorText: Colors.white,
              icon: const Icon(
                Icons.error,
                color: Colors.white,
              ));
        }
      },
      builder: (context, state) {
        final cubit = LoginCubit.get(context);
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            body: Form(
              key: formKey,
              child: Container(
                height: 200.h,
                width: 200.w,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/loginbg.jpg'),
                    fit: BoxFit.cover,
                    opacity: 0.7,
                    filterQuality: FilterQuality.high,
                  ),
                ),
                child: ScrollConfiguration(
                  behavior: const ScrollBehavior(),
                  child: SingleChildScrollView(
                    dragStartBehavior: DragStartBehavior.start,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 7.h),
                          child: Image.asset(
                            'assets/images/logo.png',
                            width: 50.w,
                          ),
                        ),
                        helloView(),
                        Container(
                          width: 105.w,
                          height: 55.h,
                          padding:
                              EdgeInsets.only(left: 5.w, right: 5.w, top: 2.h),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(15),
                          ),
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
                                countryCode: countryCode,
                                countryPicker: countryPicker,
                                phoneTextController: _phoneTextController,
                                setState: setState,
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 3.h),
                                child: Text(
                                  'Password',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: HexColor('#707070'),
                                  ),
                                ),
                              ),
                              myTextFormField(
                                textController: passwordTextController,
                                keyboardType: TextInputType.visiblePassword,
                                hintText: '••••••••••',
                                isPassword: cubit.isPassword,
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    cubit.changePasswordVisibility();
                                  },
                                  icon: Icon(
                                    cubit.suffix,
                                    color: cubit.color,
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Password is required';
                                  } else if (value.length < 6) {
                                    return 'Password must be at least 8 characters';
                                  }
                                  // else if (!RegExp(
                                  //         r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                                  //     .hasMatch(value)) {
                                  //   return 'Password must contain at least one number, one uppercase, one lowercase and one special character';
                                  // }
                                  return null;
                                },
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () {
                                    Get.to(() => const RecoverPassword());
                                  },
                                  child: Text(
                                    'Recover Password',
                                    style: TextStyle(
                                      color: HexColor('#F5504C'),
                                      fontSize: 10.sp,
                                      height: 0.1,
                                    ),
                                  ),
                                ),
                              ),
                              state is! LoginLoadingState
                                  ? myButton(
                                      height: 0.0,
                                      text: 'Login',
                                      onPressed: () async {
                                        if (formKey.currentState!.validate()) {
                                          //check internet connection
                                          bool result =
                                              await InternetConnectionChecker()
                                                  .hasConnection;
                                          if (!result) {
                                            Get.snackbar(
                                              'Error',
                                              'No Internet Connection',
                                              snackPosition: SnackPosition.TOP,
                                              backgroundColor: Colors.red,
                                              colorText: Colors.white,
                                              icon: const Icon(
                                                Icons.error,
                                                color: Colors.white,
                                              ),
                                            );
                                          } else {
                                            cubit.phoneNumber =
                                                '+966${_phoneTextController.text}';

                                            debugPrint(cubit.phoneNumber);
                                            // ignore: use_build_context_synchronously
                                            LoginCubit.get(context).userLogin(
                                              phone: cubit.phoneNumber,
                                              password:
                                                  passwordTextController.text,
                                            );
                                          }
                                        }
                                      },
                                    )
                                  : Center(
                                      child: CustomLoadingIndicator(),
                                    ),
                              Padding(
                                padding: EdgeInsets.only(top: 3.h),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 40.w,
                                      height: 7.h,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const RegisterScreen(),
                                            ),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: HexColor('#363537'),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        child: Text(
                                          'Register',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 40.w,
                                      height: 7.h,
                                      child: ElevatedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: HexColor('#707070'),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        child: Text(
                                          'Visitor',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.bold,
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
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget helloView() => Padding(
        padding: EdgeInsets.only(top: 1.h, bottom: 7.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LottieBuilder.asset(
              'assets/lottie/hand.json',
              height: 10.h,
              repeat: false,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello Again !',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Welcome back you\'ve been missed',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.sp,
                    //fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
}
