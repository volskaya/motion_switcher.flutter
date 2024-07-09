// ignore_for_file: constant_identifier_names
//
// THIS FILE IS CODE GENERATED, DO NOT EDIT.

import 'package:flutter/material.dart';

const double _xxs = 8;
const double _xs = 16;
const double _sm = 24;
const double _md = 32;
const double _lg = 40;
const double _xl = 64;
const double _xxl = 72;

const double xxs = _xxs;
const double xs = _xs;
const double sm = _sm;
const double md = _md;
const double lg = _lg;
const double xl = _xl;
const double xxl = _xxl;

const double _lines = 2;
const double _stripes = 3;
const double _tile = 72;
const double _button = 48;

class Dimensions {
  const Dimensions._();

  static const double xxs = _xxs;
  static const double xs = _xs;
  static const double sm = _sm;
  static const double md = _md;
  static const double lg = _lg;
  static const double xl = _xl;
  static const double xxl = _xxl;

  static const double lines = _lines;
  static const double stripes = _stripes;
  static const double tile = _tile;
  static const double button = _button;
}

class Squares {
  const Squares._();

  static const Size xxs = Size(_xxs, _xxs);
  static const Size xs = Size(_xs, _xs);
  static const Size sm = Size(_sm, _sm);
  static const Size md = Size(_md, _md);
  static const Size lg = Size(_lg, _lg);
  static const Size xl = Size(_xl, _xl);
  static const Size xxl = Size(_xxl, _xxl);

  static const Size lines = Size(_lines, _lines);
  static const Size stripes = Size(_stripes, _stripes);
  static const Size tile = Size(_tile, _tile);
  static const Size button = Size(_button, _button);
}

class Widths {
  const Widths._();

  static const xxs = SizedBox(width: _xxs);
  static const xs = SizedBox(width: _xs);
  static const sm = SizedBox(width: _sm);
  static const md = SizedBox(width: _md);
  static const lg = SizedBox(width: _lg);
  static const xl = SizedBox(width: _xl);
  static const xxl = SizedBox(width: _xxl);

  static const lines = SizedBox(width: _lines);
  static const stripes = SizedBox(width: _stripes);
  static const tile = SizedBox(width: _tile);
  static const button = SizedBox(width: _button);
}

class Heights {
  const Heights._();

  static const xxs = SizedBox(height: _xxs);
  static const xs = SizedBox(height: _xs);
  static const sm = SizedBox(height: _sm);
  static const md = SizedBox(height: _md);
  static const lg = SizedBox(height: _lg);
  static const xl = SizedBox(height: _xl);
  static const xxl = SizedBox(height: _xxl);

  static const lines = SizedBox(height: _lines);
  static const stripes = SizedBox(height: _stripes);
  static const tile = SizedBox(height: _tile);
  static const button = SizedBox(height: _button);
}

class Verticals {
  const Verticals._();

  static const xxs = EdgeInsets.fromLTRB(0, _xxs, 0, _xxs);
  static const xs = EdgeInsets.fromLTRB(0, _xs, 0, _xs);
  static const sm = EdgeInsets.fromLTRB(0, _sm, 0, _sm);
  static const md = EdgeInsets.fromLTRB(0, _md, 0, _md);
  static const lg = EdgeInsets.fromLTRB(0, _lg, 0, _lg);
  static const xl = EdgeInsets.fromLTRB(0, _xl, 0, _xl);

  static const lines = EdgeInsets.fromLTRB(0, _lines, 0, _lines);
  static const stripes = EdgeInsets.fromLTRB(0, _stripes, 0, _stripes);
  static const tile = EdgeInsets.fromLTRB(0, _tile, 0, _tile);
  static const button = EdgeInsets.fromLTRB(0, _button, 0, _button);
}

class Horizontals {
  const Horizontals._();

  static const xxs = EdgeInsets.fromLTRB(_xxs, 0, _xxs, 0);
  static const xs = EdgeInsets.fromLTRB(_xs, 0, _xs, 0);
  static const sm = EdgeInsets.fromLTRB(_sm, 0, _sm, 0);
  static const md = EdgeInsets.fromLTRB(_md, 0, _md, 0);
  static const lg = EdgeInsets.fromLTRB(_lg, 0, _lg, 0);
  static const xl = EdgeInsets.fromLTRB(_xl, 0, _xl, 0);

  static const lines = EdgeInsets.fromLTRB(_lines, 0, _lines, 0);
  static const stripes = EdgeInsets.fromLTRB(_stripes, 0, _stripes, 0);
  static const tile = EdgeInsets.fromLTRB(_tile, 0, _tile, 0);
  static const button = EdgeInsets.fromLTRB(_button, 0, _button, 0);
}

class Paddings {
  const Paddings._();

  static const xxs = EdgeInsets.all(_xxs);
  static const xs = EdgeInsets.all(_xs);
  static const sm = EdgeInsets.all(_sm);
  static const md = EdgeInsets.all(_md);
  static const lg = EdgeInsets.all(_lg);
  static const xl = EdgeInsets.all(_xl);

  static const lines = EdgeInsets.all(_lines);
  static const stripes = EdgeInsets.all(_stripes);
  static const tile = EdgeInsets.all(_tile);
  static const button = EdgeInsets.all(_button);
}

class Radii {
  const Radii._();

  static const button = Radius.circular(12);
}

class BorderRadii {
  const BorderRadii._();

  static const button = BorderRadius.all(Radii.button);
}

class RoundedBorders {
  const RoundedBorders._();

  static const button = RoundedRectangleBorder(borderRadius: BorderRadii.button);
}

class BeveledBorders {
  const BeveledBorders._();

  static const button = BeveledRectangleBorder(borderRadius: BorderRadii.button);
}

class InputBorders {
  const InputBorders._();

  static const outline = OutlineInputBorder(
    borderRadius: BorderRadii.button,
  );
}

class Borders {
  const Borders._();

  static const sm = Border(
    top: BorderSide(width: 1, color: Color(0xFF212121)),
    left: BorderSide(width: 1, color: Color(0xFF212121)),
    bottom: BorderSide(width: 1, color: Color(0xFF212121)),
    right: BorderSide(width: 1, color: Color(0xFF212121)),
  );
}
