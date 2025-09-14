//
//  VpnService.swift
//  Runner
//
//  Created by 🧊 on 2025/9/13.
//

import UIKit
import Foundation
class VpnService: NSObject {
    @objc static func isVpnActive() -> Bool {
            guard let settings = CFNetworkCopySystemProxySettings()?.takeRetainedValue() as? [String: Any] else {
                return false
            }
            if let scopes = settings["__SCOPED__"] as? [String: Any] {
                for key in scopes.keys {
                    if key.contains("tap") || key.contains("tun") || key.contains("ppp") || key.contains("ipsec") {
                        return true
                    }
                }
            }
            return false
        }
}
