
//  Created by George Leonidas on 05/09/2018.
//  Copyright © 2018 George Leonidas. All rights reserved.
//

import Foundation
import UIKit

class CacheHelper {
    
    static var cache = NSCache<NSString, UIImage>()
    
    static func set(_ value: UIImage?, withIdentifier identifier: String) {
        
        // 1. If the value is nil, remove value from the cache
        guard let value = value else {
            cache.removeObject(forKey: NSString(string: identifier))
            
            do {
                try FileManager.default.removeItem(atPath: identifier)
            } catch _ {}
            
            return
        }
        
        // 2. Otherwise, keep the object in memory
        cache.setObject(value, forKey: NSString(string: identifier))
    }
    
    // MARK: Retreiving data
    static func get(withIdentifier identifier: String) -> UIImage? {
        
        // 1. If the identifier is nil, or empty, return nil
        if identifier == "" { return nil }
        
        // 2. Try the memory cache
        guard let cachedImage = cache.object(forKey: NSString(string: identifier)) else { return nil }
        
        return cachedImage
        
    }
}

