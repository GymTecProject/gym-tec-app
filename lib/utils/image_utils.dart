 import 'package:flutter_svg/flutter_svg.dart';

class ImageUtils {
    
      static const String imageHistory = 'assets/images/logo-gymtec-fondo-claro.svg';
      static const String imageShared = 'assets/images/logo-gymtec-fondo-oscuro.svg';
    
    
     static void svgPrecacheImage() {

        const cacheSvgImages = [  /// Specify the all the svg image to cache 
          ImageUtils.imageHistory,
          ImageUtils.imageShared,
        ];
    
        for (String element in cacheSvgImages) {
          var loader = SvgAssetLoader(element);
          svg.cache
              .putIfAbsent(loader.cacheKey(null), () => loader.loadBytes(null));
        }

      }
    
    }