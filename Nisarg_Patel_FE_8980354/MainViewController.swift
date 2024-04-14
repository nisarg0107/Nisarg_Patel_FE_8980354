//
//  MainViewController.swift
//  Nisarg_Patel_FE_8980354
//
//  Created by user238292 on 4/13/24.
//

import UIKit
import MapKit

class MainViewController:  UIViewController, MKMapViewDelegate, UITabBarDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapUI: MKMapView!
    @IBOutlet weak var temperaturelevel: UILabel!
    @IBOutlet weak var WindSpeed: UILabel!
    @IBOutlet weak var Humidity: UILabel!
    @IBOutlet weak var weatherimg: UIImageView!
   
    
    
    let manager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.delegate = self
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "My Final", style: .plain, target: nil, action: nil)
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.requestLocation()
        mapUI.delegate = self
        mapUI.showsUserLocation = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let sender = sender as? UIButton else { return }
        if sender.tag == 2 {
            if let destination = segue.destination as? UITabBarController {
                destination.selectedIndex = 1
            }
        } else if sender.tag == 3 {
            if let destination = segue.destination as? UITabBarController {
                destination.selectedIndex = 2
            }
        }
    }
    
    func updateUI(with data: WeatherModel) {
        temperaturelevel.text = "\(Int(data.main.temp))°C"
        WindSpeed.text = "Wind: \(data.wind.speed)Km/h"
        Humidity.text = "Humidity: \(data.main.humidity)"
        weatherimg.image = UIImage(systemName: mapWeatherConditionToSymbol(data.weather.first?.id ?? 0))
    }
    func navigationController(_ navigation: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        let hide = (viewController is MainViewController)
        navigation.setNavigationBarHidden(hide, animated: animated)
    }
    func locationManager(_ lManager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            lManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
        mapUI.setRegion(region, animated: true)
        fetchWeatherData(for: location.coordinate)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error fetching location: \(error.localizedDescription)")
    }
    
    private func fetchWeatherData(for coordinate: CLLocationCoordinate2D) {
        let apiKey = "9915fab4290e8740ec4bf5a74c2e2d28" 
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(coordinate.latitude)&lon=\(coordinate.longitude)&appid=\(apiKey)&units=metric")!
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching weather data: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            do {
                let decoder = JSONDecoder()
                let weatherData = try decoder.decode(WeatherModel.self, from: data)
                
                DispatchQueue.main.async {
                    self?.updateUI(with: weatherData)
                }
            } catch {
                print("Error decoding weather data: \(error.localizedDescription)")
            }
        }.resume()
    }
}
