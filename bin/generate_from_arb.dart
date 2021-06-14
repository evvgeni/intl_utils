import 'package:intl_utils/src/generator/intl_translation_helper.dart';

void main(List<String> args) {
  if (args.length < 4 || args[0] != '--output-dir') {
    _printHelp();
    return;
  }

  final outputDir = args[1];

  const dartStringFilesStart = 2;
  var i = dartStringFilesStart;
  while (args[i].endsWith('.dart')) {
    if (++i == args.length) {
      _printHelp();
      return;
    }
  }
  if (i == dartStringFilesStart) {
    _printHelp();
    return;
  }
  final dartStringFiles = args.sublist(dartStringFilesStart, i);

  final arbsStart = i;
  do {
    if (!args[i].endsWith('.arb')) {
      _printHelp();
      return;
    }
  } while (++i != args.length);
  final arbFiles = args.sublist(arbsStart);

  IntlTranslationHelper().generateFromArb(outputDir, dartStringFiles, arbFiles);
}

void _printHelp() {
  print('usage:\n'
      '  flutter pub run l10n_injection:generate_boilerplate'
      ' --output-dir <dir>'
      ' <string_file_1.dart string_file_2.dart ...>'
      ' <some.arb another.arb ...>');
}
