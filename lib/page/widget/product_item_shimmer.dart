import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProductItemShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 80,
                  height: 20,
                  color: Colors.white,
                ),
                Switch(
                  value: false,
                  activeColor: Colors.green,
                  onChanged: (value) {},
                ),
              ],
            ),
            Expanded(
              child: Container(
                width: 110,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              height: 20,
              color: Colors.white,
            ),
            const SizedBox(height: 5),
            Container(
              height: 16,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
