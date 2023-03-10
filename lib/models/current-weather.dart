// 'https://api.openweathermap.org/data/2.5/weather?q=$city&units=metric&appid=$key');
// api for current weather only.

// class WeatherData {
//   Coord? coord;
//   List<Weather>? weather;
//   String? base;
//   Main? main;
//   int? visibility;
//   Wind? wind;
//   Clouds? clouds;
//   int? dt;
//   Sys? sys;
//   int? timezone;
//   int? id;
//   String? name;
//   int? cod;

//   WeatherData({
//     this.coord,
//     this.weather,
//     this.base,
//     this.main,
//     this.visibility,
//     this.wind,
//     this.clouds,
//     this.dt,
//     this.sys,
//     this.timezone,
//     this.id,
//     this.name,
//     this.cod,
//   });

//   WeatherData.fromJson(Map<String, dynamic> json) {
//     coord = json['coord'] != null ? Coord.fromJson(json['coord']) : null;
//     if (json['weather'] != null) {
//       weather = [];
//       json['weather'].forEach((v) {
//         weather!.add(Weather.fromJson(v));
//       });
//     }
//     base = json['base'];
//     main = json['main'] != null ? Main.fromJson(json['main']) : null;
//     visibility = json['visibility'];
//     wind = json['wind'] != null ? Wind.fromJson(json['wind']) : null;
//     clouds = json['clouds'] != null ? Clouds.fromJson(json['clouds']) : null;
//     dt = json['dt'];
//     sys = json['sys'] != null ? Sys.fromJson(json['sys']) : null;
//     timezone = json['timezone'];
//     id = json['id'];
//     name = json['name'];
//     cod = json['cod'];
//   }
// }

// class Coord {
//   double? lon;
//   double? lat;

//   Coord({
//     this.lat,
//     this.lon,
//   });

//   Coord.fromJson(Map<String, dynamic> json) {
//     lon = json['lon'];
//     lat = json['lat'];
//   }
// }

// class Weather {
//   int? id;
//   String? main;
//   String? description;
//   String? icon;

//   Weather({
//     this.id,
//     this.main,
//     this.description,
//     this.icon,
//   });

//   Weather.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     main = json['main'];
//     description = json['description'];
//     icon = json['icon'];
//   }
// }

// class Main {
//   double? temp;
//   double? feels_like;
//   double? temp_min;
//   double? temp_max;
//   int? pressure;
//   int? humidity;

//   Main({
//     this.temp,
//     this.feels_like,
//     this.temp_min,
//     this.temp_max,
//     this.pressure,
//     this.humidity,
//   });
//   Main.fromJson(Map<String, dynamic> json) {
//     temp = json['temp'];
//     feels_like = json['feels_like'];
//     temp_min = json['temp_min'];
//     temp_max = json['temp_max'];
//     pressure = json['pressure'];
//     humidity = json['humidity'];
//   }
// }

// class Wind {
//   double? speed;
//   int? deg;
//   Wind({
//     this.speed,
//     this.deg,
//   });
//   Wind.fromJson(Map<String, dynamic> json) {
//     speed = json['speed'];
//     deg = json['deg'];
//   }
// }

// class Clouds {
//   int? all;
//   Clouds({
//     this.all,
//   });
//   Clouds.fromJson(Map<String, dynamic> json) {
//     all = json['all'];
//   }
// }

// class Sys {
//   int? type;
//   int? id;
//   String? country;
//   int? sunrise;
//   int? sunset;

//   Sys({
//     this.type,
//     this.id,
//     this.country,
//     this.sunrise,
//     this.sunset,
//   });
//   Sys.fromJson(Map<String, dynamic> json) {
//     type = json['type'];
//     id = json['id'];
//     country = json['country'];
//     sunrise = json['sunrise'];
//     sunset = json['sunset'];
//   }
// }
