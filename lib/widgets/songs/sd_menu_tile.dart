import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foutain_desktop/providers/general_providers.dart';
import 'package:foutain_desktop/utils/enums.dart';

class MousedListTile extends ConsumerWidget {
  const MousedListTile({
    Key? key,
    required this.label,
    required this.onTap,
    required this.menuSelector,
  }) : super(key: key);
  final String label;
  final Function onTap;
  final MenuSelector menuSelector;

  @override
  Widget build(BuildContext context, ref) {
    final sngbkSelector = ref.watch(menuSelectorProvider.state);
    return MouseRegion(
      child: Container(
        decoration: BoxDecoration(
            color: sngbkSelector.state == menuSelector
                ? Theme.of(context).primaryColor.withOpacity(0.2)
                : Colors.white,
            borderRadius: BorderRadius.circular(18)),
        child: ListTile(
          title: Text(label, style: TextStyle(fontSize: 13.sp)),
          dense: true,
          trailing:
              Icon(Icons.arrow_forward_ios, size: 12.sp, color: Colors.black),
          onTap: () => onTap(),
        ),
      ),
    );
  }
}
