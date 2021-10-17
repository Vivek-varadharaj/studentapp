import 'package:flutter/material.dart';

class DropDown extends StatelessWidget {
  final currentItemSelected;
  final changeIt;
  DropDown(this.currentItemSelected, this.changeIt);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              color: Colors.grey,
              child: DropdownButtonFormField(
                items: [
                  DropdownMenuItem(
                    child: Text("Passed"),
                    value: "Passed",
                  ),
                  DropdownMenuItem(
                    child: Text("Failed"),
                    value: "Failed",
                  )
                ],
                onChanged: (value) {
                  changeIt(value);
                },
                hint: Text(
                  "Status",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                value: currentItemSelected,
                validator: (value) {
                  if (value == null || value == "Status") {
                    return "Required field";
                  }
                  return null;
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
