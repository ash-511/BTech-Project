import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:text_recognition/providers/text_provider.dart';

import 'image_provider.dart';

List<SingleChildWidget> providers = [
  ///List of all providers
  ChangeNotifierProvider<ImageViewModel>(
    create: (context) => ImageViewModel(),
  ),
  ChangeNotifierProxyProvider<ImageViewModel, TextViewModel>(
    create: (_) => TextViewModel(),
    update: (BuildContext context, ImageViewModel? imageProvider,
        TextViewModel? textprovider) {
      textprovider!.imageProvider = imageProvider!;
      return textprovider;
    },
    lazy: true,
  ),
];
