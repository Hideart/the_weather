import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_weather/src/models/models.dart';
import 'package:the_weather/src/cubits/overlay_cubit.dart';

class ModalsContainer extends StatelessWidget {
  const ModalsContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BlocBuilder<OverlayCubit, OverlayCubitState>(
          builder: (context, overlaysState) {
            List<CustomOverlay> modalsQueue = overlaysState.overlayQueue
                .where(
                  (overlay) => overlay.type == OverlayType.modal,
                )
                .toList();
            return modalsQueue.isNotEmpty
                ? modalsQueue.first
                : const SizedBox();
          },
        ),
      ],
    );
  }
}
