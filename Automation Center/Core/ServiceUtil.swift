//
//  ServiceUtil.swift
//  Automation Center
//
//  Created by fatih.sukran on 5.11.2023.
//

import Foundation
import Alamofire

/// Protocol defining the service contract for making HTTP requests.
protocol IService {
    
    /// Set a single header for the request.
    func header(key: String, value: String) -> Self
    
    /// Set multiple headers for the request using a dictionary.
    func header(dict: [String: String]) -> Self
    
    /// Add a single HTTPHeader object to the request headers.
    func header(httpHeader: HTTPHeader) -> Self
    
    /// Add multiple HTTPHeader objects to the request headers.
    func header(httpHeaders: HTTPHeaders) -> Self
    
    /// Set a single parameter for the request.
    func parameter(key: String, value: Any) -> Self
    
    /// Set multiple parameters for the request using a dictionary.
    func parameter(dict: [String: Any]) -> Self
    
    /// Set the HTTP method for the request.
    @discardableResult
    func method(_ method: HTTPMethod) -> Self
    
    /// Set the HTTP method to GET and specify the URL as a string.
    func `get`(_ url: String) -> Self
    
    /// Set the HTTP method to GET and specify the URL as a URL object.
    func `get`(_ uri: URL) -> Self
    
    /// Set the HTTP method to POST and specify the URL as a string.
    func post(_ url: String) -> Self
    
    /// Set the HTTP method to POST and specify the URL as a URL object.
    func post(_ url: URL) -> Self
    
    func `as`<T: Decodable>(_ type: T.Type) async throws -> T
}

/// Concrete implementation of the IService protocol for making HTTP requests using Alamofire.
class ServiceUtil: IService {
    
    /// The base URL for the service.
    static var BASE_URL = ""
    
    private var dataRequest: DataRequest?
    
    /// The HTTP method for the request. Default is set to .post.
    private var method: HTTPMethod = .get
    
    /// The parameters to be included in the request.
    private var parameters: [String: Any] = [:]
    
    /// The headers to be included in the request.
    private var headers: HTTPHeaders = HTTPHeaders()
    
    /// Set a single header for the request.
    func header(key: String, value: String) -> Self {
        headers.add(name: key, value: value)
        return self
    }
    
    /// Set multiple headers for the request using a dictionary.
    func header(dict: [String : String]) -> Self {
        dict.forEach { (key: String, value: String) in
            headers.add(name: key, value: value)
        }
        return self
    }
    
    /// Add a single HTTPHeader object to the request headers.
    func header(httpHeader: HTTPHeader) -> Self {
        headers.add(httpHeader)
        return self
    }
    
    /// Add multiple HTTPHeader objects to the request headers.
    func header(httpHeaders: HTTPHeaders) -> Self {
        httpHeaders.forEach { httpHeader in
            headers.add(httpHeader)
        }
        return self
    }
    
    /// Set a single parameter for the request.
    func parameter(key: String, value: Any) -> Self {
        parameters[key] = value
        
        return self
    }
    
    /// Set multiple parameters for the request using a dictionary.
    func parameter(dict: [String : Any]) -> Self {
        parameters.merge(dict) { (_, new) in new }
        
        return self
    }
    
    /// Set the HTTP method for the request.
    @discardableResult func method(_ method: Alamofire.HTTPMethod) -> Self {
        self.method = method
        
        return self
    }
}

extension ServiceUtil {
    /// Set the HTTP method to GET and specify the URL as a string.
    func `get`(_ url: String) -> Self {
        self.method(.get)
        return makeRequest(url: url)
    }
    
    /// Set the HTTP method to GET and specify the URL as a URL object.
    func `get`(_ url: URL) -> Self {
        self.method(.get)
        return makeRequest(url: url)
    }
    
    /// Set the HTTP method to POST and specify the URL as a string.
    func post(_ url: String) -> Self {
        self.method(.post)
        return makeRequest(url: url)
    }
    
    /// Set the HTTP method to POST and specify the URL as a URL object.
    func post(_ url: URL) -> Self {
        self.method(.post)
        return makeRequest(url: url)
    }
}

extension ServiceUtil {
    func `as`<T: Decodable>(_ type: T.Type) async throws -> T {
        guard let dataRequest = self.dataRequest else {
            throw fatalError("dataRequest is nil")
        }

        return try await dataRequest.serializingDecodable(type).value
    }
    
    func asString() async throws -> String {
        guard let dataRequest = self.dataRequest else {
            throw fatalError("dataRequest is nil")
        }

        return try await dataRequest.validate().serializingString().value
    }
}

extension ServiceUtil {
    
    func makeRequest(url: String) -> Self {
        makeRequest(url: URL(string: Self.BASE_URL + url)!)
    }
    
    func makeRequest(url: URL) -> Self {
        dataRequest = AF.request(url,
                   method: self.method,
                   parameters: parameters,
                   headers: headers)
        return self
    }
}
