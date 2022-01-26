import 'package:flutter/material.dart';

class TestView extends StatefulWidget {
  TestView({Key? key}) : super(key: key);

  @override
  _TestViewState createState() => _TestViewState();
}

class _TestViewState extends State<TestView> {
  AlignmentGeometry _alignment = Alignment.topCenter;
  final size = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(40),
          height: double.infinity,
          width: double.infinity,
          child: Container(
            color: Colors.green,
            child: Stack(
              children: [
                GridView.builder(
                  padding: const EdgeInsets.all(10),
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 5,
                  ),
                  itemCount: 9,
                  itemBuilder: (context, index) {
                    return AnimatedAlign(
                      alignment: FractionalOffset(
                        (2 - 1) / (size - 1),
                        (2 - 1) / (size - 1),
                      ),
                      duration: const Duration(seconds: 2),
                      child: Container(
                        color: Colors.red,
                        height: 20,
                        width: 20,
                      ),
                    );
                  },
                ),
                ElevatedButton(
                    onPressed: () {
                      print('Si lo intenta');
                      setState(() {
                        _alignment = Alignment.bottomCenter;
                      });
                    },
                    child: const Text('Mover'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
