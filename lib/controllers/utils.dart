import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:image/image.dart' as img;

/// Baixa a imagem da internet e converte para BitmapDescriptor
  Future<BitmapDescriptor> getBitmapFromUrl(String url) async {
    final cacheManager = DefaultCacheManager();
    final file = await cacheManager.getSingleFile(url);
    final Uint8List imageData = await file.readAsBytes();

    final img.Image? image = img.decodeImage(imageData);
    if (image == null) return BitmapDescriptor.defaultMarker;

    final img.Image resized = img.copyResize(image, width: 70, height: 80);
    final ByteData byteData =
        ByteData.sublistView(Uint8List.fromList(img.encodePng(resized)));

    final ui.Codec codec = await ui.instantiateImageCodec(
      byteData.buffer.asUint8List(),
      targetWidth: 70,
      targetHeight: 80,
    );
    final ui.FrameInfo frameInfo = await codec.getNextFrame();
    final ByteData? convertedByteData =
        await frameInfo.image.toByteData(format: ui.ImageByteFormat.png);
    
    if (convertedByteData == null) return BitmapDescriptor.defaultMarker;
    
    final Uint8List finalData = convertedByteData.buffer.asUint8List();
    return BitmapDescriptor.bytes(finalData);
  }