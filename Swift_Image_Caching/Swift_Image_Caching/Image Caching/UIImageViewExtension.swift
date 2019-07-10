
//  Created by George Leonidas on 05/09/2018.
//  Copyright © 2018 George Leonidas. All rights reserved.
//

import Foundation
import UIKit

public extension UIImageView {
    
    /// Set Image on an ImageView from cahce if exists, otherwise make the call with the given imageURL
    ///
    /// - Parameters:
    ///   - imageURL: The URL of the image that needs to be retrieved
    ///   - placehoder: A placeholder for the image
    ///   - toBeCahced: Boolean value if image needs to be cached
    public func setImage(withImageURL imageURL: String?, placeholder: UIImage? = nil, toBeCached: Bool = true, completionBlock: ((Bool) -> Void)? = nil) {
        /// Set placeholder as background image
        self.image = placeholder
        
        /// Safe unwrap of imageURL String
        if let imageURL = imageURL {
            
            /// Chaeck if image exists in Cache
            if let image = CacheHelper.get(withIdentifier: imageURL) {
                self.image = image
                if let completionBlock = completionBlock {
                    completionBlock(true)
                }
            } else {
                
                guard let url = URL(string: imageURL.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? "") else {
                    print("Image Cacher: String URL provided for image: \(self.image?.description ?? "") is not valid URL")
                    if let completionBlock = completionBlock {
                        completionBlock(false)
                    }
                    return
                }
                
                let session = URLSession(configuration: .ephemeral)
                
                //creating a dataTask
                let getImageFromUrl = session.dataTask(with: url) { (data, response, error) in
                    
                    if let e = error {
                        if let completionBlock = completionBlock {
                            completionBlock(false)
                        }
                        // handling error
                        print(e)
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
                                        if toBeCached {
                                            CacheHelper.set(resultImage, withIdentifier: imageURL)
                                        }
                                        self.image = resultImage
                                        if let completionBlock = completionBlock {
                                            completionBlock(true)
                                        }
                                    }
                                }
                            } else {
                                if let completionBlock = completionBlock {
                                    completionBlock(false)
                                }
                                print("Image Cacher: Image file is currupted")
                            }
                        } else {
                            if let completionBlock = completionBlock {
                                completionBlock(false)
                            }
                            print("Image Cacher: No response from server")
                        }
                    }
                }
                //starting the download task
                getImageFromUrl.resume()
            }
        }
    }
}
