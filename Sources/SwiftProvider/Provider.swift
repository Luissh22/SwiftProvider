//
//  Provider.swift
//  SwiftProvider
//
//  Created by Luis Abraham on 2020-08-29.
//

import Foundation

public typealias Builder = (Provider) -> AnyObject

public protocol ProviderProtocol {
    func register<T>(type: T.Type, builder: @escaping Builder)
    func provide<T>(type: T.Type) -> T?
}

public class Provider: ProviderProtocol {
    
    private var services = [String: Builder]()
    
    /// Registers factory method with a type
    public func register<T>(type: T.Type, builder: @escaping Builder) {
        services["\(type)"] = builder
    }
    
    /// Returns instantiated object for requested type
    public func provide<T>(type: T.Type) -> T? {
        guard let builder = services["\(type)"] else { return nil }
        
        return builder(self) as? T
    }
    
}
