import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';
import 'package:lun_talabaty_app/Features/custom/onboarding_button.dart';
import 'package:lun_talabaty_app/Features/register&login/login_screen.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../share/locale/cache_helper.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({required this.image, required this.title, required this.body});
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  List<BoardingModel> board = [
    BoardingModel(
      image: 'assets/images/boarding1.jpg',
      title: 'Title 1',
      body: "Body 1",
    ),
    BoardingModel(
      image: 'assets/images/boarding1.jpg',
      title: 'Title 2',
      body: "Body 2",
    ),
    BoardingModel(
      image: 'assets/images/boarding1.jpg',
      title: 'Title 3',
      body: "Body 3",
    ),
  ];

  final PageController _pageController = PageController();
  double _currentPage = 0;

  late AnimationController _animationController;
  // ignore: unused_field
  Animation<double>? _animation;
  int _numSlices = 1;
  bool isLast = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _controller.repeat();

    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!;
      });
    });
  }

  void submit() {
    CacheHelper.saveData(
      key: 'onBoarding',
      value: true,
    ).then((value) {
      if (value!) {
        Get.offAll(() => const LoginScreen());
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _onTap() {
    setState(() {
      _numSlices++;
    });
    _animationController.forward(from: 0);
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController)
      ..addListener(() {
        setState(() {
          _currentPage = _pageController.page!;
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#EDEDF4'),
      body: Column(
        children: [
          SizedBox(
            height: 100.h,
            child: Stack(
              children: [
                Column(
                  children: [
                    Container(
                      height: 61.h,
                      width: 150.w,
                      color: HexColor('#F5504C'),
                    ),
                  ],
                ),
                screenBar(),
                Positioned(
                  top: 20.h,
                  left: 3.h,
                  right: 3.h,
                  child: SizedBox(
                    height: 80.h,
                    child: Card(
                      elevation: 0.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: Colors.transparent.withOpacity(0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 20),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.66),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: AnimatedOpacity(
                                    curve: Curves.easeOut,
                                    opacity: _currentPage.ceil() == _currentPage
                                        ? 1.0
                                        : _currentPage.ceil() - _currentPage,
                                    duration: const Duration(milliseconds: 200),
                                    child: PageView.builder(
                                      physics: const BouncingScrollPhysics(),
                                      controller: _pageController,
                                      pageSnapping: true,
                                      onPageChanged: (int index) {
                                        if (index == board.length - 1) {
                                          setState(() {
                                            isLast = true;
                                          });
                                        } else {
                                          setState(() {
                                            isLast = false;
                                          });
                                        }
                                      },
                                      itemBuilder: (context, index) =>
                                          buildBoardingItem(board[index]),
                                      itemCount: board.length,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 2.4.h,
                                  ),
                                  child: SmoothPageIndicator(
                                    controller: _pageController,
                                    count: board.length,
                                    effect: ExpandingDotsEffect(
                                      dotColor: HexColor('#EDEDF4'),
                                      activeDotColor: HexColor('#707070'),
                                      dotHeight: 1.5.h,
                                      dotWidth: 1.5.h,
                                      expansionFactor: 4,
                                      spacing: 0.5.h,
                                    ),
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
              ],
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          CircleAvatar(
            radius: 5.h,
            backgroundColor: HexColor('#F5504C'),
            child: SizedBox(
              width: 15.w,
              height: 18.w,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CustomPaint(
                    painter: CirclePainter(
                      numSlices: _numSlices,
                      progress: _animationController.value,
                    ),
                    child: const SizedBox.expand(),
                  ),
                  InkWell(
                    onTap: () {
                      _onTap();
                      if (isLast) {
                        submit();
                      } else {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.ease,
                        );
                      }
                    },
                    child: Container(
                      width: 20.w,
                      height: 20.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: HexColor('#F5504C'),
                      ),
                      // color: HexColor('#F5504C'),
                      child: Text(
                        '»',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 5.h,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget screenBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.h, vertical: 15.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //skip button
          Container(
            height: 7.h,
            width: 15.w,
            padding: EdgeInsets.symmetric(
              horizontal: 2.w,
            ),
            child: Center(
              child: GestureDetector(
                onTap: () {
                  submit();
                },
                child: Text(
                  'Skip',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget buildBoardingItem(BoardingModel model) => Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(
          'assets/lottie/heart.json',
          animate: true,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Orders prepare to depend on safety standards to keep you well.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: HexColor('#707070'),
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
