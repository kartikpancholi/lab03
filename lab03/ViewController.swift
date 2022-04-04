//
//  ViewController.swift
//  lab03
//
//  Created by Kartik Pancholi on 2022-04-03.
//


import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    @IBOutlet weak var searchText: UITextField!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var tempInCLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    
    let locationManager = CLLocationManager()
    let locationDelegate = MyLocationDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = locationDelegate
        
        locationManager.requestAlwaysAuthorization()
        locationManager.requestLocation()
        
        self.weatherImage.image = UIImage(systemName: "sun.max.fill")
    }

    @IBAction func onSearchTapped(_ sender: UIButton) {
        getWeather(search: searchText.text)
    }
    
    @IBAction func myLocationTapped(_ sender: UIButton) {
        let latAndLong = "\(locationDelegate.latitude),\(locationDelegate.longitude)"
        print(latAndLong)
        
        getWeather(search: latAndLong)
    }
    
    private func getWeather(search: String?) {
        guard let search = search else {
            return
        }
        
        let url = getUrl(search: search)
        
//        print(url)
        
        guard let url = url else {
            print("Could not get URL")
            return
        }
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: url) { data, response, error in
            print("network call completed")
            
            guard error == nil else {
                print("Received Error")
                return
            }
            
            guard let data = data else {
                print("No data found")
                return
            }
            
//            print("In datatask: \(data)")
            
            if let weather = self.parseJson(data: data) {
                print(weather.location.name)
                print(weather.current.temp_c)
                
                DispatchQueue.main.async {
                    self.locationLabel.text = weather.location.name
                    self.tempInCLabel.text = "\(weather.current.temp_c) C"
                    self.conditionLabel.text = weather.current.condition.text
                    
                    let config = UIImage.SymbolConfiguration(paletteColors: [.white, .white, .white])
                    self.weatherImage.preferredSymbolConfiguration = config
                
                    switch weather.current.condition.code {
                    case 1000:
                        self.weatherImage.image = UIImage(systemName: "sun.max")
                    break
                    
                    case 1003:
                    self.weatherImage.image = UIImage(systemName: "cloud.sun")
                    break
                    
                    case 1006:
                    self.weatherImage.image = UIImage(systemName: "cloud")
                    break
                    
                    case 1009:
                    self.weatherImage.image = UIImage(systemName: "smoke")
                    break
                    
                    case 1030:
                    self.weatherImage.image = UIImage(systemName: "cloud.fog")
                    break
                    
                    case 1063:
                    self.weatherImage.image = UIImage(systemName: "cloud.sun.rain")
                    break
                    
                    case 1066:
                    self.weatherImage.image = UIImage(systemName: "cloud.sun.rain")
                    break
                    
                    case 1069:
                    self.weatherImage.image = UIImage(systemName: "cloud.sleet")
                    break
                    
                    case 1072:
                    self.weatherImage.image = UIImage(systemName: "cloud.drizzle")
                    break
                    
                    case 1087:
                    self.weatherImage.image = UIImage(systemName: "cloud.bolt")
                    break
                    
                    case 1114:
                    self.weatherImage.image = UIImage(systemName: "wind.snow")
                    break
                    
                    case 1117:
                    self.weatherImage.image = UIImage(systemName: "wind.snow")
                    break
                    
                    case 1135:
                    self.weatherImage.image = UIImage(systemName: "cloud.fog")
                    break
                    
                    case 1147:
                    self.weatherImage.image = UIImage(systemName: "cloud.fog")
                    break
                    
                    case 1150:
                    self.weatherImage.image = UIImage(systemName: "cloud.drizzle")
                    break
                    
                    case 1153:
                    self.weatherImage.image = UIImage(systemName: "cloud.drizzle")
                    break
                    
                    case 1168:
                    self.weatherImage.image = UIImage(systemName: "cloud.drizzle")
                    break
                    
                    case 1171:
                    self.weatherImage.image = UIImage(systemName: "cloud.drizzle")
                    break
                    
                    case 1180:
                    self.weatherImage.image = UIImage(systemName: "cloud.sun.rain")
                    break
                    
                    case 1183:
                    self.weatherImage.image = UIImage(systemName: "cloud.rain")
                    break
                    
                    case 1186:
                    self.weatherImage.image = UIImage(systemName: "cloud.rain")
                    break
                    
                    case 1189:
                    self.weatherImage.image = UIImage(systemName: "cloud.rain")
                    break
                    
                    case 1192:
                    self.weatherImage.image = UIImage(systemName: "cloud.heavyrain")
                    break
                    
                    case 1195:
                    self.weatherImage.image = UIImage(systemName: "cloud.heavyrain")
                    break
                    
                    case 1198:
                    self.weatherImage.image = UIImage(systemName: "cloud.hail")
                    break
                    
                    case 1201:
                    self.weatherImage.image = UIImage(systemName: "cloud.heavyrain")
                    break
                    
                    case 1204:
                    self.weatherImage.image = UIImage(systemName: "cloud.sleet")
                    break
                    
                    case 1207:
                    self.weatherImage.image = UIImage(systemName: "cloud.sleet")
                    break
                    
                    case 1210:
                    self.weatherImage.image = UIImage(systemName: "cloud.snow")
                    break
                    
                    case 1213:
                    self.weatherImage.image = UIImage(systemName: "cloud.snow")
                    break
                    
                    case 1216:
                    self.weatherImage.image = UIImage(systemName: "cloud.snow")
                    break
                    
                    case 1219:
                    self.weatherImage.image = UIImage(systemName: "cloud.snow")
                    break
                    
                    case 1222:
                    self.weatherImage.image = UIImage(systemName: "cloud.snow")
                    break
                    
                    case 1225:
                    self.weatherImage.image = UIImage(systemName: "cloud.snow")
                    break
                    
                    case 1237:
                    self.weatherImage.image = UIImage(systemName: "cloud.sleet")
                    break
                    
                    case 1240:
                    self.weatherImage.image = UIImage(systemName: "cloud.rain")
                    break
                    
                    case 1243:
                    self.weatherImage.image = UIImage(systemName: "cloud.heavyrain")
                    break
                    
                    case 1246:
                    self.weatherImage.image = UIImage(systemName: "cloud.rain")
                    break
                    
                    case 1249:
                    self.weatherImage.image = UIImage(systemName: "cloud.sleet")
                    break
                    
                    case 1252:
                    self.weatherImage.image = UIImage(systemName: "cloud.sleet")
                    break
                    
                    case 1255:
                    self.weatherImage.image = UIImage(systemName: "cloud.snow")
                    break
                    
                    case 1258:
                    self.weatherImage.image = UIImage(systemName: "cloud.snow")
                    break
                    
                    case 1261:
                    self.weatherImage.image = UIImage(systemName: "cloud.sleet")
                    break
                    
                    case 1264:
                    self.weatherImage.image = UIImage(systemName: "cloud.sleet")
                    break
                    
                    case 1273:
                    self.weatherImage.image = UIImage(systemName: "cloud.sun.bolt")
                    break
                    
                    case 1276:
                    self.weatherImage.image = UIImage(systemName: "cloud.sun.bolt")
                    break
                    
                    case 1279:
                    self.weatherImage.image = UIImage(systemName: "cloud.snow")
                    break
                    
                    case 1282:
                    self.weatherImage.image = UIImage(systemName: "cloud.snow")
                    break
                    
                    default:
                    self.weatherImage.image = UIImage(systemName: "sun.max.fill")
                    break
                    }
                }
            }
        }
        
        dataTask.resume()
    }
    
    private func parseJson(data: Data) -> WeatherResponse?{
        let decoder = JSONDecoder()
        var weatherResponse: WeatherResponse?
        
        do {
//            print(data)
            weatherResponse = try decoder.decode(WeatherResponse.self, from: data)
        } catch {
            print("Error parsing weather")
            print(error)
        }
        
        return weatherResponse
    }
    
    private func getUrl(search: String) -> URL? {
        let baseUrl = "https://api.weatherapi.com/v1/"
        let currrentEndpoint = "current.json"
        let apiKey = "eee40496afca44dcb32222322220304"
        
        let url = "\(baseUrl)\(currrentEndpoint)?key=\(apiKey)&q=\(search)"
        
        return URL(string: url)
    }
}

struct WeatherResponse: Decodable {
    let location: Location
    let current: Weather
}

struct Location: Decodable {
    let name: String
}

struct Weather: Decodable {
    let temp_c: Float
    let condition: WeatherCondition
}

struct WeatherCondition: Decodable {
    let text: String
    let code: Int
}

class MyLocationDelegate: NSObject, CLLocationManagerDelegate {
    var latitude = ""
    var longitude = ""
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Got Location")
        
        if let location = locations.first {
            latitude = "\(location.coordinate.latitude)"
            longitude = "\(location.coordinate.longitude)"
            
            print("\(location.coordinate.latitude) & \(location.coordinate.longitude)")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}


