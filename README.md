# Serpnode (CocoaPods)

- Website: https://serpnode.com
- Docs: https://serpnode.com/docs/

## Installation

```ruby
pod 'Serpnode', :git => 'https://github.com/martechdev/serpnode-ios.git', :tag => '0.1.0'
```

## Usage

```swift
import Serpnode

let client = SerpnodeClient(configuration: .init(apiKey: "YOUR_API_KEY"))

Task {
    let result = try await client.search(params: [
        "q": "site:screenshotbase.com",
        "engine": "google",
        "num": 10
    ])
    print(result)
}
```

## License
MIT
