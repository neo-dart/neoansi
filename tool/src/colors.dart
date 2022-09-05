// ignore_for_file: cast_nullable_to_non_nullable

import 'dart:convert';

/// Decodes [jsonText] into a list of color definitions.
///
/// Format: <https://www.ditig.com/downloads/256-colors.json>
List<ColorDefinition> decodeJsonColors(String jsonText) {
  return (jsonDecode(jsonText) as List<Object?>)
      .cast<_JsonObject>()
      .map(const _JsonToColorDecoder().convert)
      .toList();
}

typedef _JsonObject = Map<String, Object?>;

class _JsonToColorDecoder extends Converter<_JsonObject, ColorDefinition> {
  const _JsonToColorDecoder();

  @override
  ColorDefinition convert(_JsonObject input) {
    final rgb = input['rgb'] as _JsonObject;
    return ColorDefinition._(
      rgb: Rgb._(
        r: rgb['r'] as int,
        b: rgb['b'] as int,
        g: rgb['g'] as int,
      ),
      name: input['name'] as String,
    );
  }
}

class ColorDefinition {
  final Rgb rgb;
  final String name;

  const ColorDefinition._({
    required this.rgb,
    required this.name,
  });
}

class Rgb {
  final int r;
  final int g;
  final int b;

  const Rgb._({
    required this.r,
    required this.g,
    required this.b,
  });
}
