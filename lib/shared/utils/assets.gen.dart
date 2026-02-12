/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart' as _svg;
import 'package:vector_graphics/vector_graphics.dart' as _vg;

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/account_icon.svg
  SvgGenImage get accountIcon =>
      const SvgGenImage('assets/icons/account_icon.svg');

  /// File path: assets/icons/bookings_icon.svg
  SvgGenImage get bookingsIcon =>
      const SvgGenImage('assets/icons/bookings_icon.svg');

  /// File path: assets/icons/cart_icon.svg
  SvgGenImage get cartIcon => const SvgGenImage('assets/icons/cart_icon.svg');

  /// File path: assets/icons/cleaning_icon.svg
  SvgGenImage get cleaningIcon =>
      const SvgGenImage('assets/icons/cleaning_icon.svg');

  /// File path: assets/icons/home_icon.svg
  SvgGenImage get homeIcon => const SvgGenImage('assets/icons/home_icon.svg');

  /// File path: assets/icons/plumbing_icon.svg
  SvgGenImage get plumbingIcon =>
      const SvgGenImage('assets/icons/plumbing_icon.svg');

  /// File path: assets/icons/recycle_bin_icon.svg
  SvgGenImage get recycleBinIcon =>
      const SvgGenImage('assets/icons/recycle_bin_icon.svg');

  /// File path: assets/icons/search_icon.svg
  SvgGenImage get searchIcon =>
      const SvgGenImage('assets/icons/search_icon.svg');

  /// List of all assets
  List<SvgGenImage> get values => [
    accountIcon,
    bookingsIcon,
    cartIcon,
    cleaningIcon,
    homeIcon,
    plumbingIcon,
    recycleBinIcon,
    searchIcon,
  ];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/bathroom_cleaning.png
  AssetGenImage get bathroomCleaning =>
      const AssetGenImage('assets/images/bathroom_cleaning.png');

  /// File path: assets/images/carpet_cleaning.png
  AssetGenImage get carpetCleaning =>
      const AssetGenImage('assets/images/carpet_cleaning.png');

  /// File path: assets/images/home_cleaning.png
  AssetGenImage get homeCleaning =>
      const AssetGenImage('assets/images/home_cleaning.png');

  /// File path: assets/images/perfect_cleaning.png
  AssetGenImage get perfectCleaning =>
      const AssetGenImage('assets/images/perfect_cleaning.png');

  /// File path: assets/images/sofa_cleaning.png
  AssetGenImage get sofaCleaning =>
      const AssetGenImage('assets/images/sofa_cleaning.png');

  /// List of all assets
  List<AssetGenImage> get values => [
    bathroomCleaning,
    carpetCleaning,
    homeCleaning,
    perfectCleaning,
    sofaCleaning,
  ];
}

class Assets {
  const Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName, {this.size, this.flavors = const {}});

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class SvgGenImage {
  const SvgGenImage(this._assetName, {this.size, this.flavors = const {}})
    : _isVecFormat = false;

  const SvgGenImage.vec(this._assetName, {this.size, this.flavors = const {}})
    : _isVecFormat = true;

  final String _assetName;
  final Size? size;
  final Set<String> flavors;
  final bool _isVecFormat;

  _svg.SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    _svg.SvgTheme? theme,
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    final _svg.BytesLoader loader;
    if (_isVecFormat) {
      loader = _vg.AssetBytesLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
      );
    } else {
      loader = _svg.SvgAssetLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
        theme: theme,
      );
    }
    return _svg.SvgPicture(
      loader,
      key: key,
      matchTextDirection: matchTextDirection,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      colorFilter:
          colorFilter ??
          (color == null ? null : ColorFilter.mode(color, colorBlendMode)),
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
