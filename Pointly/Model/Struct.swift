//
//  Struct.swift
//  Pointly
//
//  Created by Никита on 10.09.2025.
//

import Foundation

enum tabbar: String, CaseIterable{
    case home = "Home"
    case calendar = "Calendar"
    case profile = "Profile"
    
    var symbolsImageName: String{
        switch self{
        case .home: return "houseLogo" //houseLogo //"house.fill"
        case .calendar: return "calendarLogo" //calendarLogo //"bell.fill"
        case .profile: return "personLogo" //personLogo //person.circle.fill
        }
    }
}
