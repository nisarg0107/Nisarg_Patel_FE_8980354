//
//  WeatherViewController.swift
//  Nisarg_Patel_FE_8980354
//
//  Created by user238292 on 4/13/24.
//

import UIKit

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var imgWeather: UIImageView!
    @IBOutlet weak var lblHumidity: UILabel!
    @IBOutlet weak var lbltemperature: UILabel!
    @IBOutlet weak var lbldescription: UILabel!
    @IBOutlet weak var lblCityName: UILabel!
    @IBOutlet weak var lblwindSpeed: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.title = "Weather"
        fetchWeatherData(for: "Waterloo")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let rightBarButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(rightBttnTapped))
        self.tabBarController?.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    @objc func rightBttnTapped() {
        showCityInputAlert(on: self, title: "Enter City Name", message: "Please enter the name of the city:") { [weak self] cityName in
            self?.fetchWeatherData(for: cityName)
        }
    }
    
    
    
    private func fetchWeatherData(for city: String) {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=9915fab4290e8740ec4bf5a74c2e2d28&units=metric") else { return }
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching weather data: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            do {
                let weatherData = try JSONDecoder().decode(WeatherModel.self, from: data)
                DispatchQueue.main.async {
                    self?.updateUI(with: weatherData)
                }
            } catch {
                print("Error decoding weather data: \(error.localizedDescription)")
            }
        }.resume()
    }
    
    func Weather(data: WeatherModel) {
        DataSavingManager.shared.saveWeather(cityName: data.name,
                                date: Date.getCurrentDate(),
                                humidity: "\(data.main.humidity)%",
                                temp: "\(Int(data.main.temp))°C",
                                time: Date().currentTime(),
                                wind: "\(data.wind.speed) km/h")
    }
    
    private func updateUI(with weatherData: WeatherModel) {
        lblCityName.text = weatherData.name
        lbldescription.text = weatherData.weather.first?.description ?? "N/A"
        lbltemperature.text = "\(Int(weatherData.main.temp))°C"
        lblHumidity.text = "Humidity: \(weatherData.main.humidity)%"
        lblwindSpeed.text = "Wind: \(weatherData.wind.speed) km/h"
        
        Weather(data: weatherData)
    }
}
