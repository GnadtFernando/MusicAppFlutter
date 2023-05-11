import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:music_app_flutter/core/errors/exceptions.dart';
import 'package:music_app_flutter/shared/models/genre_details_model.dart';
import 'package:music_app_flutter/shared/models/genre_model.dart';

class ApiService extends DioForNative {
  ApiService([super.baseOptions]);

  Future<List<GenreModel>> getGenres() async {
    try {
      const endpoint = "/genres";

      final response = await get(endpoint);

      return (response.data as List)
          .map((genre) => GenreModel.fromMap(genre))
          .toList();
    } on DioError catch (dioError, s) {
      log(
        'Erro ao fazer o get dos gêneros musicais',
        error: dioError,
        stackTrace: s,
      );
      throw ApiException(
        message: "Erro ao carregar gêneros.",
        statusCode: dioError.response?.statusCode,
      );
    } catch (error, s) {
      log(
        'Erro ao fazer o get dos gêneros musicais',
        error: error,
        stackTrace: s,
      );
      throw GeneralException();
    }
  }

  Future<GenreDetailsModel> getGenreDetails({required String genre}) async {
    try {
      final endpoint = "/genres/$genre";

      final response = await get(endpoint);
      return GenreDetailsModel.fromMap(response.data);
    } on DioError catch (dioError, s) {
      log(
        'Erro ao fazer o get dos detalhes do gêneros musicais',
        error: dioError,
        stackTrace: s,
      );
      throw ApiException(
        message: "Erro ao fazer o get dos detalhes do gêneros musicais.",
        statusCode: dioError.response?.statusCode,
      );
    } catch (error, s) {
      log(
        'Erro ao fazer o get dos detalhes gêneros musicais',
        error: error,
        stackTrace: s,
      );
      throw GeneralException();
    }
  }
}
