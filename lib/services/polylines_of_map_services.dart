import 'package:map/model/map_model.dart';
import 'package:map/utils/google_map_api_constants.dart';
import 'package:http/http.dart';

class GetPolylinesClass {
  Future<Googlemappolylineapi> getPolylines(
    origenLat,
    origenLong,
    destLat,
    destLong,
  ) async {
    String url =
        "https://maps.googleapis.com/maps/api/directions/json?origin=$origenLat,$origenLong&destination=$destLat,$destLong&mode=driving&key=$googleMapApiKey";
    Response response = await get(Uri.parse(url));
    if (response.statusCode == 200) {
      return googlemappolylineapiFromJson(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
