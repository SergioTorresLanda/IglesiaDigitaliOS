//
//  LanguageString.swift
//  Nomad
//
//  Created by Diego Luna on 07/07/20.
//

import Foundation
import UIKit

enum LanguageString: String {
    // MARK: - Common Strings
    case appName
    case usaCode
    case noContent
    case otherSearch
    
    // MARK: - Textfields Rules
    case ruleEmailInvalid
    case defaultPlaceholder
    case defaultTextInfoLabel
    
    // MARK: - Log In
    case logInGoogle
    case logIn
    case infoOne
    case infoTwo
    case infoThree
    case infoFour
    case signIn
    case userIDAppleDefaults
    case userNameAppleDefaults
    case userLastNameAppleDefaults
    case userEmailAppleDefaults
    case userIDGoogleDefaults
    case userNameGoogleDefaults
    case userLastNameGoogleDefaults
    case userEmailGoogleDefaults
    case userAllDefaults
    case userIsGuestDefaults
    case noContentHistory
    case userLoginTypeDefaults
    case success
    case userIsFirstTime
    case appleIDPreviousError
    
    // MARK: - Destination
    case whereAreYouGoing
    case orLabel
    case currentLocation
    case enterDestination
    case suggestions
    case noNearbyPlaces
    case noAutocompleteResults
    case popularDestinations
    case nearPlaces
    
    // MARK: - Know Before You Go
    case todayDate
    case highRiskLevel
    case mediumRiskLevel
    case lowRiskLevel
    case totalPopulation
    case percentExplanation
    case fifteendays
    case thirtydays
    case days
    case all
    case source1
    case source2
    case source3
    case evolutionCovid
    case lastUpdate
    case totalCases
    case newCases
    case recovered
    case deaths
    case sources
    case titleKBYG
    case subtitleKBYG
    case govermentCard
    case entryCard
    case healthCard
    case weatherCard
    case cardsTitle
    case mapView
    
    // MARK: - Home
    case knowBefore
    case explore
    case safePlaces
    case profile
    
    // MARK: - Government
    case governmentTitle
    case governmentSeeMore
    case governmentSeeLess
    case governmentTitleNav
    case stateButton
    
    // MARK: - Entry Requirements
    case entryRequirementsTitle
    
    // MARK: - Weather
    case weatherTitle
    case weatherNavigationBarTitle
    case showMore
    case warning
    case watch
    case advisory
    case noData

    var localized: String {
        return localize()
    }
}

private extension LanguageString {
    func localize() -> String {
        return NSLocalizedString(rawValue, tableName: "Localizable", bundle: .main, value: "", comment: "")
    }
}
