//
//  BillboardWorker.swift
//  Exercise
//
//  Created by Jorge Rebollo Jimenez on 06/07/21.
//
//

import UIKit
import RealmSwift

class BillboardWorker {
    
    // MARK: Worker Tasks
    
    func attemptBillboardInfo(completion: @escaping ((Bool?, String?) -> Void)) {
        DispatchQueue.global(qos: .background).async {
            WebServicesAPI().getRequestBillboardInfo() {
                succesful, error in
                if !succesful! {
                    let stringError = self.setError(error: error)
                    completion(false, stringError)
                } else {
                    completion(true, nil)
                }
            }
        }
    }
    
    func setError(error: NSError?) -> String? {
        guard let error = error else {
            return "wrongDataErrorAlertMessage".localized
        }
        let errorCodeString = error.userInfo["error"] as? String ?? "null"
        let errorMessageString = error.userInfo["error_description"] as? String ?? "null"
        let errorString = "Código de error: " + errorCodeString + ".\nMensaje de error: " + errorMessageString
        return errorString
    }
    
    // MARK: Store response data
    
    func storeBillboardResponseData(responseData decodedData: Billboard.Info.ResponseWSModel) {
        DispatchQueue.global(qos: .background).async {
            autoreleasepool {
                let billboardEntity = BillboardRLM()
                let moviesEntityList = List<MovieRLM>()
                let routesEntityList = List<RouteRLM>()
                let mediaEntityList = List<MediaRLM>()
                let castEntityList = List<CastRLM>()
                let sizesEntityList = List<SizeRLM>()
                
                let billboardData = decodedData
                let moviesData = billboardData.movies
                let routesData = billboardData.routes
                
                for movie in moviesData {
                    let ratingData = movie.rating
                    let mediaData = movie.media
                    let castData = movie.cast
                    //let cinemasData = movie.cinemas
                    let positionData = movie.position
                    let categoriesData = movie.categories
                    let genreData = movie.genre
                    let synopsisData = movie.synopsis
                    let lengthData = movie.length
                    let releaseDateData = movie.releaseDate
                    let distributorData = movie.distributor
                    let idData = movie.id
                    let nameData = movie.name
                    let codeData = movie.code
                    let originalNameData = movie.originalName
                    for media in mediaData {
                        let resourceData = media.resource
                        let typeData = media.type
                        let codeData = media.code
                        let mediaEntityData = MediaRLM()
                        mediaEntityData.resource = resourceData
                        mediaEntityData.type = typeData
                        mediaEntityData.code = codeData
                        mediaEntityList.append(mediaEntityData)
                    }
                    for cast in castData {
                        let labelData = cast.label
                        let valueData = cast.value
                        let valueEntityData = List<String>()
                        for value in valueData {
                            valueEntityData.append(value)
                        }
                        let castEntityData = CastRLM()
                        castEntityData.label = labelData
                        castEntityData.value = valueEntityData
                        castEntityList.append(castEntityData)
                    }
                    let categoriesEntityData = List<String>()
                    for category in categoriesData {
                        categoriesEntityData.append(category)
                    }
                    let movieEntityData = MovieRLM()
                    movieEntityData.rating = ratingData
                    movieEntityData.media = mediaEntityList
                    movieEntityData.cast = castEntityList
                    movieEntityData.position = positionData
                    movieEntityData.categories = categoriesEntityData
                    movieEntityData.genre = genreData
                    movieEntityData.synopsis = synopsisData
                    movieEntityData.length = lengthData
                    movieEntityData.releaseDate = releaseDateData
                    movieEntityData.distributor = distributorData
                    movieEntityData.id = idData
                    movieEntityData.name = nameData
                    movieEntityData.code = codeData
                    movieEntityData.originalName = originalNameData
                    moviesEntityList.append(movieEntityData)
                }
                var routeId = 0
                for route in routesData {
                    routeId += 1
                    let codeData = route.code
                    let sizesData = route.sizes
                    let sizesEntityData = SizeRLM()
                    if (sizesData.large != nil) {
                        sizesEntityData.large = sizesData.large
                    } else if (sizesData.medium != nil) {
                        sizesEntityData.medium = sizesData.medium
                    } else if (sizesData.small != nil) {
                        sizesEntityData.small = sizesData.small
                    } else if (sizesData.xLarge != nil) {
                        sizesEntityData.xLarge = sizesData.xLarge
                    }
                    sizesEntityData.id = String(routeId)
                    sizesEntityList.append(sizesEntityData)
                    let routeEntityData = RouteRLM()
                    routeEntityData.code = codeData
                    routeEntityData.sizes = sizesEntityList
                    routesEntityList.append(routeEntityData)
                }
                
                billboardEntity.movies = moviesEntityList
                billboardEntity.routes = routesEntityList
                
                RealmApi().writeEntity(billboardEntity)
            }
        }
    }
}
