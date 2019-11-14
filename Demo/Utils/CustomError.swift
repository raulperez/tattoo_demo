//
//  CustomErrors.swift
//  Demo
//
//  Created by Raúl Pérez on 24/10/2019.
//  Copyright © 2019 Raúl Pérez. All rights reserved.
//

import Foundation

enum CustomError: Error {
    case pageInvalid
    case cannotReadPlist
    case cannotWritePlist
    case invalidOrEmptyURL
    case cannotReceiveData
    case cannotDownloadTattooFeed
    case cannotDownloadTattooDetail
}
