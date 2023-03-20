import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lun_talabaty_app/Features/custom/custom_loading.dart';
import 'package:lun_talabaty_app/share/cubit/cubit.dart';
import 'package:lun_talabaty_app/share/cubit/states.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        void onMapCreated(GoogleMapController controller) {
          AppCubit.get(context).mapController = controller;
        }

        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: AppBar(
              title: const Text('Map'),
              centerTitle: true,
            ),
          ),
          body: state is GetUserLocationLoadingState
              ? CustomLoadingIndicator(
                  color: HexColor('#F5504C'),
                )
              : GoogleMap(
                  onMapCreated: onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: AppCubit.get(context).currentPosition!,
                    zoom: 14.4746,
                  ),
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  zoomControlsEnabled: false,
                  markers: AppCubit.get(context).markers,
                  onTap: (latLng) {
                    AppCubit.get(context).addMarker(latLng);
                  },
                  onLongPress: (latLng) {
                    AppCubit.get(context).clearMarkers();
                  },
                ),
        );
      },
    );
  }
}
