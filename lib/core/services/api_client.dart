import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:retry/retry.dart';

class ApiClient {
  final String baseUrl;
  final Map<String, String> defaultHeaders;
  final int timeoutDuration;

  ApiClient({
    required this.baseUrl,
    this.defaultHeaders = const {},
    this.timeoutDuration = 10,
  });

  Future<dynamic> get(String endpoint, {Map<String, String>? headers}) async {
    try {
      final response = await retry(
        () => http
            .get(
              Uri.parse('$baseUrl$endpoint'),
              headers: {...defaultHeaders, if (headers != null) ...headers},
            )
            .timeout(Duration(seconds: timeoutDuration)),
        retryIf: (e) => e is TimeoutException || e is http.ClientException,
        maxAttempts: 3,
        delayFactor: Duration(seconds: 2),
      );
      return _processResponse(response);
    } catch (error) {
      _handleError(error);
    }
  }

  Future<dynamic> post(String endpoint, Map<String, dynamic> body,
      {Map<String, String>? headers}) async {
    try {
      final response = await retry(
        () => http
            .post(
              Uri.parse('$baseUrl$endpoint'),
              headers: {
                ...defaultHeaders,
                'Content-Type': 'application/json',
                if (headers != null) ...headers,
              },
              body: jsonEncode(body),
            )
            .timeout(Duration(seconds: timeoutDuration)),
        retryIf: (e) => e is TimeoutException || e is http.ClientException,
        maxAttempts: 3,
        delayFactor: Duration(seconds: 2),
      );
      return _processResponse(response);
    } catch (error) {
      _handleError(error);
    }
  }

  Future<dynamic> put(String endpoint, Map<String, dynamic> body,
      {Map<String, String>? headers}) async {
    try {
      final response = await retry(
        () => http
            .put(
              Uri.parse('$baseUrl$endpoint'),
              headers: {
                ...defaultHeaders,
                'Content-Type': 'application/json',
                if (headers != null) ...headers,
              },
              body: jsonEncode(body),
            )
            .timeout(Duration(seconds: timeoutDuration)),
        retryIf: (e) => e is TimeoutException || e is http.ClientException,
        maxAttempts: 3,
        delayFactor: Duration(seconds: 2),
      );
      return _processResponse(response);
    } catch (error) {
      _handleError(error);
    }
  }

  Future<dynamic> delete(String endpoint, {Map<String, String>? headers}) async {
    try {
      final response = await retry(
        () => http
            .delete(
              Uri.parse('$baseUrl$endpoint'),
              headers: {...defaultHeaders, if (headers != null) ...headers},
            )
            .timeout(Duration(seconds: timeoutDuration)),
        retryIf: (e) => e is TimeoutException || e is http.ClientException,
        maxAttempts: 3,
        delayFactor: Duration(seconds: 2),
      );
      return _processResponse(response);
    } catch (error) {
      _handleError(error);
    }
  }

  dynamic _processResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return jsonDecode(response.body);
      case 400:
        throw Exception('Bad Request: ${response.body}');
      case 401:
        throw Exception('Unauthorized: ${response.body}');
      case 403:
        throw Exception('Forbidden: ${response.body}');
      case 404:
        throw Exception('Not Found: ${response.body}');
      case 500:
        throw Exception('Internal Server Error: ${response.body}');
      default:
        throw Exception(
            'Failed to load data: ${response.statusCode} - ${response.body}');
    }
  }

  void _handleError(dynamic error) {
    if (error is TimeoutException) {
      throw Exception('Request timeout. Please try again later.');
    } else if (error is http.ClientException) {
      throw Exception('Network error occurred. Check your connection.');
    } else {
      throw Exception('An unexpected error occurred: $error');
    }
  }
}
