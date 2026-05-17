// Copyright 2023 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:math' as math;

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'components/components.dart';
import 'config.dart';

enum PlayState { welcome, playing, gameOver, won }

class BrickBreaker extends FlameGame
    with HasCollisionDetection, KeyboardEvents, TapCallbacks {
  BrickBreaker()
      : super(
          camera: CameraComponent.withFixedResolution(
            width: gameWidth,
            height: gameHeight,
          ),
        );

  final ValueNotifier<int> score = ValueNotifier(0);
  final rand = math.Random();
  
  late Paddle leftPaddle;
  late Paddle rightPaddle;

  double get width => size.x;
  double get height => size.y;

  late PlayState _playState;

  PlayState get playState => _playState;

  set playState(PlayState playState) {
    _playState = playState;

    switch (playState) {
      case PlayState.welcome:
      case PlayState.gameOver:
      case PlayState.won:
        overlays.add(playState.name);
      case PlayState.playing:
        overlays.remove(PlayState.welcome.name);
        overlays.remove(PlayState.gameOver.name);
        overlays.remove(PlayState.won.name);
    }
  }

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();

    camera.viewfinder.anchor = Anchor.topLeft;

    world.add(PlayArea());

    playState = PlayState.welcome;
  }

  void startGame() {
    if (playState == PlayState.playing) return;

    world.removeAll(world.children.query<Ball>());
    world.removeAll(world.children.query<Paddle>());

    playState = PlayState.playing;
    score.value = 0;

    world.add(
      Ball(
        difficultyModifier: difficultyModifier,
        radius: ballRadius,
        position: size / 2,
        velocity: Vector2(
          (rand.nextDouble() - 0.5) * width,
          height * 0.2,
        ).normalized()..scale(height / 4),
      ),
    );

    leftPaddle = Paddle(
      size: Vector2(paddleWidth, paddleHeight),
      cornerRadius: const Radius.circular(ballRadius / 2),
      position: Vector2(width * 0.08, height / 2),
    );

    rightPaddle = Paddle(
      size: Vector2(paddleWidth, paddleHeight),
      cornerRadius: const Radius.circular(ballRadius / 2),
      position: Vector2(width * 0.92, height / 2),
    );

    world.add(leftPaddle);
    world.add(rightPaddle);
  }

  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    startGame();
  }

  @override
  KeyEventResult onKeyEvent(
    KeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    super.onKeyEvent(event, keysPressed);

    if (playState != PlayState.playing) {
      if (event.logicalKey == LogicalKeyboardKey.space ||
          event.logicalKey == LogicalKeyboardKey.enter) {
        startGame();
      }

      return KeyEventResult.handled;
    }

    if (keysPressed.contains(LogicalKeyboardKey.keyW) ||
        keysPressed.contains(LogicalKeyboardKey.keyA)) {
      leftPaddle.moveBy(-paddleStep);
    }

    if (keysPressed.contains(LogicalKeyboardKey.keyS) ||
        keysPressed.contains(LogicalKeyboardKey.keyD)) {
      leftPaddle.moveBy(paddleStep);
    }

    if (keysPressed.contains(LogicalKeyboardKey.arrowUp) ||
        keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
      rightPaddle.moveBy(-paddleStep);
    }

    if (keysPressed.contains(LogicalKeyboardKey.arrowDown) ||
        keysPressed.contains(LogicalKeyboardKey.arrowLeft)) {
      rightPaddle.moveBy(paddleStep);
    }

    return KeyEventResult.handled;
  }

  @override
  Color backgroundColor() => const Color(0xfff2e8cf);
}
