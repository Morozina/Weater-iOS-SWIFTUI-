//
//  WeatherManager.swift
//  Weather
//
//  Created by Vladyslav Moroz on 23/01/2023.
//

import Foundation
import CoreLocation

final class WeatherManager {
    func getCurrentWeather(lon: CLLocationDegrees, lat: CLLocationDegrees) async throws -> WeatherData {
        guard let LocationUrl = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=c8f13a2b97152cbf9e84989c69b61a6a&units=metric") else {fatalError("Missing Url")}
        
        let urlRequest = URLRequest(url: LocationUrl)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {fatalError("Fatching Data eror")}
        
        let decodedData = try JSONDecoder().decode(WeatherData.self, from: data)
        return decodedData
    }
}

struct WeatherData: Codable {
    var name: String
    var weather: [Weather]
    var main: Main
    var wind: Wind
    var cod: Int
    
    struct Weather: Codable {
        var id: Int
        var main: String
    }

    struct Wind: Codable {
        var speed: Double
    }

    struct Main: Codable {
        var temp: Double
        var temp_min: Double
        var temp_max: Double
        var humidity: Double
    }
}
