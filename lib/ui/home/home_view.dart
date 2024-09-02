import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top / 0.6, left: 20),
            child: const Text(
              'Card Portfolio',
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 22),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 200),
            child: SizedBox(
              height: 340,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 120,
                      color: Colors.orange,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
