import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foutain_desktop/providers/song_providers.dart';
import 'package:foutain_desktop/utils/utilities.dart';

class Settings extends ConsumerStatefulWidget {
  static void showDialog(BuildContext context) {
    showGeneralDialog(
      barrierLabel: 'Settings',
      barrierDismissible: true,
      transitionDuration: const Duration(milliseconds: 200),
      context: context,
      pageBuilder: (_, __, ___) {
        return Consumer(
          builder: (context, ref, child) {
            return const Settings();
          },
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(
            begin: const Offset(0, 1),
            end: const Offset(0, 0),
          ).animate(anim),
          child: child,
        );
      },
    );
  }

  const Settings({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingsState();
}

class _SettingsState extends ConsumerState<Settings> {
  bool showShades = false;
  bool showFontShades = false;
  ColorSwatch? colors;
  ColorSwatch? fcolor;
  @override
  Widget build(BuildContext context) {
    final color = ref.watch(colorProvider);
    final fontcolor = ref.watch(fontcolorProvider);
    return Dialog(
      insetPadding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.15),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Settings',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Close'))
              ],
            ),
            Divider(),
            SizedBox(height: 10.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Background Color',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 5.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Wrap(
                          runSpacing: 10.h,
                          spacing: 8.w,
                          children: materialColors
                              .map(
                                (e) => GestureDetector(
                                  child: Material(
                                    elevation: 5.0,
                                    shape: const CircleBorder(),
                                    child: CircleAvatar(
                                      radius: 15.sp,
                                      backgroundColor: e,
                                      child: colors == e
                                          ? const Icon(Icons.check)
                                          : const SizedBox.shrink(),
                                    ),
                                  ),
                                  onTap: () {
                                    colors = e;
                                    setState(() => showShades = true);
                                  },
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      if (showShades) ...[
                        SizedBox(height: 10.h),
                        const Text('Color Shades'),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Wrap(
                            runSpacing: 10.h,
                            spacing: 8.w,
                            children: getMaterialColorShades(colors!)
                                .map(
                                  (e) => GestureDetector(
                                    child: Material(
                                        elevation: 5.0,
                                        shape: const CircleBorder(),
                                        child: CircleAvatar(
                                          radius: 15.sp,
                                          backgroundColor: e,
                                          child: color == e
                                              ? const Icon(Icons.check)
                                              : const SizedBox.shrink(),
                                        )),
                                    onTap: () {
                                      ref
                                          .read(colorProvider.notifier)
                                          .setColor(e);
                                      //setState(() => showShades = false);
                                    },
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ],
                      Divider(),
                      const Text(
                        'Font Color',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Wrap(
                          runSpacing: 10.h,
                          spacing: 8.w,
                          children: materialColors
                              .map(
                                (e) => GestureDetector(
                                  child: Material(
                                    elevation: 5.0,
                                    shape: const CircleBorder(),
                                    child: CircleAvatar(
                                      radius: 15.sp,
                                      backgroundColor: e,
                                      child: fcolor == e
                                          ? const Icon(Icons.check,
                                              color: Colors.black)
                                          : const SizedBox.shrink(),
                                    ),
                                  ),
                                  onTap: () {
                                    fcolor = e;
                                    setState(() {
                                      showFontShades = true;
                                    });
                                  },
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      if (showFontShades) ...[
                        SizedBox(height: 10.h),
                        const Text('Color Shades'),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Wrap(
                            runSpacing: 10.h,
                            spacing: 8.w,
                            children: getMaterialColorShades(fcolor!)
                                .map(
                                  (e) => GestureDetector(
                                    child: Material(
                                        elevation: 5.0,
                                        shape: const CircleBorder(),
                                        child: CircleAvatar(
                                          radius: 15.sp,
                                          backgroundColor: e,
                                          child: fontcolor == e
                                              ? const Icon(Icons.check,
                                                  color: Colors.black)
                                              : const SizedBox.shrink(),
                                        )),
                                    onTap: () {
                                      ref
                                          .read(fontcolorProvider.notifier)
                                          .setColor(e);
                                      //setState(() => showShades = false);
                                    },
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                SizedBox(height: 10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Preview',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 10.h),
                      Container(
                        height: 200.h,
                        width: 500.w,
                        color: color,
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 10.h),
                        child: Center(
                          child: Text(
                            '''                    
Only believe, only believe;
All things are possible, only believe;
Only believe, only believe;
All things are possible, only believe.
                              ''',
                            style: TextStyle(color: fontcolor, fontSize: 19.sp),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
