# [Alamofire](https://github.com/Alamofire/Alamofire)

iOS 및 macOS에 대한 swift 기반 HTTP 프로토콜 네트워킹을 위한  **비동기 라이브러리**이다.

- Request(요청) / Response(응답) 메소드 지원
- URL/JSON 매개변수와 응답 직렬화(Response Serialization)
- File/Data/Stream/MultipartFormData 업로드 기능 제공
- 인증(Authentication)
- HTTP Response의 Validation


## first of all

**HTTP 프로토콜 방식**
HTTP는 웹 서버가 화면에 데이터를 전송하기 위해 사용하는 앱 프로토콜 또는 규칙의 집합입니다. 여러분은 웹 브라우져에 입력한 모든 URL의 앞에 HTTP(또는 HTTPS)를 본적이 있습니다. FTP, Telnet, SSH와 같은 다른 앱 프로토콜을 들어본적이 있을것입니다. HTTP는 클라이언트(웹 브라우져나 앱)가 원하는 동작을 나타내는데 사용하는 몇가지 요청 메소드나 동사를 정의합니다.

GET : 웹 페이지 처럼 데이터를 검색하지만, 서버의 데이터는 변경하지 않습니다.
HEAD : GET과 동일하지만 헤더만 보내고 실제 데이터는 보내지 않습니다.
POST : 서버에 데이터를 보내며, 양식을 작성하고 제출(submit)하기를 클릭할때 일반적으로 사용됩니다.
PUT : 제공된 특정 위치로 데이터를 보냅니다.
DELETE : 제공된 특정 위치로부터 데이터를 삭제합니다.
REST 또는 REpresentational State Transfer은 일관된 설계에 대한 규칙 집합이며, 사용하기 쉽고 유지보수 가능한(maintainable) Web API 입니다. REST는 요청(request) 간에 상태를 지속하지 않으며, 요청 캐시 만들기, 균일한 인터페이스와 같이 몇가지 아키텍쳐 규칙이 있습니다. 요청에 대한 데이터 상테를 추적할 필요없이, 앱 개발자가 API를 쉽게 통합할 수 있습니다.

JSON은 JavaScript Object Notation의 약어입니다. 두 시스템간에 전송하는 데이터에 대해 사람이 읽을수 있고 이동하기 쉬운 메커니즘을 제공합니다. JSON은 데이터 타입을 제한합니다 : string, boolean, array, object/dictionary, nill, number. 정수와 소수간에 구별하지 않습니다.

메모리에서 객체를 JSON 또는 그 반대로 변환하기 위한 몇가지 기본 선택사항이 있습니다: 기존JSONSerialization 클래스와 새로 추가된 JSONEncoder와 JSONDecoder클래스가 있습니다. 게다가, JSON 처리에 도움이 되는 많은 타사(third part) 라이브러리가 있습니다. 이 튜토리얼에서는 그것들중 하나인, SwiftJSON을 사용할 것입니다.

HTTP, REST, JSON의 조합은 개발자로서 사용가능한 웹서비스의 많은 부분을 차지합니다. 어떻게 작은 부분이 대부분을 압도할 수 있는지 이해하려고 노력합니다. Alamofire와 같은 라이브러리는 이런 서비스 작업의 복잡성을 줄이는 데 도움이 될 수 있고, 그것들의 도움 없이 더 빨리 처리할 수 있습니다.



출처: https://kka7.tistory.com/98 [때로는 까칠하게..]


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

> ParameterEncoding

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

- `.methodDependent` : 메소드에 따라 인코딩 타입이 자동으로 결정된다. 간혹 GET 방식이면 `.queryString` POST 방식이면 `.httpBody` 가 적용되는 식이다.
- `.queryString` : GET 전송 에서 사용되는 쿼리 슻트링 방식으로 인코딩
- `.httpBody` : POST 전송에서 사용되는 HTTP Body 방식으로 인코딩












