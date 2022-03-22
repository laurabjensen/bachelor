import 'package:flutter/material.dart';

class CustomSelectableGrid extends StatefulWidget {
  @override
  _CustomSelectableGridState createState() => _CustomSelectableGridState();
}

class _CustomSelectableGridState extends State<CustomSelectableGrid> {
  // set an int with value -1 since no card has been selected
  int selectedCard = -1;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Expanded(
      child: GridView.builder(
          shrinkWrap: false,
          scrollDirection: Axis.vertical,
          itemCount: 10,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio:
                MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height / 3),
          ),
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  // ontap of each card, set the defined int to the grid view index
                  selectedCard = index;
                });
              },
              child: Card(
                // check if the index is equal to the selected Card integer
                color: selectedCard == index ? Colors.blue : Colors.grey,
                child: SizedBox(
                  height: 200,
                  width: 200,
                  child: Center(
                    child: Text(
                      '$index',
                      style: theme.primaryTextTheme.headline1!.copyWith(fontSize: 30),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
