//
//  DataSavingManager.swift
//  Nisarg_Patel_FE_8980354
//
//  Created by user238292 on 4/13/24.
//

import UIKit
import CoreData

class DataSavingManager {
    static let shared = DataSavingManager()
    
    private init() {} // Private initializer to prevent external instantiation
    
    func saveDirection(cityName: String, distance: String, from: String, method: String, startPoint: String, endPoint: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        let direction = DirectionsData(context: context)
        direction.cityName = cityName
        direction.distance = distance
        direction.from = from
        direction.method = method
        direction.dataType = SaveData.directions.rawValue
        direction.startPoint = startPoint
        direction.endPoint = endPoint
        do {
            try context.save()
        } catch {
            print("Failed to save direction: \(error.localizedDescription)")
        }
    }

    func saveNews(author: String, cityName: String, content: String, from: String, source: String, title: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        let news = NewsData(context: context)
        news.author = author
        news.cityName = cityName
        news.content = content
        news.from = from
        news.source = source
        news.title = title
        news.dataType = SaveData.news.rawValue

        do {
            try context.save()
        } catch {
            print("Failed to save news: \(error.localizedDescription)")
        }
    }

    func saveWeather(cityName: String, date: String, humidity: String, temp: String, time: String, wind: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        let weather = WeatherCoreData(context: context)
        weather.cityName = cityName
        weather.date = date
        weather.humidity = humidity
        weather.temp = temp
        weather.time = time
        weather.wind = wind
        weather.dataType = SaveData.weather.rawValue
        
        do {
            try context.save()
        } catch {
            print("Failed to save weather: \(error.localizedDescription)")
        }
    }
    
    func firstCheckMethod() {
        let defaults = UserDefaults.standard
        if !defaults.bool(forKey: "firstLaunch") {
            defaults.set(true, forKey: "firstLaunch")
            defaults.synchronize()
            let cities = ["New York", "Los Angeles", "Chicago", "Houston", "Phoenix"]
            for city in cities {
                saveNews(author: "Anonymous", cityName: city, content: "Sample news content", from: "Local News", source: "Sample Source", title: "Sample News Title")
            }
        }
    }
}
