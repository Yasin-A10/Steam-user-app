// import 'package:flutter/material.dart';
// import 'package:persian_datetime_picker/persian_datetime_picker.dart';
// import 'package:steam/core/constants/colors.dart';
// import 'package:steam/core/utils/number_formater.dart';
// import 'package:hugeicons/hugeicons.dart';

// class PersianBirthdayPicker extends StatefulWidget {
//   final Function(Jalali) onDateSelected;

//   const PersianBirthdayPicker({super.key, required this.onDateSelected});

//   @override
//   State<PersianBirthdayPicker> createState() => _PersianBirthdayPickerState();
// }

// class _PersianBirthdayPickerState extends State<PersianBirthdayPicker> {
//   Jalali? selectedDate;

//   Future<void> _pickDate() async {
//     Jalali? picked = await showPersianDatePicker(
//       context: context,
//       initialDate: Jalali.now(),
//       firstDate: Jalali(1360, 1),
//       lastDate: Jalali.now(),
//       initialEntryMode: PersianDatePickerEntryMode.calendarOnly,
//       initialDatePickerMode: PersianDatePickerMode.year,
//     );

//     if (picked != null) {
//       setState(() {
//         selectedDate = picked;
//       });
//       widget.onDateSelected(picked);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: _pickDate,
//       child: Container(
//         width: double.infinity,
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(color: AppColors.myGrey6),
//           color: AppColors.myGrey7,
//         ),
//         child: Row(
//           children: [
//             Icon(
//               HugeIcons.strokeRoundedCalendar01,
//               color: AppColors.myGrey2,
//               size: 20,
//             ),
//             const SizedBox(width: 8),
//             Text(
//               selectedDate != null
//                   ? "${formatNumberToPersianWithoutSeparator(selectedDate!.year.toString())}/${formatNumberToPersianWithoutSeparator(selectedDate!.month.toString().padLeft(2, '0'))}/${formatNumberToPersianWithoutSeparator(selectedDate!.day.toString().padLeft(2, '0'))}"
//                   : "تاریخ را انتخاب کنید",
//               style: TextStyle(
//                 fontSize: 14,
//                 color: selectedDate != null ? Colors.black : AppColors.myGrey2,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:steam/core/constants/colors.dart';
import 'package:steam/core/utils/number_formater.dart';
import 'package:hugeicons/hugeicons.dart';

class PersianBirthdayPicker extends StatefulWidget {
  final Function(String) onDateSelected; // خروجی به فرمت yyyy-MM-dd
  final String? initialDate; // تاریخ اولیه از بک‌اند

  const PersianBirthdayPicker({
    super.key,
    required this.onDateSelected,
    this.initialDate,
  });

  @override
  State<PersianBirthdayPicker> createState() => _PersianBirthdayPickerState();
}

class _PersianBirthdayPickerState extends State<PersianBirthdayPicker> {
  Jalali? selectedDate;

  @override
  void initState() {
    super.initState();
    // اگر تاریخ اولیه وجود داشت، تبدیل به Jalali کنیم
    if (widget.initialDate != null && widget.initialDate!.isNotEmpty) {
      final parts = widget.initialDate!.split('-'); // "2004-07-10"
      if (parts.length == 3) {
        final gregorianDate = DateTime(
          int.parse(parts[0]),
          int.parse(parts[1]),
          int.parse(parts[2]),
        );
        selectedDate = Jalali.fromDateTime(gregorianDate);
      }
    }
  }

  Future<void> _pickDate() async {
    Jalali initial = selectedDate ?? Jalali.now();

    Jalali? picked = await showPersianDatePicker(
      context: context,
      initialDate: initial,
      firstDate: Jalali(1360, 1),
      lastDate: Jalali.now(),
      initialEntryMode: PersianDatePickerEntryMode.calendarOnly,
      initialDatePickerMode: PersianDatePickerMode.year,
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
      // ارسال تاریخ به فرمت yyyy-MM-dd
      final gregorian = picked.toDateTime();
      final formatted =
          "${gregorian.year}-${gregorian.month.toString().padLeft(2, '0')}-${gregorian.day.toString().padLeft(2, '0')}";
      widget.onDateSelected(formatted);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickDate,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.myGrey6),
          color: AppColors.myGrey7,
        ),
        child: Row(
          children: [
            Icon(
              HugeIcons.strokeRoundedCalendar01,
              color: AppColors.myGrey2,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              selectedDate != null
                  ? "${formatNumberToPersianWithoutSeparator(selectedDate!.year.toString())}/${formatNumberToPersianWithoutSeparator(selectedDate!.month.toString().padLeft(2, '0'))}/${formatNumberToPersianWithoutSeparator(selectedDate!.day.toString().padLeft(2, '0'))}"
                  : "تاریخ را انتخاب کنید",
              style: TextStyle(
                fontSize: 14,
                color: selectedDate != null ? Colors.black : AppColors.myGrey2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
