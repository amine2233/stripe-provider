//
//  Stripe.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/13/17.
//
//

import Vapor

private var _stripe: StripeClass?

extension Droplet {
    /*
     Enables use of the `drop.stripe?` convenience methods.
     */
    public var stripe: StripeClass? {
        get {
            return _stripe
        }
        set {
            _stripe = newValue
        }
    }
}

public final class Provider: Vapor.Provider {
    
    public let apiKey: String
    public let stripe: StripeClass
    
    public convenience init(config: Config) throws {
        guard let stripeConfig = config["stripe"]?.object else {
            throw StripeError.missingConfig
        }
        guard let apiKey = stripeConfig["apiKey"]?.string else {
            throw StripeError.missingAPIKey
        }
        try self.init(apiKey: apiKey)
    }
    
    public init(apiKey: String) throws {
        self.apiKey = apiKey
        self.stripe = try StripeClass(apiKey: apiKey)
    }
    
    public func boot(_ drop: Droplet) {
        drop.stripe = self.stripe
    }
    
    public func afterInit(_ drop: Droplet) {
        
    }
    
    public func beforeRun(_ drop: Droplet) {
        
    }
    
}
