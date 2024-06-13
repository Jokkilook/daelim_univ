import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PickCard extends StatelessWidget {
  PickCard({super.key});
  final Rxn<Color> rxColor = Rxn();

  Widget _buildCard({required Color color}) {
    Widget child({
      required bool isFeedback,
    }) =>
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            border: isFeedback ? Border.all(width: 2) : null,
            color: color,
            borderRadius: BorderRadius.circular(10),
          ),
        );
    return Draggable(
      data: color,
      feedback: child(isFeedback: true),
      child: child(isFeedback: false),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: Column(
        children: [
          Expanded(
            child: Obx(
              () {
                final color = rxColor.value;

                return DragTarget(
                  onAcceptWithDetails: (details) {
                    final data = details.data;

                    if (data is Color) {
                      rxColor.value = data;
                    }
                  },
                  builder: (context, candidateData, rejectedData) {
                    String text = "Drag and Drop";
                    if (candidateData.isNotEmpty) {
                      text = "Drop the card!!!";
                    }
                    return Container(
                      decoration: BoxDecoration(
                        color: color,
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        text,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildCard(color: Colors.pink[200]!),
                _buildCard(color: Colors.yellow),
                _buildCard(color: Colors.lightBlue),
              ],
            ),
          )
        ],
      ),
    );
  }
}
