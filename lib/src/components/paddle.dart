// Copyright 2023 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

import '../brick_breaker.dart';

class Paddle extends PositionComponent
    with DragCallbacks, HasGameReference<BrickBreaker> {
  Paddle({
    required this.cornerRadius,
    required super.position,
    required super.size,
  }) : super(anchor: Anchor.center, children: [RectangleHitbox()]);

  final Radius cornerRadius;

  final _paint = Paint()
    ..color = const Color(0xff1e6091)
    ..style = PaintingStyle.fill;

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRRect(
      RRect.fromRectAndRadius(Offset.zero & size.toSize(), cornerRadius),
      _paint,
    );
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    super.onDragUpdate(event);
    final minY = size.y / 2;
    final maxY = game.height - size.y / 2;

    position.y = (position.y + event.localDelta.y).clamp(minY, maxY);
  }

  void moveBy(double dy) {
    final minY = size.y / 2;
    final maxY = game.height - size.y / 2;

    add(
      MoveToEffect(
        Vector2(position.x, (position.y + dy).clamp(minY, maxY)),
        EffectController(duration: 0.1),
      ),
    );
  }
}
