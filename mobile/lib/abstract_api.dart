import 'package:http/http.dart' as http;

abstract class AbstractApi {
  final String urlLocalhost = 'http://localhost:3000';
  final String _endpoint;

  AbstractApi(this._endpoint);

  Future<String> findAll() async {
    var response = await http.get(Uri.parse("$urlLocalhost/$_endpoint"));

    return response.body;
  }

  Future<String> findById(String idBanker) async {
    var response =
        await http.get(Uri.parse("$urlLocalhost/$_endpoint/$idBanker"));

    return response.body;
  }

  Future<String> save(String bodyBanker) async {
    var response = await http.post(
      Uri.parse("$urlLocalhost/$_endpoint"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: bodyBanker,
    );

    return response.body;
  }

  Future<String> put(String idBanker, String bodyBanker) async {
    var response = await http.put(
      Uri.parse("$urlLocalhost/$_endpoint/$idBanker"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: bodyBanker,
    );

    return response.body;
  }

  Future<String> deleteById(String idBanker) async {

    var response = await http.delete(Uri.parse("$urlLocalhost/$_endpoint/$idBanker"));

    return response.body;
  }
}
