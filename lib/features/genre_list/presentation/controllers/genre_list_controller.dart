import 'package:get/get.dart';
import 'package:music_app_flutter/core/errors/failures.dart';
import 'package:music_app_flutter/features/genre_list/presentation/controllers/data/repositories/genre_list_repository.dart';
import 'package:music_app_flutter/shared/models/genre_model.dart';

import '../../../../core/mixins/screen_loading_and_error_mixin.dart';

class GenreListController extends GetxController
    with ScreenLoadingAndErrorMixin {
  final GenreListRepository _genreListRepository;

  GenreListController(GenreListRepository genreListRepository)
      : _genreListRepository = genreListRepository;

  final RxList<GenreModel> genres = RxList([]);

  @override
  void onInit() {
    getGenreList();
    super.onInit();
  }

  Future<void> getGenreList() async {
    setLoadingToTrue();
    setError(null);

    final getGenresResponse = await _genreListRepository.getGenreList();

    getGenresResponse.fold((Failure failureResponse) {
      if (failureResponse is GetGenreListFailure) {
        setError(failureResponse.message);
      }
    }, (List<GenreModel> genreResponse) {
      genres.value = genreResponse;
    });

    setLoadingToFalse();
  }
}
