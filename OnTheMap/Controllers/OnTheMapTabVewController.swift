//
//  OnTheMapTabVewController.swift
//  OnTheMap
//
//  Created by Sri Harsha Chilakapati on 31/03/21.
//

import UIKit

class OnTheMapTabViewController : UITabBarController {
    @IBAction private func doLogout() {
        udacitySessionDeleteApi.call { result in
            switch (result) {
                case .success(_):
                    AppSession.current = nil
                    AppSession.userAccount = nil
                    
                    DispatchQueue.main.async {
                        self.dismiss(animated: true)
                    }
                    
                case .failure(let error):
                    print(error)
            }
        }
    }
}
