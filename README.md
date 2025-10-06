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

## Examples

### Local SEO with location
```swift
let sf = try await client.search(params: [
  "q": "coffee",
  "engine": "google",
  "location_id": "21176", // example location id
  "num": 20
])
```

### Images and News
```swift
let images = try await client.search(params: [
  "q": "aurora borealis",
  "engine": "google_images",
  "num": 30
])

let news = try await client.search(params: [
  "q": "web performance",
  "engine": "google_news",
  "num": 20
])
```

### Pagination for deeper results
```swift
let page1 = try await client.search(params: ["q": "meteor tutorial", "engine": "google", "start": 0, "num": 10])
let page2 = try await client.search(params: ["q": "meteor tutorial", "engine": "google", "start": 10, "num": 10])
```

## License
MIT
