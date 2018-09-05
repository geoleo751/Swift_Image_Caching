# Swift_Image_Caching

[![4.0](https://img.shields.io/badge/Swift%203.0--green.svg)](https://developer.apple.com/swift/)
[![MIT](https://img.shields.io/github/license/mashape/apistatus.svg)](https://opensource.org/licenses/MIT)

Easy way to download and cache Images from the internet to use them in your iOS projects.
Written in Swift

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Installing

> **Manual:**

> - drag 'n drop CacheHelper.swift into your project.
> - drag 'n drop UIImageViewExtension.swift into your project.

### Usage

Set Image on an ImageView from cahce if exists, otherwise make the call with the given imageURL

Parameters:
- imageURL: The URL of the image that needs to be retrieved (String)
- placehoder: A placeholder for the image (UIImage)
- toBeCahced: Boolean value if image needs to be cached (Bool)

````
  yourImageView.setImage(withImageURL: imageUrl, placehoder: #imageLiteral(resourceName: "placeholder"), toBeCahced: true)

````

## Authors

* **George Leonidas** 

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* Hat tip to anyone whose code was used
* Inspiration
* etc
