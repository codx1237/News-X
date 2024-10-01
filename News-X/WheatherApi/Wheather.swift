//
//  Wheather.swift
//  NewsX
//
//  Created by Fırat Ören on 28.09.2024.
//

import Foundation


struct Wheather: Decodable {
    let current_weather: Current
}

struct Current: Decodable {
    let temperature: Double
}

@MainActor
class WheatherApiService: ObservableObject {
    @Published var currentTemp: Double = 0.0
    @Published var error: String?

    func fetchWheather() async {
        guard let url = URL(string: "https://api.open-meteo.com/v1/forecast?latitude=41.0138&longitude=28.9497&current_weather=true") else {
            error = "wrong url"
            print("wrong url")
            return
        }

        do {
            let (data,response) = try await URLSession.shared.data(from: url)

            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                error = "Bad HttpRequest"
                print("Bad HttpRequest")
                return
            }

            guard let decodedResponse = try? JSONDecoder().decode(Wheather.self, from: data) else {
                error = "Decode Error"
                print("Decode Error")
                return
            }
            self.currentTemp = decodedResponse.current_weather.temperature

        } catch {
            print("failed to fetch news. \(error.localizedDescription)")
        }


    }


}

