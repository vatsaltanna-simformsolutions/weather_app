// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_theme_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AppThemeStore on _AppThemeStore, Store {
  late final _$themeModeAtom =
      Atom(name: '_AppThemeStore.themeMode', context: context);

  @override
  ThemeMode get themeMode {
    _$themeModeAtom.reportRead();
    return super.themeMode;
  }

  @override
  set themeMode(ThemeMode value) {
    _$themeModeAtom.reportWrite(value, super.themeMode, () {
      super.themeMode = value;
    });
  }

  late final _$_AppThemeStoreActionController =
      ActionController(name: '_AppThemeStore', context: context);

  @override
  void changeTheme({bool isDarkMode = true}) {
    final _$actionInfo = _$_AppThemeStoreActionController.startAction(
        name: '_AppThemeStore.changeTheme');
    try {
      return super.changeTheme(isDarkMode: isDarkMode);
    } finally {
      _$_AppThemeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
themeMode: ${themeMode}
    ''';
  }
}
