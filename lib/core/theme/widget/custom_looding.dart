import 'package:ecomerc_app_with_admin/core/constant/app_lottie.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingOverlay {
  static OverlayEntry? _overlayEntry;

  static void show(BuildContext context) {
    if (_overlayEntry != null) return; // لو ظاهر بالفعل متعملوش تاني

    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          // تمنع المستخدم من التفاعل
          const ModalBarrier(dismissible: false, color: Colors.black12),
          // اللودنج نفسه
          Center(child: LottieBuilder.asset(AppLottie.loading)),
        ],
      ),
    );

    Overlay.of(context, rootOverlay: true).insert(_overlayEntry!);
  }

  static void hide() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}
