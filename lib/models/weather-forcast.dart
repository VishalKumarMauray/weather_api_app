class WeatherData {
//   String? cod;
//   int? message;
//   int? cnt;
  List<Wlist>? list;
  City? city;

  WeatherData({
//     this.cod,
//     this.message,
//     this.cnt,
    this.list,
    this.city,
  });

  WeatherData.fromJson(Map<String, dynamic> json) {
//     cod = json['cod'];
//     message = json['message'];
//     cnt = json['cnt'];
    if (json['list'] != null) {
      list = [];
      json['list'].forEach((v) {
        list!.add(Wlist.fromJson(v));
      });
    }
    city = json['city'] != null ? City.fromJson(json['city']) : null;
  }
}

class Wlist {
//   int? dt;
//   Main? main;
  List<Weather>? weather;
//   Clouds? clouds;
//   Wind? wind;
//   int? visibility;
//   int? pop;
//   Sys? sys;
  DateTime? dt_txt;

  Wlist({
//     this.dt,
//     this.main,
    this.weather,
//     this.clouds,
//     this.wind,
//     this.visibility,
//     this.pop,
//     this.sys,
    this.dt_txt,
  });

  Wlist.fromJson(Map<String, dynamic> json) {
//     dt = json['dt'];
//     main = json['main'] != null ? Main.fromJson(json['main']) : null;
    if (json['weather'] != null) {
      weather = [];
      json['weather'].forEach((v) {
        weather!.add(Weather.fromJson(v));
      });
    }
//     clouds = json['clouds'] != null ? Clouds.fromJson(json['Clouds']) : null;
//     wind = json['wind'] != null ? Wind.fromJson(json['wind']) : null;
//     visibility = json['visibility'];
//     pop = json['pop'];
//     sys = json['sys'] != null ? Sys.fromJson(json['sys']) : null;
    dt_txt = DateTime.parse(json['dt_txt'].toString());
  }
}

// class Main {
//   double? temp;
//   double? feels_like;
//   double? temp_min;
//   double? temp_max;
//   int? pressure;
//   int? sea_level;
//   int? grnd_level;
//   int? humidity;
//   double? temp_kf;
//   Main({
//     this.temp,
//     this.feels_like,
//     this.temp_min,
//     this.temp_max,
//     this.pressure,
//     this.sea_level,
//     this.grnd_level,
//     this.humidity,
//     this.temp_kf,
//   });

//   Main.fromJson(Map<String, dynamic> json) {
//     temp = json['temp'];
//     feels_like = json['feels_like'];
//     temp_min = json['temp_min'];
//     temp_max = json['temp_max'];
//     pressure = json['pressure'];
//     sea_level = json['sea_level'];
//     grnd_level = json['grnd_level'];
//     humidity = json['humidity'];
//     temp_kf = json['temp_kf'];
//   }
// }

class Weather {
//   int? id;
//   String? main;
//   String? description;
  String? icon;
  Weather({
//     this.id,
//     this.main,
//     this.description,
    this.icon,
  });

  Weather.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     main = json['main'];
//     description = json['description'];
    icon = json['icon'];
  }
}

// class Clouds {
//   int? all;
//   Clouds({
//     this.all,
//   });

//   Clouds.fromJson(Map<String, dynamic> json) {
//     all = json['all'];
//   }
// }

// class Wind {
//   double? speed;
//   int? deg;
//   double? gust;
//   Wind({
//     this.speed,
//     this.deg,
//     this.gust,
//   });

//   Wind.fromJson(Map<String, dynamic> json) {
//     speed = json['speed'];
//     deg = json['deg'];
//     gust = json['gust'];
//   }
// }

// class Sys {
//   String? pod;
//   Sys({
//     this.pod,
//   });

//   Sys.fromJson(Map<String, dynamic> json) {
//     pod = json['pod'];
//   }
// }

class City {
//   int? id;
  String? name;
//   Coord? coord;
//   String? country;
//   int? population;
//   int? timezone;
//   int? sunrise;
//   int? sunset;

  City({
//     this.id,
    this.name,
//     this.coord,
//     this.country,
//     this.population,
//     this.timezone,
//     this.sunrise,
//     this.sunset,
  });

  City.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
    name = json['name'];
//     coord = json['coord'] != null ? Coord.fromJson(json['coord']) : null;
//     country = json['country'];
//     population = json['population'];
//     timezone = json['timezone'];
//     sunrise = json['sunrise'];
//     sunset = json['sunset'];
  }
}

// class Coord {
//   double? lat;
//   double? lon;

//   Coord({
//     this.lat,
//     this.lon,
//   });

//   Coord.fromJson(Map<String, dynamic> json) {
//     lat = json['lat'];
//     lon = json['lon'];
//   }
// }
