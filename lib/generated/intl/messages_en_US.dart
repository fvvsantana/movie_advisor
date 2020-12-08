// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en_US locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en_US';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "bottomNavigationFavoritesTitle" : MessageLookupByLibrary.simpleMessage("Favorites"),
    "bottomNavigationMoviesTitle" : MessageLookupByLibrary.simpleMessage("Movies"),
    "errorEmptyStateButtonTitle" : MessageLookupByLibrary.simpleMessage("Try again"),
    "errorEmptyStateGenericErrorContent" : MessageLookupByLibrary.simpleMessage("An unexpected error has occurred."),
    "errorEmptyStateGenericErrorTitle" : MessageLookupByLibrary.simpleMessage("Error"),
    "errorEmptyStateNoInternetErrorContent" : MessageLookupByLibrary.simpleMessage("Make sure you have internet connection or check your DNS settings."),
    "errorEmptyStateNoInternetErrorTitle" : MessageLookupByLibrary.simpleMessage("Connection Error"),
    "favoriteMoviesAppBarTitle" : MessageLookupByLibrary.simpleMessage("Favorites"),
    "favoriteMoviesEmptyStateMessage" : MessageLookupByLibrary.simpleMessage("No favorite movies yet."),
    "movieDetailsAddToFavoritesErrorMessage" : MessageLookupByLibrary.simpleMessage("Error on adding to favorites"),
    "movieDetailsAddToFavoritesSuccessMessage" : MessageLookupByLibrary.simpleMessage("Added to favorites"),
    "movieDetailsAppBarTitle" : MessageLookupByLibrary.simpleMessage("Movie details"),
    "movieDetailsFavoriteFetchingErrorMessage" : MessageLookupByLibrary.simpleMessage("Error on fetching favorite status of the movie"),
    "movieDetailsGenresTitle" : MessageLookupByLibrary.simpleMessage("Genres"),
    "movieDetailsRemoveFromFavoritesErrorMessage" : MessageLookupByLibrary.simpleMessage("Error on removing from favorites"),
    "movieDetailsRemoveFromFavoritesSuccessMessage" : MessageLookupByLibrary.simpleMessage("Removed from favorites"),
    "movieDetailsSynopsisTitle" : MessageLookupByLibrary.simpleMessage("Synopsis"),
    "moviesListAppBarTitle" : MessageLookupByLibrary.simpleMessage("Movie Advisor"),
    "moviesListEmptyStateMessage" : MessageLookupByLibrary.simpleMessage("No movies to show."),
    "retryEmptyStateRetryButtonText" : MessageLookupByLibrary.simpleMessage("Retry")
  };
}
