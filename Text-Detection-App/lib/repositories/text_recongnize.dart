import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:text_recognition/model/data_layer.dart';

class MlService {
  var scanText = "";
  Future<List<RecognizedText>> getText(String path) async {
    final inputImage = InputImage.fromFilePath(path);
    final textDetector = GoogleMlKit.vision.textDetector();
    final RecognisedText recognisedText =
        await textDetector.processImage(inputImage);

    final String text=recognisedText.text;
    List<RecognizedText> recognizedList = [];

    for (TextBlock block in recognisedText.blocks) {
      recognizedList.add(
          RecognizedText(lines: block.lines, block: block.text.toLowerCase()));
    }

    for (TextBlock block in recognisedText.blocks) {
      for (TextLine line in block.lines) {
        for (TextElement element in line.elements) {

            scanText = scanText + '  ' + element.text;
        }
        scanText = scanText + ' ';
      }
    }


    //recognizedList.forEach((element) {concatenate.write(element);});
    // for(var i in recognizedList){
    //   con=con+i.block.toString();
    //
    // }
    // print(con);
    print(scanText);
    return scanText;
    //return recognizedList;
  }
}
