import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lun_talabaty_app/Features/custom/custom_loading.dart';
import 'package:lun_talabaty_app/share/cubit/cubit.dart';
import 'package:lun_talabaty_app/share/cubit/states.dart';
import 'package:sizer/sizer.dart';

import '../home.dart';
import 'drawer_menu.dart';

class ZDrawer extends StatefulWidget {
  const ZDrawer({Key? key}) : super(key: key);

  @override
  State<ZDrawer> createState() => _ZDrawerState();
}

class _ZDrawerState extends State<ZDrawer> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return state is ProfileLoadingState
            ? Center(child: CustomLoadingIndicator())
            : ZoomDrawer(
                menuScreen: DrawerMenu(
                  setIndex: (value) {
                    //cubit.setIndex(value);
                  },
                ),
                mainScreen: state is ProfileLoadingState
                    ? Center(child: CustomLoadingIndicator())
                    : const HomeScreen(),
                angle: 0.0,
                //showShadow: true,
                androidCloseOnBackTap: true,
                menuBackgroundColor: HexColor('#F5504C'),
                borderRadius: 10.0.w,
                slideWidth: 85.0.w,

                openCurve: Curves.fastOutSlowIn,
                //shadowLayer1Color: Colors.deepPurple,
                //shadowLayer2Color: Colors.white.withOpacity(0.3),
              );
      },
    );
  }
}
