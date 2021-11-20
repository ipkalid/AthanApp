//
//  UserDefaulttsKey.swift
//  Athan
//
//  Created by Khalid Alhazmi on 19/10/2021.
//

import Foundation

struct UserDefaultsKey {
    static let showOnboarding = "show_onboarding"
    static let isDarkMode = "is_darkmode"
    static let local = "local";
    
    static let cityName = "city_name"
    static let longitude = "longitude"
    static let latitude = "latitude"
    
    
    
    //notofications Setting
    static let morningAthkar = "morning_athkar"
    static let eveningAthkar = "evening_athkar"
    
    static let fajrNotification = "fajr_notification"
    static let beforeFajrNotification = "before_fajr_notification"
    
    static let dhuhrNotification = "dhuhr_notification"
    static let beforeDhuhrNotification = "before_dhuhr_notification"
    
    static let asrNotification = "asr_notification"
    static let beforeAsrNotification = "before_asr_notification"
    
    static let maghribNotification = "maghrib_notification"
    static let beforeMaghribNotification = "before_maghrib_notification"
    
    static let ishaNotification = "isha_notification"
    static let beforeIshaNotification = "before_isha_Notification"


    static let madhabType = "madhab_type"
    static let calculationMethod = "calculation_method"
}
