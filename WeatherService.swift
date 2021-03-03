//
//  WeatherService.swift
//  WeatherAppFinal
//
//  Created by Travis Heurtelou on 3/2/21.
//

import CoreLocation
import Foundation

public final class WeatherService: NSObject {
    
    private let LocationManager = CLLocationManager()
    private let APIKey = "26972ca858e563c548abfd96495a8d61"
    private var completionHandler: ((Weather) -> Void)?
    
    public func loadWeatherData(_ completionHandler: @escaping((Weather) -> Void)) {
        self.completionHandler = completionHandler
        LocationManager.requestWhenInUseAuthorization()
        LocationManager.startUpdatingLocation()
    }
    
    //https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API key}
    private func makeDataRequest(forCoordinates coordinates: CLLocationCoordinate2D) {
        guard let urlString =
                "api.openweathermap.org/data/2.5/weather?lat=\(coordinates.latitude)&lon=\(coordinates.longitude)&appid=\(APIKey)&units=metric".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil, let data = data else { return }
            if let response = try? JSONDecoder().decode(APIResponse.self, from: data) {
                self.completionHandler?(Weather(response: response))
            }
        }.resume()
    }
}


struct APIResponse {
    let name: String
    let main: APIMain
    let weather: [APIWeather]
}


struct APIMain: Decodable {
    let temp: Double
}

struct APIWeather: Decodable {
    let description: String
    let iconName: String
    
    
    enum CodingKeys: String, CodingKey {
        case description
        case iconName = "main"
    }
}
