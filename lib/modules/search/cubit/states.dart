abstract class SearchStates{}
class SearchInitialState extends SearchStates{}
class LoadingSearchState extends SearchStates{}
class SuccessSearchState extends SearchStates{}
class ErrorSearchState extends SearchStates{
  late final String error;
  ErrorSearchState(this.error);

}
class LoadingChangeFavoriteSearchState extends SearchStates{}
class SuccessChangeFavoriteSearchState extends SearchStates{}
class ErrorChangeFavoriteSearchState extends SearchStates {
  late final String error;

  ErrorChangeFavoriteSearchState(this.error);
}
