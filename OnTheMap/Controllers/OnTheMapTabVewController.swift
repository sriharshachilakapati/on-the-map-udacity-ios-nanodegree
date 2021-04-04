//
//  OnTheMapTabVewController.swift
//  OnTheMap
//
//  Created by Sri Harsha Chilakapati on 31/03/21.
//

import UIKit

class OnTheMapTabViewController : UITabBarController {
    
    var locationsResponse: UserLocationResponse? = nil
    
    func fetchLocations(completion: @escaping () -> Void) {
        showProgressIndicator {
            let request = UserLocationRequest(limit: 100, skip: nil, uniqueKey: nil, order: "-updatedAt")
            
            udacityGetUserLocationsApi.call(withPayload: request) { result in
                self.hideProgressIndicator {
                    switch result {
                        case .success(let response):
                            self.locationsResponse = response
                            completion()
                            
                        case .failure(let error):
                            print(error)
                    }
                }
            }
        }
    }
    
    @IBAction private func doLogout() {
        showProgressIndicator {
            udacitySessionDeleteApi.call { result in
                self.hideProgressIndicator {
                    switch (result) {
                        case .success(_):
                            AppSession.current = nil
                            AppSession.userAccount = nil
                            
                            self.dismiss(animated: true)
                            
                        case .failure(let error):
                            print(error)
                    }
                }
            }
        }
    }
}
