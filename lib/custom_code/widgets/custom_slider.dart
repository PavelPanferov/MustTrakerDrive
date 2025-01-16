// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

class CustomSlider extends StatefulWidget {
  const CustomSlider({
    super.key,
    this.width,
    this.height,
    required this.tracker,
    required this.onChanged,
    required this.iconON,
    required this.iconOFF,
    required this.colorON,
    required this.colorOFF,
    required this.textON,
    required this.textOFF,
    required this.fontSize,
    required this.fontWeight,
    required this.textPadding,
    required this.iconPaddingRight,
    required this.iconPaddingLeft,
  });

  final double? width;
  final double? height;
  final bool tracker;
  final Future Function() onChanged;
  final Widget iconON;
  final Widget iconOFF;
  final Color colorON;
  final Color colorOFF;
  final String textON;
  final String textOFF;
  final double fontSize;
  final double fontWeight;
  final double textPadding;
  final double iconPaddingRight;
  final double iconPaddingLeft;

  FontWeight _getFontWeight() {
    switch (fontWeight.toInt()) {
      case 700:
        return FontWeight.bold;
      case 600:
        return FontWeight.w600;
      case 500:
        return FontWeight.w500;
      case 400:
        return FontWeight.normal;
      default:
        return FontWeight.normal;
    }
  }

  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool _isDragging = false;
  bool _isOn = false;

  @override
  void initState() {
    super.initState();
    _isOn = widget.tracker;
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
      value: _isOn ? 1.0 : 0.0,
    );
  }

  @override
  void didUpdateWidget(CustomSlider oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.tracker != oldWidget.tracker) {
      _isOn = widget.tracker;
      if (_isOn) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _handleTap() async {
    if (_isDragging) return;

    setState(() {
      _isOn = !_isOn;
      if (_isOn) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });

    await widget.onChanged();
  }

  void _onDragUpdate(DragUpdateDetails details) {
    setState(() {
      _isDragging = true;
      final widgetWidth = widget.width ?? 200.0;
      final newValue = (_animationController.value +
              details.primaryDelta! / (widgetWidth - 60))
          .clamp(0.0, 1.0);
      _animationController.value = newValue;
    });
  }

  void _onDragEnd(DragEndDetails details) async {
    if (_animationController.value > 0.5) {
      _animationController.forward();
      _isOn = true;
    } else {
      _animationController.reverse();
      _isOn = false;
    }

    setState(() {
      _isDragging = false;
    });

    await widget.onChanged();
  }

  void _onDragStart(DragStartDetails details) {
    setState(() {
      _isDragging = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      onHorizontalDragStart: _onDragStart,
      onHorizontalDragUpdate: _onDragUpdate,
      onHorizontalDragEnd: _onDragEnd,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          final value = _animationController.value;
          final currentColor =
              Color.lerp(widget.colorOFF, widget.colorON, value)!;
          final containerWidth = widget.width ?? 200.0;
          final containerHeight = widget.height ?? 60.0;
          final iconSize = containerHeight - 8.0;

          return Container(
            width: containerWidth,
            height: containerHeight,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).primaryBackground,
              borderRadius: BorderRadius.circular(containerHeight / 2),
              border: Border.all(color: currentColor, width: 2.0),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                AnimatedPositioned(
                  duration: Duration(milliseconds: _isDragging ? 0 : 200),
                  curve: Curves.easeInOut,
                  left: value > 0.5
                      ? containerWidth - iconSize - widget.iconPaddingRight
                      : widget.iconPaddingLeft,
                  child: Container(
                    width: iconSize,
                    height: iconSize,
                    decoration: BoxDecoration(
                      color: currentColor,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: AnimatedSwitcher(
                        duration: Duration(milliseconds: 200),
                        child: value < 0.5 ? widget.iconOFF : widget.iconON,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: widget.iconPaddingLeft + iconSize + widget.textPadding,
                  child: AnimatedOpacity(
                    opacity: value < 0.5 ? 1.0 : 0.0,
                    duration: Duration(milliseconds: 200),
                    child: Text(
                      widget.textOFF,
                      style: FlutterFlowTheme.of(context).bodyMedium.copyWith(
                            fontFamily: 'Primary',
                            color: widget.colorOFF,
                            fontSize: widget.fontSize,
                            fontWeight: widget._getFontWeight(),
                          ),
                    ),
                  ),
                ),
                Positioned(
                  right:
                      widget.iconPaddingRight + iconSize + widget.textPadding,
                  child: AnimatedOpacity(
                    opacity: value > 0.5 ? 1.0 : 0.0,
                    duration: Duration(milliseconds: 200),
                    child: Text(
                      widget.textON,
                      style: FlutterFlowTheme.of(context).bodyMedium.copyWith(
                            fontFamily: 'Primary',
                            color: widget.colorON,
                            fontSize: widget.fontSize,
                            fontWeight: widget._getFontWeight(),
                          ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
