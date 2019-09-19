# AVFoundation  


AVFoundation은 애플의 미디어 프레임워크로 iOS,tvOS,macOS에서 사용된다. 시간 기반의 시청각 미디어 자료(동영상, mp3 오디오 파일 등)를 플레이하고 생성할 수 있는 프레임워크 중 하나이다. 이 프레임워크를 통해 미디어 파일을 조사하고 조작하는 것이 가능하다.  


<img width="700" alt="image" src="https://user-images.githubusercontent.com/33486820/65219721-19215100-daf4-11e9-866a-9ffa892b0b90.png">  

뿐만 아니라 HTTP Live Streaming을 통해 제공되는 원격 서버에 위치한 미디어 파일들까지 효과적으로 가져오고 제어할 수 있다.  

## AVAsset 이란?

- AVFoundation에서 미디어 자료를 표현하는 가장 대표적인 타입이다. 
- AVAsset은 오디오와 비디오 트랙, 제목, 길이, 자연스러운 영상 사이즈 등 다양한 **데이터 집합체**이다.
- 대부분의 미디어 파일 포맷을 지원 + HTTP Live Streaming(HLS)도 지원한다.

### AVAsset의 미디어 제어  

AVAsset은 다음과 같이 두가지 방법으로 미디어 데이터를 다루는 것을 간소화 시켜준다.  

1. AVAsset은 포멧으로 부터 독립되어 일관된 인터페이스를 제공하며 코덱 타입과 같은 포멧에 종속적인 부분은 프레임워크가 알아서 처리해 주고 개발자는 미디어를 재생에 관련한 코드를 작성하는 것에만 집중할 수 있다.  

2. 미디어 데이터의 위치(Location)에 상관 없이 URL을 통해 객체를 생성할 수 있다. 데이터가 local에 위치한다면 `Bundle`이나 파일 시스템의 URL을 통해 생성할 수 있고 리모트 저장소에 위치한다면 해당 URL을 통ㄹ해 생성할 수 있다.  


### AVAsset의 트랙 접근 

AVAsset은 AVAssetTrack이라는 트랙 객체들로 이루어져 있다. 이런 트랙들의 구성은 하나의 미디어 데이터에 대한 오디오 트랙, 비디오 트랙, 자막 트랙 등 미디어 데이터를 이루는 여러 타입의 트랙들로 구성되어있다. 이러한 AVAsset에는 `tracks`라는 프로퍼티가 존재하므로 각 트랙에 접근이 가능하다.  

![image](https://user-images.githubusercontent.com/33486820/65220008-c72cfb00-daf4-11e9-9251-3f443d714318.png)  

> AVAsset은 tracks 이라는 프로퍼티를 통해 3가지 트랙에 접근이 가능하다.  


### Creating an Asset  

AVAsset은 추상적인 클래스로 초기화 시에는 url을 사용해 AVAsset의 인스턴스가 아닌 AVURLAsset 타입의 인스턴스가 생성된다.


```swift
// init method
init(url URL: URL, options: [String : Any]? = nil)

// URL을 통해 객체 생성

let url = // Remote 나 Local Asset의 URL 
let asset = AVURLAsset(url: url)  
```  

### Creaing an Asset with options  

위 처럼 단순하게 URL을 사용해서만 객체를 생성할 수도 있지만 options라는 매개변수를 통해 해당 객체를 보다 정교하게 생성할 수 있다. 이 매개변수는 `Key-Value`의 딕셔너리 타입으로 다음과 같이 사용할 수 있다.  

```swift

let url: URL = // Remote 나 Local Asset의 URL 
let options = [AVURLAssetAllowsCellularAccessKey: false]
let aseet = AVURLAsset(url: url, options: options)

```  

- `AVURLAssetAllowCellualAccessKey` 속성은 와이파이가 아닌 셀룰러 데이터 환경에서 리모트 저장소에 있는 미디어 데이터를 사용할 것인지에 대한 옵션이다.  


### Preparing Assets for Use  

AVAsset의 객체의 프로퍼티를 통해 현재 미디어 데이터의 재생 가능 여부, 총 재생시간, 생성 날짜 그리고 메타 데이터등의 데이터들에 접근이 가능하다. 

> 주의할점

AVAsset 객체를 생성했다고 위에서 언급한 정보들에 대해 즉시 접근할 수 있다는 걸 의미하는 것은 아니다. 이렇게 생성된 직후 아직 채워지지 않은 값을 받아오기 위한 상황에서 현재 스레드를 멈추어 동기적으로 해당 값이 채워질 때까지 기다려 값을 가져오는 것보단 **Block에 정의한 Copletion handler를 통해 응답을 비동기 적으로 기다리는 방법이 더욱 적합하다.**  

`ladValuesAsynchronouslyForKeys: completionHandler:`를 통해 원하는 속성을 비동기적으로 받아올 수 있다.  

- 현재 재생이 가능한지 여부에 대한 데이터를 담고있는 `playable` 속성을 가져오는 코드이다.  














