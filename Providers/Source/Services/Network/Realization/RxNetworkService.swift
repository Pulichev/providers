//
//  RxNetworkService.swift
//  Providers
//
//  Created by Victor Volnukhin on 16/10/2019.
//  Copyright © 2019 Victor Volnukhin. All rights reserved.
//

import RxSwift

class RxNetworkService: NetworkServiceProtocol {
    var disposeBag = DisposeBag()
    
    func sendRequest(url: URL, responseHandler: @escaping (Data?, Error?) -> Void) {
        URLSession.shared.rx
        .response(request: URLRequest(url: url))
        .observeOn(MainScheduler.instance)
        .subscribe(onNext: { response, data in
            switch response.statusCode {
            case 200:
                responseHandler(data, nil)
            default:
                responseHandler(nil, NetworkError.dontDownload)
            }
        }, onError: { error in
            responseHandler(nil, error)
        })
        .disposed(by: disposeBag)
    }
}
