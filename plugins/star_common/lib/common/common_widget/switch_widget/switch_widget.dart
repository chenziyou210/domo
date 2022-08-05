

part of appcommon;

enum _SwitchType { material, adaptive }

class CupertinoSwitchWidget extends StatefulWidget {
  CupertinoSwitchWidget({
    Key? key,
    required this.value,
    required this.onChanged,
    this.activeColor,
    this.trackColor,
    this.thumbColor,
    this.needInternalState: true,
    this.dragStartBehavior = DragStartBehavior.start,
  }) : assert(value != null),
        assert(dragStartBehavior != null),
        super(key: key);
  /// Whether this switch is on or off.
  ///
  /// Must not be null.
  final bool value;

  /// Called when the user toggles with switch on or off.
  ///
  /// The switch passes the new value to the callback but does not actually
  /// change state until the parent widget rebuilds the switch with the new
  /// value.
  ///
  /// If null, the switch will be displayed as disabled, which has a reduced opacity.
  ///
  /// The callback provided to onChanged should update the state of the parent
  /// [StatefulWidget] using the [State.setState] method, so that the parent
  /// gets rebuilt; for example:
  ///
  /// ```dart
  /// CupertinoSwitch(
  ///   value: _giveVerse,
  ///   onChanged: (bool newValue) {
  ///     setState(() {
  ///       _giveVerse = newValue;
  ///     });
  ///   },
  /// )
  /// ```
  final ValueChanged<bool> onChanged;

  /// The color to use when this switch is on.
  ///
  /// Defaults to [CupertinoColors.systemGreen] when null and ignores
  /// the [CupertinoTheme] in accordance to native iOS behavior.
  final Color? activeColor;

  /// The color to use for the background when the switch is off.
  ///
  /// Defaults to [CupertinoColors.secondarySystemFill] when null.
  final Color? trackColor;

  /// The color to use for the thumb of the switch.
  ///
  /// Defaults to [CupertinoColors.white] when null.
  final Color? thumbColor;

  /// {@template flutter.cupertino.switch.dragStartBehavior}
  /// Determines the way that drag start behavior is handled.
  ///
  /// If set to [DragStartBehavior.start], the drag behavior used to move the
  /// switch from on to off will begin upon the detection of a drag gesture. If
  /// set to [DragStartBehavior.down] it will begin when a down event is first
  /// detected.
  ///
  /// In general, setting this to [DragStartBehavior.start] will make drag
  /// animation smoother and setting it to [DragStartBehavior.down] will make
  /// drag behavior feel slightly more reactive.
  ///
  /// By default, the drag start behavior is [DragStartBehavior.start].
  ///
  /// See also:
  ///
  ///  * [DragGestureRecognizer.dragStartBehavior], which gives an example for
  ///    the different behaviors.
  ///
  /// {@endtemplate}
  final DragStartBehavior dragStartBehavior;

  final bool needInternalState;
  @override
  createState() => _CupertinoSwitchWidgetState(value: value);
}

class _CupertinoSwitchWidgetState extends State<CupertinoSwitchWidget> {
  _CupertinoSwitchWidgetState({bool? value}): this._value = value ?? false;
  bool _value;

  @override
  Widget build(BuildContext context) {
    return CupertinoSwitch(
      key: widget.key,
      activeColor: widget.activeColor,
      trackColor: widget.trackColor,
      thumbColor: widget.thumbColor,
      value: _value ,//== widget.value ? _value : widget.value,
      onChanged: (value) {
        widget.onChanged(value);
        if (widget.needInternalState) {
          _value = value;
          setState(() {});
        }
      },
      dragStartBehavior: widget.dragStartBehavior,
    );
  }

  @override
  void didUpdateWidget(covariant CupertinoSwitchWidget oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    if (_value != widget.value) {
      _value = widget.value;
      setState(() {});
    }
  }

}

class SwitchWidget extends StatefulWidget {
  SwitchWidget(
      {Key? key,
      required this.value,
      required this.onChanged,
      this.activeColor,
      this.activeTrackColor,
      this.inactiveThumbColor,
      this.inactiveTrackColor,
      this.activeThumbImage,
      this.inactiveThumbImage,
      this.materialTapTargetSize,
      this.dragStartBehavior = DragStartBehavior.start,
      this.focusColor,
      this.hoverColor,
      this.focusNode,
      this.autofocus = false})
      : this._type = _SwitchType.material,
        super(key: key);

  SwitchWidget.adaptive(
      {Key? key,
      required this.value,
      required this.onChanged,
      this.activeColor,
      this.activeTrackColor,
      this.inactiveThumbColor,
      this.inactiveTrackColor,
      this.activeThumbImage,
      this.inactiveThumbImage,
      this.materialTapTargetSize,
      this.dragStartBehavior = DragStartBehavior.start,
      this.focusColor,
      this.hoverColor,
      this.focusNode,
      this.autofocus = false})
      : this._type = _SwitchType.adaptive,
        super(key: key);

  /// 当前值
  final bool? value;

  /// 值改变
  final void Function(bool)? onChanged;

  /// The color to use when this switch is on.
  ///
  /// Defaults to [ThemeData.toggleableActiveColor].
  final Color? activeColor;

  /// The color to use on the track when this switch is on.
  ///
  /// Defaults to [ThemeData.toggleableActiveColor] with the opacity set at 50%.
  ///
  /// Ignored if this switch is created with [Switch.adaptive].
  final Color? activeTrackColor;

  /// The color to use on the thumb when this switch is off.
  ///
  /// Defaults to the colors described in the Material design specification.
  ///
  /// Ignored if this switch is created with [Switch.adaptive].
  final Color? inactiveThumbColor;

  /// The color to use on the track when this switch is off.
  ///
  /// Defaults to the colors described in the Material design specification.
  ///
  /// Ignored if this switch is created with [Switch.adaptive].
  final Color? inactiveTrackColor;

  /// An image to use on the thumb of this switch when the switch is on.
  ///
  /// Ignored if this switch is created with [Switch.adaptive].
  final ImageProvider? activeThumbImage;

  /// An image to use on the thumb of this switch when the switch is off.
  ///
  /// Ignored if this switch is created with [Switch.adaptive].
  final ImageProvider? inactiveThumbImage;

  /// Configures the minimum size of the tap target.
  ///
  /// Defaults to [ThemeData.materialTapTargetSize].
  ///
  /// See also:
  ///
  ///  * [MaterialTapTargetSize], for a description of how this affects tap targets.
  final MaterialTapTargetSize? materialTapTargetSize;

  /// {@macro flutter.cupertino.switch.dragStartBehavior}
  final DragStartBehavior dragStartBehavior;

  /// The color for the button's [Material] when it has the input focus.
  final Color? focusColor;

  /// The color for the button's [Material] when a pointer is hovering over it.
  final Color? hoverColor;

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode? focusNode;

  /// {@macro flutter.widgets.Focus.autofocus}
  final bool autofocus;

  final _SwitchType _type;

  @override
  createState() => _SwitchWidgetState(this.value ?? false);
}

class _SwitchWidgetState extends State<SwitchWidget> {
  _SwitchWidgetState(bool value) : this._value = value;

  bool _value;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return widget._type == _SwitchType.material
        ? Switch(
            value: _value,
            onChanged: (value) {
              this._value = value;
              if (widget.onChanged != null) widget.onChanged!(value);
              setState(() {});
            },
            activeColor: widget.activeColor,
            activeTrackColor: widget.activeTrackColor,
            inactiveThumbColor: widget.inactiveThumbColor,
            inactiveTrackColor: widget.inactiveTrackColor,
            activeThumbImage: widget.activeThumbImage,
            inactiveThumbImage: widget.inactiveThumbImage,
            materialTapTargetSize: widget.materialTapTargetSize,
            dragStartBehavior: widget.dragStartBehavior,
            focusColor: widget.focusColor,
            hoverColor: widget.hoverColor,
            focusNode: widget.focusNode,
            autofocus: widget.autofocus,
          )
        : Switch.adaptive(
            value: _value,
            onChanged: (value) {
              this._value = value;
              if (widget.onChanged != null) widget.onChanged!(value);
              setState(() {});
            },
            activeColor: widget.activeColor,
            activeTrackColor: widget.activeTrackColor,
            inactiveThumbColor: widget.inactiveThumbColor,
            inactiveTrackColor: widget.inactiveTrackColor,
            activeThumbImage: widget.activeThumbImage,
            inactiveThumbImage: widget.inactiveThumbImage,
            materialTapTargetSize: widget.materialTapTargetSize,
            dragStartBehavior: widget.dragStartBehavior,
            focusColor: widget.focusColor,
            hoverColor: widget.hoverColor,
            focusNode: widget.focusNode,
            autofocus: widget.autofocus,
          );
  }
}
