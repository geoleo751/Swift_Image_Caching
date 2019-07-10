# Swift_Image_Caching

[![4.2](https://img.shields.io/badge/Swift-4.0-green.svg)](https://developer.apple.com/swift/)
[![MIT](https://img.shields.io/github/license/mashape/apistatus.svg)](https://opensource.org/licenses/MIT)

Easy way to download and cache Images from the internet to use them in your iOS projects.
Written in Swift

### Installation

**Manual:**

- drag 'n drop everything in Image Caching folder into your project.

### Usage

When you need to download an UIImage and set it to your UIImageView call the methor "setImage" from your UIImageView.

If the image is previously downloaded and exists in cache, it is set immediately. Otherwise a network call is made with the given imageURL to fetch the image data.

````
  yourImageView.setImage(withImageURL: imageUrl, placehoder: #imageLiteral(resourceName: "placeholder"), toBeCahced: true)

````

Parameters:
- imageURL: The URL of the image that needs to be retrieved (String)
- placehoder: A placeholder for the image (UIImage)
- toBeCahced: Boolean value if image needs to be cached (Bool)

## Authors

* **George Leonidas**

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
