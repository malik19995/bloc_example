// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bloc_example/main.dart';

void main() {
  DiceFaceCubit diceFaceCubit = DiceFaceCubit();
  ColorCubit colorCubit = ColorCubit();

  blocTest<DiceFaceCubit, int?>(
    'Changes value of int when '
    'rollDice() is called successfully.',
    setUp: () => diceFaceCubit.state,
    build: () => diceFaceCubit,
    act: (cubit) => cubit.rollDice(),
    expect: () {
      return [0, 1, 2, 3, 4, 5].contains(diceFaceCubit.state)
          ? [diceFaceCubit.state]
          : [];
    },
    verify: (_) async {
      () => diceFaceCubit.rollDice();
    },
  );

  blocTest<ColorCubit, Color>(
    'Changes value of color when '
    'changeColor() is called successfully.',
    setUp: () => colorCubit.state,
    build: () => colorCubit,
    act: (cubit) => cubit.changeColor(),
    expect: () {
      return colors.contains(colorCubit.state) ? [colorCubit.state] : [];
    },
    verify: (_) async {
      () => colorCubit.changeColor();
    },
  );
  testWidgets('Bloc Dice smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our initial state is click.
    expect(find.text('click'), findsOneWidget);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.text('click'));
    await tester.pump();

    // Verify that our dice has rolled.
    expect(find.text('click'), findsNothing);
  });
}
