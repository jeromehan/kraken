import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:kraken/rendering.dart';
import 'package:kraken/css.dart';

// CSS Overflow: https://drafts.csswg.org/css-overflow-3/

enum CSSOverflowType {
  auto,
  visible,
  hidden,
  scroll,
}

List<CSSOverflowType> getOverflowFromStyle(CSSStyleDeclaration style) {
  CSSOverflowType overflowX, overflowY;
  overflowX = overflowY = _getOverflow(style['overflow']);

  if (style.contains('overflowX')) {
    overflowX = _getOverflow(style['overflowX']);
  }

  if (style.contains('overflowY')) {
    overflowY = _getOverflow(style['overflowY']);
  }

  // Apply overflow special rules from w3c.
  if (overflowX == CSSOverflowType.visible &&
      overflowY != CSSOverflowType.visible) {
    overflowX = CSSOverflowType.auto;
  }

  if (overflowY == CSSOverflowType.visible &&
      overflowX != CSSOverflowType.visible) {
    overflowY = CSSOverflowType.auto;
  }

  return [overflowX, overflowY];
}

CSSOverflowType _getOverflow(String definition) {
  switch (definition) {
    case 'hidden':
      return CSSOverflowType.hidden;
    case 'scroll':
      return CSSOverflowType.scroll;
    case 'auto':
      return CSSOverflowType.auto;
    case 'visible':
      return CSSOverflowType.visible;
  }
  return CSSOverflowType.visible;
}

mixin CSSOverflowMixin {
  RenderObject _renderObjectX;
  RenderObject _child;
  RenderObject _renderObjectY;
  KrakenScrollable _scrollableX;
  KrakenScrollable _scrollableY;

  RenderObject initOverflowBox(RenderObject current, CSSStyleDeclaration style,
      void scrollListener(double scrollTop)) {
    assert(style != null);
    _child = current;
    List<CSSOverflowType> overflow = getOverflowFromStyle(style);
    // X direction overflow
    _renderObjectX = _getRenderObjectByOverflow(
        overflow[0], current, AxisDirection.right, scrollListener);
    // Y direction overflow
    _renderObjectY = _getRenderObjectByOverflow(
        overflow[1], _renderObjectX, AxisDirection.down, scrollListener);
    return _renderObjectY;
  }

  void updateOverFlowBox(
      CSSStyleDeclaration style, void scrollListener(double scrollTop)) {
    if (style != null) {
      List<CSSOverflowType> overflow = getOverflowFromStyle(style);

      if (_renderObjectY != null) {
        AbstractNode parent = _renderObjectY.parent;
        AbstractNode childParent = _renderObjectX.parent;
        AxisDirection axisDirection = AxisDirection.down;
        switch (overflow[1]) {
          case CSSOverflowType.visible:
            assert(parent is RenderObjectWithChildMixin);
            assert(childParent is RenderObjectWithChildMixin);
            if (parent is RenderObjectWithChildMixin &&
                childParent is RenderObjectWithChildMixin) {
              childParent.child = null;
              CSSOverflowDirectionBox overflowCustomBox =
                  CSSOverflowDirectionBox(
                      child: _renderObjectX,
                      textDirection: TextDirection.ltr,
                      axisDirection: axisDirection);
              parent.child = _renderObjectY = overflowCustomBox;
              _scrollableY = null;
            }
            break;
          case CSSOverflowType.auto:
          case CSSOverflowType.scroll:
            assert(parent is RenderObjectWithChildMixin);
            assert(childParent is RenderObjectWithChildMixin);
            if (parent is RenderObjectWithChildMixin &&
                childParent is RenderObjectWithChildMixin) {
              childParent.child = null;
              _scrollableY = KrakenScrollable(
                  axisDirection: axisDirection, scrollListener: scrollListener);
              parent.child = _renderObjectY =
                  _scrollableY.getScrollableRenderObject(_renderObjectX);
            }
            break;
          case CSSOverflowType.hidden:
            assert(parent is RenderObjectWithChildMixin);
            assert(childParent is RenderObjectWithChildMixin);
            if (parent is RenderObjectWithChildMixin &&
                childParent is RenderObjectWithChildMixin) {
              childParent.child = null;
              parent.child = _renderObjectY = RenderSingleChildViewport(
                  axisDirection: axisDirection,
                  offset: ViewportOffset.zero(),
                  child: _renderObjectX,
                  shouldClip: true);
              _scrollableY = null;
            }
            break;
        }
      }

      if (_renderObjectX != null) {
        AbstractNode parent = _renderObjectX.parent;
        AbstractNode childParent = _child.parent;
        AxisDirection axisDirection = AxisDirection.right;
        switch (overflow[0]) {
          case CSSOverflowType.visible:
            assert(parent is RenderObjectWithChildMixin);
            assert(childParent is RenderObjectWithChildMixin);
            if (parent is RenderObjectWithChildMixin &&
                childParent is RenderObjectWithChildMixin) {
              childParent.child = null;
              parent.child = _renderObjectX = CSSOverflowDirectionBox(
                  child: _child,
                  textDirection: TextDirection.ltr,
                  axisDirection: axisDirection);
              _scrollableX = null;
            }
            break;
          case CSSOverflowType.auto:
          case CSSOverflowType.scroll:
            assert(parent is RenderObjectWithChildMixin);
            assert(childParent is RenderObjectWithChildMixin);
            if (parent is RenderObjectWithChildMixin &&
                childParent is RenderObjectWithChildMixin) {
              childParent.child = null;
              _scrollableX = KrakenScrollable(
                  axisDirection: axisDirection, scrollListener: scrollListener);
              parent.child = _renderObjectX =
                  _scrollableX.getScrollableRenderObject(_child);
            }
            break;
          case CSSOverflowType.hidden:
            assert(parent is RenderObjectWithChildMixin);
            assert(childParent is RenderObjectWithChildMixin);
            if (parent is RenderObjectWithChildMixin &&
                childParent is RenderObjectWithChildMixin) {
              childParent.child = null;
              parent.child = _renderObjectX = RenderSingleChildViewport(
                  axisDirection: axisDirection,
                  offset: ViewportOffset.zero(),
                  child: _child,
                  shouldClip: true);
              _scrollableX = null;
            }
            break;
        }
      }
    }
  }

  RenderObject _getRenderObjectByOverflow(
      CSSOverflowType overflow,
      RenderObject current,
      AxisDirection axisDirection,
      void scrollListener(double scrollTop)) {
    switch (overflow) {
      case CSSOverflowType.visible:
        if (axisDirection == AxisDirection.right) {
          _scrollableX = null;
        } else {
          _scrollableY = null;
        }
        current = CSSOverflowDirectionBox(
          child: current,
          textDirection: TextDirection.ltr,
          axisDirection: axisDirection,
        );
        break;
      case CSSOverflowType.auto:
      case CSSOverflowType.scroll:
        KrakenScrollable scrollable = KrakenScrollable(
            axisDirection: axisDirection, scrollListener: scrollListener);
        if (axisDirection == AxisDirection.right) {
          _scrollableX = scrollable;
        } else {
          _scrollableY = scrollable;
        }
        current = scrollable.getScrollableRenderObject(current);
        break;
      case CSSOverflowType.hidden:
        if (axisDirection == AxisDirection.right) {
          _scrollableX = null;
        } else {
          _scrollableY = null;
        }
        current = RenderSingleChildViewport(
            axisDirection: axisDirection,
            offset: ViewportOffset.zero(),
            child: current,
            shouldClip: true);
        break;
    }
    return current;
  }

  double getScrollTop() {
    if (_scrollableY != null) {
      return _scrollableY.position?.pixels ?? 0;
    }
    return 0;
  }

  double getScrollLeft() {
    if (_scrollableX != null) {
      return _scrollableX.position?.pixels ?? 0;
    }
    return 0;
  }

  double getScrollHeight() {
    if (_scrollableY != null) {
      return _scrollableY.renderBox?.size?.height ?? 0;
    } else if (_renderObjectY is RenderBox) {
      RenderBox renderObjectY = _renderObjectY as RenderBox;
      return renderObjectY.hasSize ? renderObjectY.size.height : 0;
    }
    return 0;
  }

  double getScrollWidth() {
    if (_scrollableX != null) {
      return _scrollableX.renderBox?.size?.width ?? 0;
    } else if (_renderObjectX is RenderBox) {
      RenderBox renderObjectX = _renderObjectX as RenderBox;
      return renderObjectX.hasSize ? renderObjectX.size.width : 0;
    }
    return 0;
  }

  void scroll(List args, {bool isScrollBy = false}) {
    if (args != null && args.length > 0) {
      dynamic option = args[0];
      if (option is Map) {
        num top = option['top'];
        num left = option['left'];
        dynamic behavior = option['behavior'];
        Curve curve;
        if (behavior == 'smooth') {
          curve = Curves.linear;
        }
        _scroll(top, curve, isScrollBy: isScrollBy, isDirectionX: false);
        _scroll(left, curve, isScrollBy: isScrollBy, isDirectionX: true);
      }
    }
  }

  void _scroll(num aim, Curve curve,
      {bool isScrollBy = false, bool isDirectionX = false}) {
    Duration duration;
    KrakenScrollable scrollable;
    if (isDirectionX) {
      scrollable = _scrollableX;
    } else {
      scrollable = _scrollableY;
    }
    if (scrollable != null && aim != null) {
      if (curve != null) {
        double diff = aim - (scrollable.position?.pixels ?? 0);
        duration = Duration(milliseconds: diff.abs().toInt() * 5);
      }
      double distance;
      if (isScrollBy) {
        distance = (scrollable.position?.pixels ?? 0) + aim;
      } else {
        distance = aim.toDouble();
      }
      scrollable.position.moveTo(distance, duration: duration, curve: curve);
    }
  }
}

class CSSOverflowDirectionBox extends RenderSizedOverflowBox {
  AxisDirection axisDirection;

  CSSOverflowDirectionBox(
      {RenderBox child,
      Size requestedSize = Size.zero,
      AlignmentGeometry alignment = Alignment.topLeft,
      TextDirection textDirection,
      this.axisDirection})
      : assert(requestedSize != null),
        super(
            child: child,
            alignment: alignment,
            textDirection: textDirection,
            requestedSize: requestedSize);

  @override
  void performLayout() {
    assert(child != null);
    BoxConstraints childConstraints;
    if (axisDirection == AxisDirection.down) {
      childConstraints =
          constraints.copyWith(minHeight: 0, maxHeight: double.infinity);
    } else {
      childConstraints =
          constraints.copyWith(minWidth: 0, maxWidth: double.infinity);
    }
    child.layout(childConstraints, parentUsesSize: true);
    size = constraints.constrain(child.size);
    alignChild();
  }

  @override
  void debugPaintSize(PaintingContext context, Offset offset) {
    super.debugPaintSize(context, offset);
    assert(() {
      final Rect outerRect = offset & size;
      debugPaintPadding(context.canvas, outerRect, outerRect);
      return true;
    }());
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
        DiagnosticsProperty<AxisDirection>('axisDirection', axisDirection));
    properties.add(EnumProperty<TextDirection>('textDirection', textDirection,
        defaultValue: null));
  }
}