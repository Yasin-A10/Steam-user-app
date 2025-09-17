import 'dart:async';
import 'package:flutter/material.dart';
import 'package:steam/core/constants/colors.dart';

class ResendCodeButton extends StatefulWidget {
  final int duration; // مدت زمان تایمر به ثانیه
  final VoidCallback onResend; // اکشنی که بعد از کلیک انجام میشه
  final String buttonText; // متن دکمه

  const ResendCodeButton({
    super.key,
    required this.duration,
    required this.onResend,
    this.buttonText = "ارسال مجدد کد",
  });

  @override
  State<ResendCodeButton> createState() => _ResendCodeButtonState();
}

class _ResendCodeButtonState extends State<ResendCodeButton> {
  late int _remainingTime;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _remainingTime = widget.duration;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime == 0) {
        timer.cancel();
      } else {
        setState(() {
          _remainingTime--;
        });
      }
    });
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return "$minutes:${secs.toString().padLeft(2, '0')}";
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _onPressed() {
    widget.onResend();
    _startTimer(); // دوباره تایمر رو شروع کن
  }

  @override
  Widget build(BuildContext context) {
    final isEnabled = _remainingTime == 0;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          _formatTime(_remainingTime),
          style: TextStyle(
            fontSize: 12,
            color: isEnabled ? AppColors.myGrey3 : AppColors.blue,
          ),
        ),
        TextButton(
          onPressed: isEnabled ? _onPressed : null,
          style: TextButton.styleFrom(padding: EdgeInsets.zero),
          child: Text(
            widget.buttonText,
            style: TextStyle(
              fontSize: 12,
              color: isEnabled ? AppColors.blue : AppColors.myGrey3,
            ),
          ),
        ),
      ],
    );
  }
}
