
//  Created by George Leonidas on 05/09/2018.
//  Copyright © 2018 George Leonidas. All rights reserved.
//

import Foundation
import UIKit

private var kSessionPropertyKey = "ImageViewCacheSession"

public extension UIImageView {
    
    var session : URLSession? {
        get {
            return objc_getAssociatedObject(self, &kSessionPropertyKey) as? URLSession
        }
        set {
            objc_setAssociatedObject(self, &kSessionPropertyKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    /// Set Image on an ImageView from cahce if exists, otherwise make the call with the given imageURL
    ///
    /// - Parameters:
    ///   - imageURL: The URL of the image that needs to be retrieved
    ///   - placeholder: A placeholder for the image
    ///   - toBeCahced: Boolean value if image needs to be cached
    func setImage(withImageURL imageURL: String?, placeholder: UIImage? = nil, toBeCached: Bool = true, completionBlock: ((Bool) -> Void)? = nil) {
        /// Set placeholder as background image
        self.image = placeholder
        
        /// Safe unwrap of imageURL String
        if let imageURL = imageURL {
            
            /// Chaeck if image exists in Cache
            if let image = CacheHelper.get(withIdentifier: imageURL) {
                self.image = image
                completionBlock?(true)
            } else {
                
                var urlObject: URL?
                if let safeURL = URL(string : imageURL) {
                    urlObject = safeURL
                } else if let percentEncodedUrl = URL(string : imageURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") {
                    urlObject = percentEncodedUrl
                }
                
                guard let url = urlObject else {
                    print("Image Cacher: String URL provided for image: \(self.image?.description ?? "") is not valid URL")
                    completionBlock?(false)
                    return
                }
                
                self.session = URLSession(configuration: .ephemeral)
                //creating a dataTask
                let getImageFromUrl = session?.dataTask(with: url) { (data, response, error) in
                    
                    if let e = error {
                        completionBlock?(false)
                        // handling error
                        print(e.localizedDescription)
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
                                        completionBlock?(true)
                                    }
                                }
                            } else {
                                completionBlock?(false)
                                print("Image Cacher: Image file is currupted")
                            }
                        } else {
                            completionBlock?(false)
                            print("Image Cacher: No response from server")
                        }
                    }
                }
                getImageFromUrl?.resume()
            }
        }
    }
    
    func cancelPendingTasks() {
        self.session?.invalidateAndCancel()
    }
    
    func finishTasksAndInvalidate() {
        self.session?.finishTasksAndInvalidate()
    }
}
