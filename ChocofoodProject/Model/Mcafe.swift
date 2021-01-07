//
//  Mcafe.swift
//  ChocofoodProject
//
//  Created by Murat Merekov on 07.01.2021.
//  Copyright © 2021 Murat Merekov. All rights reserved.
//

import Foundation

struct Condition: Codable{
    var delivery_cost: Int
    var order_min_cost: Int
}

struct DeliveryTarif: Codable{
    var title: String
    var conditions: [Condition]
    var pk: String
}

struct DeliveryTime: Codable{
    var low_limit_minutes: Int
    var upper_limit_minutes: Int
    var pk: String
}

struct HourMinute: Codable{
    var hour: Int
    var minute: Int
}

struct Schedule: Codable{
    var started_week_day: String
    var started_at: HourMinute
    var ended_week_day: String
    var ended_at: HourMinute
}
struct PaymentType: Codable{
    var cash: Bool
    var bonus: Bool
    var card: Bool
    var rakhmet: Bool
}
struct Coordinate: Codable{
    var latitude: Float
    var longitude: Float
}
struct Location: Codable{
    var coordinate: Coordinate
    var text: String
}
struct Category: Codable{
    var title: String
    var position: Int
    var active_icon: String
    var inactive_icon: String
    var pk: String
}
struct Restaurant: Codable{
    var title: String
    var schedule: [Schedule]
    var logo: String
    var image: String
    var synonyms: [String]
    var payment_methods: PaymentType
    var will_be_delivered_by: String
    var location: Location
    var pk: String
    var categories: [Category]
    var state: String
    var rating: Int
}

struct Cafe: Codable{
    var delivery_tariff: DeliveryTarif
    var delivery_time: DeliveryTime
    var restaurant: Restaurant
    var is_top_restaurant: Bool
}

