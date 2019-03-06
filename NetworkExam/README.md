# [Alamofire](https://github.com/Alamofire/Alamofire)

iOS 및 macOS에 대한 swift 기반 HTTP 프로토콜 네트워킹을 위한  **비동기 라이브러리**이다.

- Request(요청) / Response(응답) 메소드 지원
- URL/JSON 매개변수와 응답 직렬화(Response Serialization)
- File/Data/Stream/MultipartFormData 업로드 기능 제공
- 인증(Authentication)
- HTTP Response의 Validation

## Request

서버에 요청을 보내기 위해 제공되는 함수

```swift
AF.request("http://url.com")
```

> 5.0 부터 Alamofire 열거형이 AF로 변경

### HTTP Method 열거형 객체

> method

```swift
public enum HTTPMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
    
}
```

- Alamofire의 HTTP 메소드 기본값은 GET 이기 때문에 생략시 GET 방식으로 전송
- POST 방식으로 전송하고 싶다면 매개변수 `method` 를 추가해준다.

```swift
AF.request("http://url.com/post", method: .post)
```

### Parameters, Encoding 

> parameters

- Alamofire는 URL, JSON, PropertyList등 3가지 매개변수 인코딩 유형을 지원한다.
- `parameterEncoding` protocol 을 준수하는 범위에서 custum encoding을 지원한다.

```swift
let parameters: Parameters = [
	"name": "gaki",
    "age": 25
]

AF.request("http://url.com/post",
           method: .post,
           parameters: parameters,
           encoding: URLEncoding.default)
```











