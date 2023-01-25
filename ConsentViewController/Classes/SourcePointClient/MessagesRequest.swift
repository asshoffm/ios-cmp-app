//
//  MessagesRequest.swift
//  Pods
//
//  Created by Andre Herculano on 13.09.22.
//

import Foundation

struct MessagesRequest: QueryParamEncodable {
    struct Body: QueryParamEncodable {
        struct Campaigns: QueryParamEncodable {
            struct CCPA: QueryParamEncodable {
                let targetingParams: SPTargetingParams?
                let hasLocalData: Bool
                let status: CCPAConsentStatus?
            }

            struct GDPR: QueryParamEncodable {
                let targetingParams: SPTargetingParams?
                let hasLocalData: Bool
                let consentStatus: ConsentStatus?
            }

            struct IOS14: QueryParamEncodable {
                let targetingParams: SPTargetingParams?
                let idfaSstatus: SPIDFAStatus
            }

            let ccpa: CCPA?
            let gdpr: GDPR?
            let ios14: IOS14?
        }

        let propertyHref: SPPropertyName
        let accountId: Int
        let campaigns: Campaigns
        let localState: SPJson?
        let consentLanguage: SPMessageLanguage
        let hasCSP = true
        let campaignEnv: SPCampaignEnv?
        let idfaStatus: SPIDFAStatus?
        let includeData = try? SPJson([
            "localState": ["type": "RecordString"],
            "TCData": ["type": "RecordString"]
        ])
    }

    struct MetaData: QueryParamEncodable {
        struct Campaign: QueryParamEncodable {
            let applies: Bool
        }

        let ccpa, gdpr: Campaign?
    }

    let body: Body
    let metadata: MetaData?
    let nonKeyedLocalState: SPJson?
}

extension MessagesRequest.Body.Campaigns {
    init() {
        ccpa = nil
        gdpr = nil
        ios14 = nil
    }
}

extension MessagesRequest.MetaData.Campaign {
    init?(applies: Bool?) {
        guard let applies = applies else { return nil }
        self.applies = applies
    }
}

extension MessagesRequest.Body.Campaigns.GDPR {
    init?(_ campaign: SPCampaign?, hasLocalData: Bool, consentStatus: ConsentStatus) {
        guard let campaign = campaign else { return nil }

        self.targetingParams = campaign.targetingParams
        self.hasLocalData = hasLocalData
        self.consentStatus = consentStatus
    }
}

extension MessagesRequest.Body.Campaigns.CCPA {
    init?(_ campaign: SPCampaign?, hasLocalData: Bool, status: CCPAConsentStatus) {
        guard let campaign = campaign else { return nil }

        self.targetingParams = campaign.targetingParams
        self.hasLocalData = hasLocalData
        self.status = status
    }
}

extension MessagesRequest.Body.Campaigns.IOS14 {
    init?(_ campaign: SPCampaign?, idfaStatus: SPIDFAStatus) {
        guard let campaign = campaign else { return nil }

        self.targetingParams = campaign.targetingParams
        self.idfaSstatus = idfaStatus
    }
}