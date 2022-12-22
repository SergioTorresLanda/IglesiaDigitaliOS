//
//  RegisterRouter.swift
//  register_Framework
//
//  Created by Miguel Eduardo  Valdez Tellez  on 09/02/21.
//

import Foundation
import Alamofire


//old
struct ClergyResponse: Codable {
    var name: String
    var id: Int
    var iconUrl: String?
}

struct ActivitiesResponse: Codable {
    var name: String
    var id: Int
}

struct ActivitiesOtherResponse: Codable {
    var id: Int
    var name: String
}

struct RegisterPriestRequest: Codable {
    var name: String
    var firstSurname: String
    var secondSurname: String
    var birthDate: String
    var ordinationDate: String
    var email: String
    var description: String
    var activities: [ActivitiesOtherResponse]
    var stream: String
}


struct RegisterPriestResponse: Codable {
    var message: String
}

//new
struct CongregationsResponse: Codable
{
    var data: [CongregationContent]
}

struct TopicsResponse: Codable {
    var data: [DataContent]
}
struct StatesResponse: Codable
{
    var data: [StatesContent]
}
struct ServiceResponse: Codable
{
    var data: [DataContent]
}

struct CongregationContent: Codable
{
    var id: Int
    var descripcion: String
}

struct DataContent: Codable
{
    var id: Int
    var description: String
}


struct StatesContent: Codable
{
    var id: Int
    var name: String
    var code: String?
}
struct ActivitiesContent: Codable {
    var name: String
    var id: Int
}

//MARK: - POST PROFILE
struct ProfileState: Codable {
    var username: String?
    var id: Int
    var name, first_surname, second_surname, phone_number: String?
    var email: String?
    var service_provider: String?
    var location_id: Int?
    var is_admin: Bool?
    var life_status: Status?
    var interest_topics: [Topics]?
    var services_provided: [Service]?
}

struct ProfileCongregation: Codable {
    var username: String?
    var id: Int
    var name, first_surname, second_surname, phone_number: String?
    var location_id: Int?
    var email: String?
    var life_status: Status?
    var prefix: Prefix?
    var interest_topics: [Topics]?
    var congregation: Congregation?
    var pastoral_work: String?
    var profile: String?
}

struct ProfileDiacono: Codable {
    var username: String
    var id: Int
    var name, first_surname, second_surname, phone_number: String?
    var email: String?
    var life_status: Status?
    var prefix: Prefix?
    var interest_topics: [Topics]?
    var locations: [Locations]?
    var services_provided: [Service]?
}

struct ProfilePriest: Codable {
    var username: String
    var id: Int
    var name, first_surname, second_surname, phone_number: String?
    var email: String?
    var life_status: Status?
    var prefix: Prefix?
    var interest_topics: [Topics]?
    var birthdate,ordination_date,description,position: String?
    var congregation: Congregation?
    var activities: [Activity]?
    var stream: String?
}

struct ResponseDiacono: Codable {}
struct ResponseSacerdote: Codable {}
struct ResponseState: Codable {}
struct ResponseCongregation: Codable {}

// MARK: - GET DETAIL
// MARK: - DetailProfile

struct DetailProfile: Codable {
    let data: DataClass?
}

// MARK: - DataClass
struct DataClass: Codable {
    let User: User?
}

// MARK: - User
struct User: Codable {
    var id: Int?
    var prefix: PrefixComponents?
    var name, first_surname, second_surname, phone_number: String?
    var email: String?
    var life_status: Status?
    var interest_topics: [Topics]?
    var description, birthdate, ordination_day, stream: String?
    var position: String?
    var congregation: Congregation?
    var activities: [Activity]?
    var community: Community?
    var profile: String?
    var locations: [LocationModules]?
    var pastoral_work: String?
    var location_modules: [LocationModule]?
    var is_provider: String?
    var services_provided: [ProvidedServices]?
}

struct ProvidedServices: Codable {
    var location_id: Int?
    var location_name: String?
    var service_id: Int?
    var service_name: String?
}

struct PrefixComponents: Codable {
    var id: Int?
    var description: String?
}

struct LocationModules: Codable {
    var id: Int?
    var name: String?
    var modules: [String]?
}

struct LocationModule: Codable {
    var id: Int?
    var name: String?
    var type: String?
    var modules: [String]?
}

enum CodingKeys: String, CodingKey {
    case community
}

// MARK: - Community
struct Community: Codable {
    let id: Int?
    let name, status: String?
}

// MARK: - Status
struct Service: Codable {
    var location_id: Int?
    var service_id: Int?
}

// MARK: - Locations
struct Locations: Codable {
    var id: Int?
}

// MARK: - Status
struct Status: Codable {
    var id: Int?
    var name: String?
}

// MARK: - Topics
struct Topics: Codable {
    var id: Int?
    var name: String?
}

// MARK: - Topics
struct Congregation: Codable {
    var id: Int?
    var name: String?
}

// MARK: - Prefix
struct Prefix: Codable {
    var id: Int?
}

// MARK: - Activity
struct Activity: Codable {
    var id: Int?
    var name: String?
}

enum RegisterRouter: BaseRouter {

    case activities
    case clergy
    case states
    case congregations
    case topics
    case detail
    case service
    case register(request: RegisterPriestRequest)
    case profileState(request: ProfileState)
    case profileCongregation(request: ProfileCongregation)
    case profileDiacono(request: ProfileDiacono)
    case profilePriest(request: ProfilePriest)
    
    var method: HTTPMethod {
        switch self {
        case .activities:
            return .get
        case .clergy:
            return .get
        case .states:
            return .get
        case .congregations:
            return .get
        case .topics:
            return .get
        case .service:
            return .get
        case .detail:
            return .get
        case .profileState:
            return .post
        case .profileCongregation:
            return .post
        case .profileDiacono:
            return .post
        case .profilePriest:
            return .post
        case .register:
            return .patch
        }
    }
    
    var path: String {
        switch self {
        case .activities:
            return API.URLProvider.appointmentsCatalog()
        case .clergy:
            return API.URLProvider.clergyCatalog()
        case .register:
            return API.URLProvider.registerPost()
        case .states:
            return API.URLProvider.getStates()
        case .congregations:
            return API.URLProvider.getCongre()
        case .topics:
            return API.URLProvider.getTopics()
        case .service:
            return API.URLProvider.getServi()
        case .detail:
            return API.URLProvider.getDetail()
        case .profileState, .profileCongregation, .profileDiacono, .profilePriest:
            return API.URLProvider.registerPost()
        }
    }
    
    var parameters: Parameters? {
        return nil
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
    var body: Any? {
        switch self {
        case .activities:
            return nil
        case .clergy:
            return nil
        case .states:
            return nil
        case .congregations:
            return nil
        case .topics:
            return nil
        case .service:
            return nil
        case .detail:
            return nil
        case .register(let request):
            return request
        case .profileState(request: let request):
            return request
        case .profileCongregation(request: let request):
            return request
        case .profileDiacono(request: let request):
            return request
        case .profilePriest(request: let request):
            return request
        }
    }
}


