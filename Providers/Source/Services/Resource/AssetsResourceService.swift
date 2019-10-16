//
//  AssetsResourceService.swift
//  Providers
//
//  Created by Victor Volnukhin on 09/10/2019.
//  Copyright © 2019 Victor Volnukhin. All rights reserved.
//

import RxSwift

class AssetsResourceService: ResourceServiceProtocol {
    
    
    // MARK: - Public fields
    
    var error: PublishSubject<Error> = PublishSubject<Error>()
    
    
    // MARK: - Public methods
    
    /// Чтобы "обкатать" выполнение, было решено добавить JSON в файл.
    /// Эта функция позволит получить этот файл и продолжить с ним работу.
    func loadDataFromResource(url: String, completionHandler: (Data?) -> Void) {
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: url), options: .mappedIfSafe)
            completionHandler(data)
        }
        catch {
            self.error.onNext(error)
        }
    }
    
}
