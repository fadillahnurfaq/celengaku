import 'package:celenganku/views/home/home_view.dart';
import 'package:flutter/material.dart';

class WishCompleteDialog extends StatelessWidget {
  const WishCompleteDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeView(),
                        ),
                        (route) => false);
                  },
                  icon: const Icon(Icons.close),
                ),
              ),
            ],
          ),
          const Text("Hore !,", style: TextStyle(fontSize: 32)),
          const Text("Celenganmu Sudah Penuh",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const Padding(
            padding: EdgeInsets.all(48),
            child: Icon(
              Icons.check_circle,
              size: 64,
            ),
          ),
        ],
      ),
    );
  }
}
