import 'package:audio_probe/Custom/custom_text.dart';
import 'package:audio_probe/values/values.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CustomDD extends StatefulWidget {
  final List<DropdownMenuItem> items;
  final dynamic value;
  final bool isDay;
  final void Function(dynamic)? onChanged;
  const CustomDD(
      {super.key,
      required this.items,
      this.value,
      this.onChanged,
      required this.isDay});
  @override
  State<CustomDD> createState() => _CustomDDState();
}

class _CustomDDState extends State<CustomDD> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Material(
        color: AppColors.white,
        child: DropdownButtonHideUnderline(
            child: DropdownButton2(
          hint: Row(
            children: [
              customText(
                text: widget.isDay ? "Day" : "Gender",
                id: 1,
                color: AppColors.primaryDarkColor,
                textSize: Sizes.TEXT_SIZE_18,
              ),
            ],
          ),
          alignment: AlignmentDirectional.center,
          isExpanded: true,
          items: widget.items,
          value: widget.value,
          onChanged: widget.onChanged,
          iconStyleData: IconStyleData(
            icon: const Icon(
              Iconsax.arrow_bottom5,
            ),
            iconSize: 24,
            iconEnabledColor: AppColors.primaryDarkColor,
            iconDisabledColor: Colors.grey,
          ),
          buttonStyleData: ButtonStyleData(
              height: 50,
              width: size.width * 0.90,
              padding: const EdgeInsets.only(left: 14, right: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.black,
                ),
                color: Colors.white,
              ),
              elevation: 0),
          dropdownStyleData: DropdownStyleData(
            padding: const EdgeInsets.only(left: 14, right: 14),
            maxHeight: 200,
            width: size.width * 0.85,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            elevation: 4,
          ),
        )));
  }
}
