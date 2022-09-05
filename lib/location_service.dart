import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class LocationService {
  String key = 'AIzaSyCpYriMlHLK0CeCf9gqG7HHfSVrbiLlUks';


  Future<Map<String, dynamic>> getDirection(String employeesLocation,
      String jobLocation) async {
    final String url = 'https://maps.googleapis.com/maps/api/directions/json?origin=$employeesLocation&destination=$jobLocation&key=$key';
    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);

    var results = {
    'bounds_ne': json['routes'][0]['bounds']['northeast'],
    'bounds_sw': json['routes'][0]['bounds']['southwest'],
    'start_location': json['routes'][0]['legs'][0]['start_location'],
    'end_location': json['routes'][0]['legs'][0]['end_location'],
    'polyline': json['routes'][0]['overview_polyline']['points'],
   'polyline_decoded': PolylinePoints().decodePolyline(json['routes'][0]['overview_polyline']['points']),
    };

    print(results);
    return results;
  }
}