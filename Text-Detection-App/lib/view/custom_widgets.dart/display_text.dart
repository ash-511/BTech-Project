import 'package:flutter/material.dart';
import 'package:text_recognition/providers/text_provider.dart';
import 'package:text_recognition/repositories/text_recongnize.dart';

class DisplayText extends StatelessWidget {
  final TextViewModel? textProvider;
  const DisplayText(this.textProvider, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
        child: Text(" "),
    )]

        // Expanded(
        //   child: ListView.builder(
        //     itemCount: textProvider!.processedTexts!.length,
        //     padding: const EdgeInsets.all(12.0),
        //     itemBuilder: (_, index) {
        //       return Center(
        //         child: ListTile(
        //             title: Center(
        //           child: SelectableText(
        //               '${index + 1}: ${textProvider!.processedTexts![index].block}'),
        //         )),
        //       );
        //     },
        //   ),
        // ),

    );
  }
}
