import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dart:math';

class DiceFaceCubit extends Cubit<int?> {
  DiceFaceCubit() : super(null);

  void rollDice() {
    int number;
    do {
      number = Random().nextInt(6);
    } while (number == 0);
    emit(number);
  }
}

const List<Color> colors = [
  Colors.red,
  Colors.green,
  Colors.blue,
  Colors.yellow,
  Colors.purple,
  Colors.orange,
];

class ColorCubit extends Cubit<Color> {
  ColorCubit() : super(Colors.green[300]!);

  void changeColor() {
    int number;
    do {
      number = Random().nextInt(6);
    } while (number == 0);
    emit(colors[number]);
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DiceFaceCubit>(
          create: (context) => DiceFaceCubit(),
        ),
        BlocProvider<ColorCubit>(
          create: (context) => ColorCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage2(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () {
            context.read<DiceFaceCubit>().rollDice();
          },
          child: Container(
            height: 100,
            width: 100,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.blue,
            ),
            child: BlocBuilder<DiceFaceCubit, int?>(
              builder: (context, state) {
                return Text(state != null ? "$state" : "click");
              },
            ),
          ),
        ),
      ),
    );
  }
}

class MyHomePage2 extends StatelessWidget {
  const MyHomePage2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(onTap: () {
          context.read<DiceFaceCubit>().rollDice();
          context.read<ColorCubit>().changeColor();
        }, child: Builder(builder: (context) {
          final numberState = context.watch<DiceFaceCubit>().state;
          final colorState = context.watch<ColorCubit>().state;

          return Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: colorState,
              ),
              child: Center(
                child: Text(
                  numberState != null ? "$numberState" : "click",
                  style: const TextStyle(color: Colors.black),
                ),
              ));
        })),
      ),
    );
  }
}

// class MyHomePage extends StatelessWidget {
//   const MyHomePage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final state = context.watch<DiceFaceCubit>().state;

//     return Scaffold(
//       body: Center(
//         child: GestureDetector(
//           onTap: () {},
//           child: Container(
//             height: 100,
//             width: 100,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(5),
//               color: Colors.blue,
//             ),
//             child: Text(state != null ? "$state" : "click"),
//           ),
//         ),
//       ),
//     );
//   }
// }


