//
//  PrivacyManagerViewResponse.swift
//  Pods
//
//  Created by Andre Herculano on 01.06.21.
//

import Foundation

enum SPVendorType: String, Codable {
    case IAB, CUSTOM
}

struct VendorListVendor: Decodable {
    struct SPLegIntCategory: Decodable {
        let type: SPCategoryType
        let iabId: Int?
        let name: String
    }
    struct SPConsentCategory: Decodable {
        let type: SPCategoryType
        let name: String
    }

    let vendorId, name: String
    let iabId: Int?
    let policyUrl: URL?
    let description, cookieHeader: String?
    let vendorType: SPVendorType
    let legIntCategories: [SPLegIntCategory]
    let consentCategories: [SPConsentCategory]
    let iabSpecialPurposes, iabFeatures, iabSpecialFeatures: [String]
}

struct VendorListShortVendor: Decodable {
    enum SpecialPurposeType: String, Decodable {
        case IAB
    }

    struct Vendor: Decodable {
        let name: String
        let policyURL: URL?
    }

    let _id, name, description: String
    let type: SpecialPurposeType?
    let vendors: [Vendor]
}

struct PrivacyManagerViewResponse: Decodable {
    let vendors: [VendorListVendor]
    let categories: [VendorListCategory]
    let specialPurposes, features, specialFeatures: [VendorListShortVendor]
}