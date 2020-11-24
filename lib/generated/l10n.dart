// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Movie Advisor`
  String get moviesListAppBarTitle {
    return Intl.message(
      'Movie Advisor',
      name: 'moviesListAppBarTitle',
      desc: '',
      args: [],
    );
  }

  /// `Favorites`
  String get favoriteMoviesAppBarTitle {
    return Intl.message(
      'Favorites',
      name: 'favoriteMoviesAppBarTitle',
      desc: '',
      args: [],
    );
  }

  /// `No favorite movies yet.`
  String get favoriteMoviesEmptyStateMessage {
    return Intl.message(
      'No favorite movies yet.',
      name: 'favoriteMoviesEmptyStateMessage',
      desc: '',
      args: [],
    );
  }

  /// `Movie details`
  String get movieDetailsAppBarTitle {
    return Intl.message(
      'Movie details',
      name: 'movieDetailsAppBarTitle',
      desc: '',
      args: [],
    );
  }

  /// `Synopsis`
  String get movieDetailsSynopsisTitle {
    return Intl.message(
      'Synopsis',
      name: 'movieDetailsSynopsisTitle',
      desc: '',
      args: [],
    );
  }

  /// `Genres`
  String get movieDetailsGenresTitle {
    return Intl.message(
      'Genres',
      name: 'movieDetailsGenresTitle',
      desc: '',
      args: [],
    );
  }

  /// `Added to favorites`
  String get movieDetailsAddToFavoritesSuccessMessage {
    return Intl.message(
      'Added to favorites',
      name: 'movieDetailsAddToFavoritesSuccessMessage',
      desc: '',
      args: [],
    );
  }

  /// `Error on adding to favorites`
  String get movieDetailsAddToFavoritesErrorMessage {
    return Intl.message(
      'Error on adding to favorites',
      name: 'movieDetailsAddToFavoritesErrorMessage',
      desc: '',
      args: [],
    );
  }

  /// `Removed from favorites`
  String get movieDetailsRemoveFromFavoritesSuccessMessage {
    return Intl.message(
      'Removed from favorites',
      name: 'movieDetailsRemoveFromFavoritesSuccessMessage',
      desc: '',
      args: [],
    );
  }

  /// `Error on removing from favorites`
  String get movieDetailsRemoveFromFavoritesErrorMessage {
    return Intl.message(
      'Error on removing from favorites',
      name: 'movieDetailsRemoveFromFavoritesErrorMessage',
      desc: '',
      args: [],
    );
  }

  /// `Movies`
  String get bottomNavigationMoviesTitle {
    return Intl.message(
      'Movies',
      name: 'bottomNavigationMoviesTitle',
      desc: '',
      args: [],
    );
  }

  /// `Favorites`
  String get bottomNavigationFavoritesTitle {
    return Intl.message(
      'Favorites',
      name: 'bottomNavigationFavoritesTitle',
      desc: '',
      args: [],
    );
  }

  /// `Try again`
  String get errorEmptyStateButtonTitle {
    return Intl.message(
      'Try again',
      name: 'errorEmptyStateButtonTitle',
      desc: '',
      args: [],
    );
  }

  /// `Connection Error`
  String get errorEmptyStateNoInternetErrorTitle {
    return Intl.message(
      'Connection Error',
      name: 'errorEmptyStateNoInternetErrorTitle',
      desc: '',
      args: [],
    );
  }

  /// `Make sure you have internet connection or check your DNS settings.`
  String get errorEmptyStateNoInternetErrorContent {
    return Intl.message(
      'Make sure you have internet connection or check your DNS settings.',
      name: 'errorEmptyStateNoInternetErrorContent',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get errorEmptyStateGenericErrorTitle {
    return Intl.message(
      'Error',
      name: 'errorEmptyStateGenericErrorTitle',
      desc: '',
      args: [],
    );
  }

  /// `An unexpected error has occurred.`
  String get errorEmptyStateGenericErrorContent {
    return Intl.message(
      'An unexpected error has occurred.',
      name: 'errorEmptyStateGenericErrorContent',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en', countryCode: 'US'),
      Locale.fromSubtags(languageCode: 'pt', countryCode: 'BR'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}