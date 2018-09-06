
//  Created by George Leonidas on 05/09/2018.
//  Copyright © 2018 George Leonidas. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    /// Set Image on an ImageView from cahce if exists, otherwise make the call with the given imageURL
    ///
    /// - Parameters:
    ///   - imageURL: The URL of the image that needs to be retrieved
    ///   - placehoder: A placeholder for the image
    ///   - toBeCahced: Boolean value if image needs to be cached
    func setImage(withImageURL imageURL: String?, placehoder: UIImage? = nil, toBeCahced: Bool = false) {
        /// Set placeholder as background image
        self.image = placehoder
        
        /// Safe unwrap of imageURL String
        if let imageURL = imageURL {
            
            /// Chaeck if image exists in Cache
            if let image = CacheHelper.get(withIdentifier: imageURL) {
                self.image = image
            } else {
                
                guard let url = URL(string: imageURL) else { return }
                
                let session = URLSession(configuration: .default)
        
                //creating a dataTask
                let getImageFromUrl = session.dataTask(with: url) { (data, response, error) in
                    
                    if let e = error {
                        // handling error
                        print("Error Occurred: \(e)")
                    } else {
                        //in case of no error, checking wheather the response is nil or not
                        if response as? HTTPURLResponse != nil {
                            
                            //checking if the response contains an image
                            if let imageData = data {
                                // Create the UIImage
                                if let resultImage = UIImage(data: imageData) {
                                    
                                    // Displaying the image in Main Thread
                                    DispatchQueue.main.async {
                                        /// Store image to Cache if we need it
                                        if toBeCahced {
                                            CacheHelper.set(resultImage, withIdentifier: imageURL)
                                        }
                                        self.image = resultImage
                                    }
                                }
                            } else {
                                print("Image file is currupted")
                            }
                        } else {
                            print("No response from server")
                        }
                    }
                }
                //starting the download task
                getImageFromUrl.resume()
            }
        }
    }
}
