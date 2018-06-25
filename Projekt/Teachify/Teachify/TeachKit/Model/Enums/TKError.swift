//
//  TKError.swift
//  Firebase Playground
//
//  Created by Marcel Hagmann on 06.04.18.
//  Copyright © 2018 Marcel Hagmann. All rights reserved.
//

import Foundation
import CloudKit

enum TKError: Error {
    case networkUnavailable
    
    case networkFailure
    case notAuthenticated
    
    case fetchSortTypeNotAvailable
    case noWritePermission
    case wrongRecordZone
    
    case noSharedData
    case objectIsFaulty
    case objectIsFaultyAfterCloudUpload
    case parentObjectIsFaulty
    
    case updateOperationFailed
    case deleteOperationFailed
    case createOperationFailed
    case addOperationFailed
    case userCouldNotLoad
    
    case failedSharing
    
    init?(ckError: CKError) {
        switch ckError.errorCode {
        case CKError.networkUnavailable.rawValue: self = .networkUnavailable
        case CKError.networkFailure.rawValue: self = .networkFailure
        case CKError.notAuthenticated.rawValue: self = .notAuthenticated
        default: return nil
        }
    }
    
    var localizedDescription: String {
        switch self {
        case .networkUnavailable: return "Es besteht keine Internetverbindung"
        case .networkFailure: return "Es besteht eine Internetverbindung, es konnte allerdings keine Verbindung zur Cloud hergestellt werden."
        case .wrongRecordZone: return "Die Operation wird auf der falschen RecordZone ausgeführt oder existiert nicht. An Schnittstelle wenden."
        case .failedSharing: return "Das Objekt konnte nicht geteilt werden."
        case .parentObjectIsFaulty: return "Operation konnte nicht ausgeführt werden, da das Parent-Objekt Fehlerhaft ist."
        case .objectIsFaulty: return "Operation konnte nicht ausgeführt werden, da das Objekt Fehlerhaft ist."
        case .objectIsFaultyAfterCloudUpload: return "Auf dem Objekt wurde eine Operation in der Cloud ausgeführt. Das von der Cloud erhaltene Objekt ist inkonsistent."
        case .userCouldNotLoad: return "Beim Zugriff auf die Nutzer Informationen ist ein Fehler unterlaufen."
        case .updateOperationFailed: return "Der Datensatz konnte nicht geupdated werden."
        case .deleteOperationFailed: return "Der Datensatz konnte nicht gelöscht werden."
        case .createOperationFailed: return "Der Datensatz konnte nicht erstellt werden."
        case .addOperationFailed: return "Der Datensatz konnte nicht hinzugefügt werden."
        case .fetchSortTypeNotAvailable: return "Das Attribut nach dem sortiert werden soll existiert nicht."
        case .noWritePermission: return "Der Nutzer hat keine Berechtigung die Daten zu ändern."
        case .noSharedData: return "Die Operation konnte nicht ausgeführt werden, da noch keine Daten geteilt werden."
        default:
            return "Unknown Error"
        }
    }
}
