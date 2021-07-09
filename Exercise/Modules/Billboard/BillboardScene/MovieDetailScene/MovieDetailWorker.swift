//
//  MovieDetailWorker.swift
//  Exercise
//
//  Created by Jorge Rebollo Jimenez on 08/07/21.
//
//

import UIKit
import RealmSwift

class MovieDetailWorker {
    
    // MARK: Worker Tasks
    
    func requestMovieDetails(withMovie: Int, completion: @escaping ((MovieRLM?, String?, String?) -> Void)) {
        let movieDetailsAndULRs = queryMovieData(withMovie)
        let movieDetails = movieDetailsAndULRs.0
        let backgroundSynopsisURL = movieDetailsAndULRs.1
        let trailerMp4URL = movieDetailsAndULRs.2
        completion(movieDetails, backgroundSynopsisURL, trailerMp4URL)
    }
    
    func queryMovieData(_ moviePosition: Int) -> (MovieRLM?, String?, String?) {
        DispatchQueue.global(qos: .userInitiated).sync {
            autoreleasepool {
                let movie = RealmApi().selectSingle(className: MovieRLM.self, primaryKey: moviePosition) as? MovieRLM
                let backgroundSynopsisURL = UserDefaults.standard.string(forKey: "backgroundSynopsisURL")
                let trailerMp4URL = UserDefaults.standard.string(forKey: "trailerMp4URL")
                return (movie, backgroundSynopsisURL, trailerMp4URL)
            }
        }
    }
}
