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
        DispatchQueue.global(qos: .userInitiated).sync {
            WebServicesAPI().getRequestBillboardInfo() {
                succesful, error in
                if !succesful! {
                    completion(false, error?.localizedDescription)
                } else {
                    completion(true, nil)
                }
            }
        }
    }
    
    func queryMovieData() -> Results<Object>? {
        autoreleasepool {
            let movies = RealmApi().allObjects(fromObject: MovieRLM.self)
            return movies
        }
    }
    
    func queryRouteData() {
        autoreleasepool {
            let routesObjects = RealmApi().allObjects(fromObject: RouteRLM.self)
            guard let routes = routesObjects?.toArray(ofType: RouteRLM.self) else { return }
            var poster = ""
            var backgroundSynopsis = ""
            var trailerMp4 = ""
            var posterHorizontal = ""
            var ribbon = ""
            for route in routes {
                let code = route.code
                if code == "poster" {
                    let sizes = route.sizes
                    for size in sizes {
                        poster = size.medium ?? ""
                    }
                }
                if code == "background_synopsis" {
                    let sizes = route.sizes
                    for size in sizes {
                        backgroundSynopsis = size.medium ?? ""
                    }
                }
                if code == "trailer_mp4" {
                    let sizes = route.sizes
                    for size in sizes {
                        trailerMp4 = size.medium ?? ""
                    }
                }
                if code == "poster_horizontal" {
                    let sizes = route.sizes
                    for size in sizes {
                        posterHorizontal = size.medium ?? ""
                    }
                }
                if code == "ribbon" {
                    let sizes = route.sizes
                    for size in sizes {
                        ribbon = size.medium ?? ""
                    }
                }
            }
            let moviesModelDecorated = Billboard.Info.RoutesModel(poster: poster, backgroundSynopsis: backgroundSynopsis, trailerMp4: trailerMp4, posterHorizontal: posterHorizontal, ribbon: ribbon)
            
            let userDefaultsPosterURLKeyVal: UserDefaultsKeyVal = UserDefaultsKeyVal(key: "posterURL", value: moviesModelDecorated.poster)
            let userDefaultsBackgroundSynopsisURLKeyVal: UserDefaultsKeyVal = UserDefaultsKeyVal(key: "backgroundSynopsisURL", value: moviesModelDecorated.backgroundSynopsis)
            let userDefaultsTrailerMp4URLKeyVal: UserDefaultsKeyVal = UserDefaultsKeyVal(key: "trailerMp4URL", value: moviesModelDecorated.trailerMp4)
            let userDefaultsPosterHorizontalURLKeyVal: UserDefaultsKeyVal = UserDefaultsKeyVal(key: "posterHorizontalURL", value: moviesModelDecorated.posterHorizontal)
            let userDefaultsRibbonURLKeyVal: UserDefaultsKeyVal = UserDefaultsKeyVal(key: "ribbonURL", value: moviesModelDecorated.ribbon)
            let userDefaultsKeysVals: [UserDefaultsKeyVal] = [
                userDefaultsPosterURLKeyVal,
                userDefaultsBackgroundSynopsisURLKeyVal,
                userDefaultsTrailerMp4URLKeyVal,
                userDefaultsPosterHorizontalURLKeyVal,
                userDefaultsRibbonURLKeyVal]
            UserDefaultsHelper().setUserDefaultsKeyVals(userDefaultsKeysVals: userDefaultsKeysVals)
        }
    }
    
    // MARK: Store response data
    
    func storeBillboardResponseData(responseData decodedData: Billboard.Info.ResponseWSModel) {
        autoreleasepool {
            let billboardEntity = BillboardRLM()
            let moviesEntityList = List<MovieRLM>()
            let routesEntityList = List<RouteRLM>()
            
            let billboardData = decodedData
            let moviesData = billboardData.movies
            let routesData = billboardData.routes
            var movieId = 0
            for movie in moviesData {
                movieId += 10
                let mediaEntityList = List<MediaRLM>()
                let castEntityList = List<CastRLM>()
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
                var mediaId = 0
                for media in mediaData {
                    mediaId += movieId + 1
                    let resourceData = media.resource
                    let typeData = media.type
                    let codeData = media.code
                    let mediaEntityData = MediaRLM()
                    mediaEntityData.id = String(mediaId)
                    mediaEntityData.resource = resourceData
                    mediaEntityData.type = typeData
                    mediaEntityData.code = codeData
                    mediaEntityList.append(mediaEntityData)
                }
                var castId = 0
                for cast in castData {
                    castId += movieId + 1
                    let labelData = cast.label
                    let valueData = cast.value
                    let valueEntityData = List<String>()
                    for value in valueData {
                        valueEntityData.append(value)
                    }
                    let castEntityData = CastRLM()
                    castEntityData.id = String(castId)
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
                let sizesEntityList = List<SizeRLM>()
                let codeData = route.code
                let sizesData = route.sizes
                let sizesEntityData = SizeRLM()
                sizesEntityData.large = sizesData.large
                sizesEntityData.medium = sizesData.medium
                sizesEntityData.small = sizesData.small
                sizesEntityData.xLarge = sizesData.xLarge
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
