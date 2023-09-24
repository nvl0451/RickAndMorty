//
//  RMEpisodeUrlGetter.swift
//  RickAndMorty
//
//  Created by Андрей Королев on 23.09.2023.
//

import Foundation

struct Resource: Codable {
    var _embedded: ResourceList?
    var name: String
}

struct ResourceList: Codable {
    var items: [Resource]
}

struct Link: Codable {
    var href: String
}

enum RMEpisodeURLError: Error {
    case invalidEpisode
    
    case invalidFolder
    
    case episodeNotFound
    
    case linkNotFound
}

final class RMEpisodeUrlGetter {
    
    static let shared = RMEpisodeUrlGetter()
    
    static let auth = "yandex_key_goes_here"
    
    init() {
        
    }
    
    private func getEpisodeCode(season: Int, episode: Int) async throws -> String {
        guard season >= 1 && season <= 5 else {
            print("invalid season number")
            throw RMEpisodeURLError.invalidEpisode
        }
        guard episode >= 1 && episode <= (10 + (season == 1 ? 1 : 0)) else {
            //season 1 has 11 episodes while seasons 2-5 have just 10
            print("invalid episode number")
            throw RMEpisodeURLError.invalidEpisode
        }
        let episodeCode = "S0\(season)E" + (episode >= 10 ? String(episode) : "0\(episode)")
        return episodeCode
    }
    
    private func getFilename(folderData: Resource, episodeCode: String) async throws -> String {
        guard let embeddedResources = folderData._embedded else {
            print("invalid folder")
            throw RMEpisodeURLError.invalidFolder
        }
        
        let titles = embeddedResources.items.compactMap({ resourse in
            return resourse.name
        })
        for title in titles {
            if title.contains(episodeCode) {
                return title
            }
        }
        throw RMEpisodeURLError.episodeNotFound
    }
    
    public func getEpisodeDownloadUrl(season: Int, episode: Int) async -> URL? {
        var downloadLink: URL? = URL(string: "")
        
        do {
            let episodeCode = try await getEpisodeCode(season: season, episode: episode)
            
            let folderData = try await getEpisodeArray()
            
            let fileName = try await getFilename(folderData: folderData, episodeCode: episodeCode)
            
            downloadLink = try await getDownloadLink(filename: fileName) as! URL
            //print(downloadLink)
            return downloadLink
        } catch let error {
            print(error)
        }
        
        return downloadLink
    }
    
    public func getEpisodeDownloadUrl(episodeCode: String) async -> URL? {
        var downloadLink: URL? = URL(string: "")
        
        do {
            let folderData = try await getEpisodeArray()
            
            let fileName = try await getFilename(folderData: folderData, episodeCode: episodeCode)
            
            downloadLink = try await getDownloadLink(filename: fileName) as! URL
            //print(downloadLink)
            return downloadLink
        } catch let error {
            print(error)
        }
        
        return downloadLink
    }
    
    private func getDownloadLink(filename: String) async throws -> URL {
        guard let url = URL(string: "https://cloud-api.yandex.net/v1/disk/resources/download/?path=rickandmorty/\(filename)") else {
            throw URLError(.badURL)
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("OAuth \(RMEpisodeUrlGetter.auth)", forHTTPHeaderField: "Authorization")

        let (data, response) = try await URLSession.shared.data(for: request)

        let linkResult = try JSONDecoder().decode(Link.self, from: data)
        let finalUrl = URL(string: linkResult.href)
        return finalUrl!
    }
    
    private func getEpisodeArray() async throws -> Resource {
        let urlString = "https://cloud-api.yandex.net/v1/disk/resources/?path=/rickandmorty&limit=60"
        let url = URL(string: urlString)
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.addValue("OAuth \(RMEpisodeUrlGetter.auth)", forHTTPHeaderField: "Authorization")
        
        let session = URLSession.shared
        
        let (data, response) = try await session.data(for: request)
        
        //print(String(describing: data))
        //print(String(describing: response))
        
        let folderData = try JSONDecoder().decode(Resource.self, from: data)
        
        //print(folderData)
        return folderData
    }
}
