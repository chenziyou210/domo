// You have generated a new plugin project without
// specifying the `--platforms` flag. A plugin project supports no platforms is generated.
// To add platforms, run `flutter create -t plugin --platforms <platforms> .` under the same
// directory. You can also find a detailed instruction on how to add platforms in the `pubspec.yaml` at https://flutter.dev/docs/development/packages-and-plugins/developing-packages#plugin-platforms.

import 'package:flutter/material.dart';
import 'package:star_common/app_images/r.dart';
import 'package:star_common/common/app_common_widget.dart';

import 'flutter_toggle_tab/button_tab.dart';
import 'flutter_toggle_tab/data_tab.dart';
import 'flutter_toggle_tab/helper.dart';

///*********************************************
/// Created by ukieTux on 22/04/2020 with ♥
/// (>’_’)> email : ukie.tux@gmail.com
/// github : https://www.github.com/ukieTux <(’_’<)
///*********************************************
/// © 2020 | All Right Reserved
class ToggleTab extends StatefulWidget {
  /// Define parameter Flutter toggle tab
  /// It's main attribute is available on Flutter Toggle Tab
  /// is Scroll by default is set to Enable
  const ToggleTab({
    Key? key,
    required this.labels,
    required this.selectedLabelIndex,
    required this.selectedTextStyle,
    required this.unSelectedTextStyle,
    this.height,
    this.itemWidth,
    this.icons,
    this.selectedBackgroundColors,
    this.unSelectedBackgroundColors,
    this.width,
    this.borderRadius,
    this.begin,
    this.end,
    required this.selectedIndex,
    this.isScroll = true,
    this.marginSelected,
    this.isShadowEnable = true,
  }) : super(key: key);

  final List<String> labels;
  final List<IconData?>? icons;
  final int selectedIndex;
  final double? width;
  final double? itemWidth;
  final double? height;
  final bool isScroll;
  final List<Color>? selectedBackgroundColors;
  final List<Color>? unSelectedBackgroundColors;
  final TextStyle selectedTextStyle;
  final TextStyle unSelectedTextStyle;
  final Function(int) selectedLabelIndex;
  final double? borderRadius;
  final Alignment? begin;
  final Alignment? end;

  final EdgeInsets? marginSelected;
  final bool isShadowEnable;

  @override
  _ToggleTabState createState() => _ToggleTabState();
}

class _ToggleTabState extends State<ToggleTab> {
  List<DataTab> _labels = [];

  /// Set default selected for first build
  void _setDefaultSelected() {
    setState(() {
      /// loops label from widget labels
      for (int x = 0; x < widget.labels.length; x++) {
        _labels.add(DataTab(title: widget.labels[x], isSelected: false));
      }
    });
  }

  @override
  void initState() {
    super.initState();

    /// init default selected in InitState
    _setDefaultSelected();
  }

  /// Update selected when selectedItem changed
  void _updateSelected() {
    setState(() {
      /// set all item to false
      for (final item in _labels) {
        item.isSelected = false;
      }

      /// Update selectedIndex isSelected to True
      _labels[widget.selectedIndex].isSelected = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    _updateSelected();
    /// Show text error if length less 1
    return Container(
            height: widget.height,
            padding: EdgeInsets.only(bottom: 4.dp),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(R.bgTab), fit: BoxFit.fitWidth),
                borderRadius: BorderRadius.circular(widget.borderRadius ?? 30.dp),
                boxShadow: [if (widget.isShadowEnable) bsInner]),
            child: ListView.builder(
              itemCount: _labels.length,
              shrinkWrap: true,
              physics: widget.isScroll
                  ? BouncingScrollPhysics()
                  : NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                IconData? icon;
                try {
                  icon = widget.icons?[index];
                } catch (e) {
                  icon = null;
                }
                return ButtonsTab(
                  marginSelected: widget.marginSelected,
                  unSelectedColors: widget.unSelectedBackgroundColors != null
                      ? (widget.unSelectedBackgroundColors!.length == 1
                          ? [
                              widget.unSelectedBackgroundColors![0],
                              widget.unSelectedBackgroundColors![0]
                            ]
                          : widget.unSelectedBackgroundColors)
                      : [Color(0xffe0e0e0), Color(0xffe0e0e0)],
                  width: (widget.width ?? 0) / _labels.length,
                  title: _labels[index].title,
                  size: _labels.length,
                  icons: icon,
                  selectedTextStyle: widget.selectedTextStyle,
                  unSelectedTextStyle: widget.unSelectedTextStyle,
                  isSelected: _labels[index].isSelected,
                  radius: widget.borderRadius ?? 30.dp,
                  selectedColors: widget.selectedBackgroundColors != null
                      ? (widget.selectedBackgroundColors!.length == 1
                          ? [
                              widget.selectedBackgroundColors![0],
                              widget.selectedBackgroundColors![0]
                            ]
                          : widget.selectedBackgroundColors)
                      : [
                          Theme.of(context).primaryColor,
                          Theme.of(context).primaryColor
                        ],
                  onPressed: () {
                    try {
                      for (int x = 0; x < _labels.length; x++) {
                        setState(() {
                          if (_labels[index] == _labels[x]) {
                            _labels[x].isSelected = true;
                            widget.selectedLabelIndex(index);
                          } else
                            _labels[x].isSelected = false;
                        });
                      }
                    } catch (e) {
                      print("err : $e");
                    }
                  },
                );
              },
            ));
  }
}
