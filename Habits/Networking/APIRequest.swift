//
//  APIRequest.swift
//  Habits
//
//  Created by Eduard Ptushko on 16.01.2024.
//

import Foundation
import SwiftUI

protocol APIRequest {
    associatedtype Response

    var path: String { get }
    var request: URLRequest { get }
    var queryItems: [URLQueryItem]? { get }
    var postData: Data? { get }
}

extension APIRequest {
    var port: Int { 8080 }
    var host: String { "localhost" }
}

extension APIRequest {
    var queryItems: [URLQueryItem]? { nil }
    var postData: Data? { nil }
}

extension APIRequest {
    var request: URLRequest {
        var components = URLComponents()

        components.scheme = "http"
        components.host = host
        components.port = port
        components.path = path
        components.queryItems = queryItems

        var request = URLRequest(url: components.url!)

        if let data = postData {
            request.httpBody = data
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        }

        return request
    }
}

enum APIRequestError: Error {
    case itemsNotFound
    case requestFailed
}

extension APIRequest where Response: Decodable {
    func send() async throws -> Response {
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw APIRequestError.itemsNotFound
        }

        let decoder = JSONDecoder()
        let decoded = try decoder.decode(Response.self, from: data)
        return decoded
    }
}

enum ImageRequestError: Error {
    case couldNotInitializeFromData
    case imageDataMissing
}

extension APIRequest where Response == UIImage {
    func send() async throws -> UIImage {
        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw ImageRequestError.imageDataMissing
        }

        guard let image = UIImage(data: data) else {
            throw ImageRequestError.couldNotInitializeFromData
        }

        return image
    }
}

extension APIRequest {
    func send() async throws {
        let (_, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw APIRequestError.requestFailed
        }
    }
}
