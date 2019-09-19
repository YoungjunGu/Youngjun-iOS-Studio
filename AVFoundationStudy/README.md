# AVFoundation  


AVFoundation은 애플의 미디어 프레임워크로 iOS,tvOS,macOS에서 사용된다. 시간 기반의 시청각 미디어 자료(동영상, mp3 오디오 파일 등)를 플레이하고 생성할 수 있는 프레임워크 중 하나이다. 이 프레임워크를 통해 미디어 파일을 조사하고 조작하는 것이 가능하다.  


<img width="745" alt="image" src="https://user-images.githubusercontent.com/33486820/65219721-19215100-daf4-11e9-866a-9ffa892b0b90.png">  

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

- 현재 재생이 가능한지 여부에 대한 데이터를 담고있는 `playable` 속성을 가져오는 코드

```swift

        guard let url = Bundle.main.url(forResource: "Ecstasy?", withExtension: "mp3") else {
            return
        }
        let asset = AVAsset(url: url)
        let playableKey = "playable"
        
        asset.loadValuesAsynchronously(forKeys: [playableKey]) {
            var error: NSError? = nil
            let status = asset.statusOfValue(forKey: playableKey, error: &error)
            switch status {
            case .loaded:
                // 성공적으로 데이터를 받아 왔을때
                break
            case .failed:
                // 실패했을 경우
                break
            case .cancelled:
                // 도중에 취소된, 중단된 경우
                break
            default:
                // 기타 다른 경우
                break
                
            }
        }
```

## Working with Metadata

포멧마다 메타데이터의 포멧 역시 다르기 떄문에 매우 까다롭다. AVFoundation은 이를 쉽게 다룰수 있는 `AVMetadataItem` 클래스를 제공한다.  
  
메타데이터 데이터들은 Key-Value의 형태로 짝을 이루고 있고 이를 통해 비디오나 영화의 제목이나 앨범의 커버 사진등을 가져올 수 있다.(Thumbnail)  



## Retrieving a Collection Metadata (Metadata 모음 검색)


`AVMetadataItem`을 효과적으로 사용하기 위해서는 AVFoundation이 메타데이터를 어떻게 구성하였는지를 이해해야한다. 메타데이터의 항목들을 쉽게찾고 필터링 하기 위해서는 AVFoundation은 관련된 메타데이터들을 `Key spaces` 로 묶어 관리한다.  


- Format-specific key spaces: 포멧별 포멧에 한정된 메타데이터를 묶어 놓은 것  
하나의 `AVAsset`의 메타데이터는 여러 포멧 key spaces에 분포되어 존재할 수 있다. 이렇게 여러 key spaces에 분포되어있는 하나의 AVAsset의 메타데이터들 집합은 `metadata` 속성을 통해 접근이 가능하다.  

- Common Key space: 포멧에 상관없이 공통으로 갖는 메타데이터들을 묶어 놓은 것  
영화 미디어 데이터라면 포멧에 상관없이 creation date와 description에 관한 메타데이터가 존재 할 것이다. 이들의 정보는 key spaces에 존재한다. `commonMetadata` 프로퍼티를 통해 접근이 가능하다.  


`availableMetadataFormats` 프로퍼티를 통해 AVAsset이 어떤 메타데이터의 포멧들을 갖고 있는지 알 수 있다.  
이 메소드는 문자열 형태의 포멧별 **identifier** 배열을 반환한다. 이와함께 `metadataFormat` 메소드를 이용하여 identifier에 해당하는 메타데이터의 포멧의 메타데이터를 가져 올 수 있다.  

- 현재 재생이 가능한 metadata에서 데이터를 가져오는 코드  


```swift
        guard let url = Bundle.main.url(forResource: "Ecstasy?", withExtension: "mp3") else {
            return
        }
        let asset = AVAsset(url: url)
        let formatsKey = "availableMetadataFormats"
        
        asset.loadValuesAsynchronously(forKeys: [formatsKey]) {
            var error: NSError? = nil
            let status = asset.statusOfValue(forKey: formatsKey, error: &error)
            if status == .loaded {
                // identifier를 배열 행태로 반환 하기 떄문에 for문을 통해 하나씩 metadata에 하나씩 접근해야한다.
                for format in asset.availableMetadataFormats {
                    let metadata = asset.metadata(forFormat: format)
                    
                }
            }
```  


## Finding and Using Metadata Values  


metadata collection에서 `AVMetadataItem`과 `identifier`를 통해 원하는 특정 메타데이터를 가져올 수 있다.  

```swift  

	let metadata = asset.commonMetadata
    let titleID = AVmetdataCommonIdentifierTitle
    let titleItems = AVMetdataItem.metadataItems(from: metadata, filteredByIdentifier: titleID)
    
    if let item = titleItems.first {
    	// title item 배열의 첫번째 항목
    }
```  

> AVMetdataItem 메소드는 메타데이터의 값을 컬렉션 형태로 반환한다. 이 컬렉션에 대부분 하나의 요소만 담겨있다. 하지만 미디어 데이터가 Localized 메타데이터나 CommonKeyspace에 분포되어 있는 메타데이터 혹은 여러 Keyspace에 존재하는 메타데이터를 가져오려 한다면 각각의 Local과 Keyspace에 맞는 값들을 모두 반환해 준다.  


metadataItem을 가져온 후 `value` 프로퍼티를 통해 해당 메타데이터의 실제 값에 접근 할 수 있다. 이렇게 반환되는 값은 `NSObject`를 상속받고 `NSCopying` 프로토콜을 따르고 있다. 그리고 이를 `.stringValue`, `.numberValue`, `.dateValue`, `.dataValue`등ㅇ의 프로퍼티를 이용해 원하는 타입으로 받아와 사용하면된다.  

- iTunes music track의 앨범 커버를 가져오는 코드

```swift
      // common metadata의 모음
      let metadata = asset.commonMetadata
      // 메타데이터 모음에서 해당하는 identifier의 metadata의 item을 가져온다.
      let artworkItems = AVMetadataItem.metadataItems(from: metadata,
      							filteredByIdentifier: commonIdentifierArtwork)
      if let artworkItem = artworkItems.first {
          // dataValue 프로퍼티를 사용 하여 값을 NSData로 강제 변환
          if let imageData = artworkItem.dataValue {
              let image = UIImage(data: imageData)
              // process image
          } else {
              // No image data found
          }
      }
```     

<br>

## Playing Media  

> Playback의 의미를 일종의 재생과 관련된 행위들이라고 이해하는 것이 편하다. 재생과 관련된 행위들이란 단순하게 시간 순서대로 재생하는 것 뿐만 아니라 녹음,녹화등의 행위도 포함되어있다.  


- `AVPlayer` : Asset의 전반적인 playback을 조적하는데 사용 
- `AVPlayerItem` : Asset의 Presentation state(현재 상태)를 관리하는데 사용
- `AVPlayerItemTrack` : Asset안 각각의 track의 Presentation state를 관리하는데 사용
- `AVPlayerLayer` : 영상을 출력하기 위해 사용  


- 미디어 데이터의 재생에 관련된 객체들의 관계도  

<img width="745" alt="image" src="https://user-images.githubusercontent.com/33486820/65246902-67514700-db2a-11e9-99ca-dcc3aab8205e.png">  


### AVPlayer  

`AVPlayer`객체는 미디어 데이터 재생에 핵심 클래스이다. 재생과 정지 그리고 특정 시간대로 이동하는 등의 재생에 전반적인 것을 관리힌다.  

> AVPlayer는 한번에 하나의 미디어 데이터만 재생할 수 있다. AVFoundation은 여러 미디어 데이터를 순서대로 재생하는 AVQueuePlayer 클래스도 제공한다.  


AVPlayerItem

또한 AVPlayer는 현재 재생 중인 미디어 데이터에 대한 상태 정보를 제공하므로 이를 바탕으로 해당 정보에 맞추어 UI를 동기화 작업도 가능합니다. 이런 동기화 작업의 대표적인 예는 바로 player 의 출력물을 AVPlayerLayer 혹은 AVSynchronizedLayer 와 같은 Core Animation Layer를 통해 보여주는 작업이 있다.

### AVAsset vs AVPlayerItem  

- AVAsset : 총 재생 시간, 생성 날짜 등의 **정적(Static)** 한 영역만 모델링 하기 때문에 실질적인 미디어 데이터 재생에는 적합 하지 않다.
- AVPlayerItem: 할당된 미디어 데이터에 대한 Presentation state를 관리한다. 이를 활용하여 재생 중인 미디어 데이터의 현재 시간을 가져오거나 하는 **동적**인 데이터들을 사용할 수 있다.


또한 `AVPlayerItem` 안에는 `AVPlayerItemTrack` 객체들도 존재하는데 이들은 `AVPlayerItem` 객체가 갖고 있는 asset의 track들을 관리한다.

<img width="745" alt="image" src="https://user-images.githubusercontent.com/33486820/65248081-8f41aa00-db2c-11e9-9443-43743cdc8d27.png">  



다음 그림은 동일한 asset을 다른 AVPlayer 객체가 동시에 재생하고 있지만 서로 다른 랜더링 방법을 통해 서로 다른 결과물을 출력할 수 있다는 것을 묘사하고 있다.

위에서 언급한 `AVPlayerItem` 안의 `AVPlayerItemTrack` 객체를 이용해 같은 asset이지만 track들을 조정해 밑의 예제와 같이 영상 미디어 데이터에서 video 트랙만 활성화시키고 audio 트랙은 비활성화시키는 등의 편집이 가능하다.

<img width="745" alt="image" src="https://user-images.githubusercontent.com/33486820/65248242-d5970900-db2c-11e9-8aba-13272e6b0f79.png">  


이런 `AVPlayerItem` 객체는 로컬에 존재하는 미디어 데이터를 이용하여 생성할 수도 있지만 서버와 같이 다른 곳에 위치하는 미디어 데이터 역시 URL을 통해 생성할 수 있다.

`AVAsset`과 마찬가지로 `AVPlayerItem` 객체를 생성했다고 그 즉시 바로 사용할 수 있는 것은 아니다. 항상 생성한 후 객체의 **status 프로퍼티를 활용해서 현재 사용할 준비가 되었는지를 확인**해주어야 한다.  



## AVKit and AVPlayerLayer  



`AVPlayer` 와 `AVPlayerItem` 은 **비시각적인 객체**로 그들 스스로 화면에 영상을 출력하지 못한다. 그렇기 때문에 이들을 화면에 출력시킬 수 있는 두가지 옵션이 있다..

- `AVKit` : 가장 좋은 방법은 AVKit 프레임워크를 활용하는 건데 iOS나 tvOS에선 AVPlayerViewController 를 macOS에선 AVPlayerView 를 사용하는 것 이다. 이 객체들은 비디오 컨텐츠를 보여주고 재생에 관련된 모든 기능들이 완벽하게 구현되어 제공된다.

- `AVPlayerLayer`: 비디오 컨텐츠를 재생하는 플레이어를 커스터마이징 하여 여러 기능들을 직접 추가하여 만들고 싶다면 AVFoundation에서 제공하고 Core Animation의 CALayer 를 상속받은 AVPlayerLayer를 사용하면 된다. 이는 재생에 관련된 어떠한 기능도 제공되지 않고 오직 화면 출력 기능만을 제공하기 때문에 미디어 재생에 관한 기능들은 직접 모두 구현해주어야 한다.  


## Setting Up the Playback Objects  


```swift
      class PlayerViewController: UIViewController {

          @IBOutlet weak var playerViewController: AVPlayerViewController!

          var player: AVPlayer!
          var playerItem: AVPlayerItem!

          override func viewDidLoad() {
              super.viewDidLoad()

              // 1) URL 주소 정의
              let url: URL = // URL to local or streamed media

              // 2) Asset 객체 생성
              let asset = AVAsset(url: url)

              // 3) 해당 Asset으로 Player Item 생성 -> 동적인 데이터 사용하기 위해 AVPlayerItem 사용
              playerItem = AVPlayerItem(asset: asset)

              // 4) Player 객체 생성
              player = AVPlayer(playerItem: playerItem)

              // 5) Associate player with view controller
              playerViewController.player = player
          }
      }
```   

객체가 생성되면 `AVplayer` 의 `play` 메소드를 통해 재생을 시작할 수 있다. `AVPlayer` 와 `AVPlayerItem` 은 재생할 미디어 데이터가 준비되었을 때 재생을 시작하는 많은 방법들들을 제공한다.  


## Observing Playback State  


`AVPlayer`와 `AVPlayerItem`은 그 상태가 지속해서 변하는 **동적인 객체**이다. 이러한 상태에 따른 액션을 정의해주기 위해서는 **KVO 기법**([gaki iOS-Studio : KVO](https://github.com/gaki2745/Youngjun-iOS-Studio/tree/master/KeyValueObserving)을 사용한다.  
KVO 기법은 한 객체로 하여금 다른 객체의 상태를 관찰하는 행위를 가능하게 한다. 이러한 KVO 기법을 사용한다면 AVPlayer와 AVPlayerItem의 상태 변화를 감지하고 이에 대응하는 행위를 쉽게 정의할 수 있다.  


`AVPlayerItem` 의 프로퍼티 중 변화를 감지해야 하는 중요한 프로퍼티는 바로 `status`이다. status는 현재 플레이어의 미디어 데이터가 재생할 준비가 되어있는지를 판단할 때 사용한다. `AVPlayerItem`을 생성한 직후에는 이 status 프로퍼티의 값은 `AVPlayerItemStatusUnknown` 으로 재상할 미디어 데이터를 아직 온전히 불러오지 못하였다는 뜻이고 재생할 준비가 되어있지 않다는 의미이다. 재생할 준비가 다 되면 status의 값은 `AVPlayerItemStatusReadyToPlay`로 변경됩니다.

- `AVPlayerItemStatusUnknown` or `AVPlayerItemStatusReadyToPlay`로 변경을 감지하는 코드

```swift
      let url: URL = // Asset URL
      var asset: AVAsset!
      var player: AVPlayer!
      var playerItem: AVPlayerItem!
      private var playerItemContext = 0 // Key-value observing context
      let requiredAssetKeys = ["playable", "hasProtectedContent"]

      func prepareToPlay() {
          // Create the asset to play
          asset = AVAsset(url: url)

          // Create a new AVPlayerItem with the asset and an
          // array of asset keys to be automatically loaded
          playerItem = AVPlayerItem(asset: asset, automaticallyLoadedAssetKeys: requiredAssetKeys)

          // player item status의 변화를 감지
          playerItem.addObserver(self,
                                 forKeyPath: #keyPath(AVPlayerItem.status),
                                 options: [.old, .new],
                                 context: &playerItemContext)

          // Associate the player item with the player
          player = AVPlayer(playerItem: playerItem)
      }
```  
<br>

`prepareToPlay` 메소드는 status 프로퍼티 값의 변화를 감지하기 위해 `addObserver(_:forKeyPath:,options:,context:)` 메소드를 사용해 Observer를 `AVPlayerItem` 객체에 등록한다. 이런 **Observer를 등록하는 행위는 AVPlayerItem 과 AVPlayer 를 연결시키기 전에 이루어져야 한다**.  

<br>

그리고 status 값의 변화를 전달 받기 위해서는 `observeValueForKeyPath(forKeyPath:, of:, change:, context:)` 메소드를 구현해야한다. 이 메소드는 status가 변하면 언제든지 호출되기 때문에 이 메소드 안에 값의 변화에 대응하는 액션을 정의해주면 된다.(callback 함수)  


```swift
      override func observeValue(forKeyPath keyPath: String?,
                                 of object: Any?,
                                 change: [NSKeyValueChangeKey : Any]?,
                                 context: UnsafeMutableRawPointer?) {

          // Only handle observations for the playerItemContext
          guard context == &playerItemContext else {
              super.observeValue(forKeyPath: keyPath,
                                 of: object,
                                 change: change,
                                 context: context)
              return
          }

          if keyPath == #keyPath(AVPlayerItem.status) {
              let status: AVPlayerItemStatus
              if let statusNumber = change?[.newKey] as? NSNumber {
                  status = AVPlayerItemStatus(rawValue: statusNumber.intValue)!
              } else {
                  status = .unknown
              }
              // Switch over status value
              switch status {
              case .readyToPlay:
                  // Player item is ready to play.
              case .failed:
                  // Player item failed. See error.
              case .unknown:
                  // Player item is not yet ready.
              }
          }
      }
```  


## Performing Time-Based Operations  


미디어 재생은 시간에 기반한 작업으로 `AVPlayer`와 `AVPlayerItem` 의 주요 기능과 특징들은 이러한 미디어의 시간대를 조절하는 것과 연관되어 있다. 이러한 기능들을 효과적으로 사용하기 위해서는 시간이라는 것이 `AVFoundation`에서 어떻게 표현되고 있는지를 이해해야 한다.

<br>

`AVFoundation`의 일부를 포함한 애플의 프레임워크에서 시간은 부동소수점의 `NSTimeInterval` 값으로 표현되며 이는 초를 나타낸다. `NSTimeInterval`로 표현된 시간들은 대부분 용도에 맞게 자연스레 사용이 되지만 부동소수점의 부정확성으로 인해 디테일한 시간의 작업이 필요한 미디어 재생에서는 문제점을 발생시킵니다.

이러한 부동소수점의 부정확성을 해결하고자 AVFoundation은 시간을 Core Media 프레임워크의 `CMTime` 타입을 이용해 표현한다.  
<br>

Core Media는 low-level의 C 프레임워크다. 대부분의 기능을 AVFoundation 같이 애플의 High-level 프레임워크의 인터페이스를 통해 사용한다. 하지만 CMTime은 Core Media를 통해 직접적으로 다룰 수 있는 구조체 데이터 타입이다.

<br>

```swift
public struct CMTime {
    public var value: CMTimeValue
    public var timescale: CMTimeScale
    public var flags: CMTimeFlags
    public var epoch: CMTimeEpoch
}
```  


이 구조체는 유리수나 분수의 형태로 시간을 표현한다. CMTime 구조체의 속성 중 가장 중요한 속성들은 `value`와 `timescale` 속성이다. 

<br>

- CMTimeValue : 64 비트 정수로 분수로 표현되는 시간의 분자 값을 정의
- CMTimeScale : 32비트 정수로 분모 값을 정의  


> CMTime 을 활용하여 미디어 재생에 사용되는 시간을 보다 쉽게 구현할 수 있다.

<br>

```swift
      // 0.25 seconds
      let quarterSecond = CMTime(value: 1, timescale: 4)

      // 10 second mark in a 44.1 kHz audio file
      let tenSeconds = CMTime(value: 441000, timescale: 44100)

      // 3 seconds into a 30fps video
      let cursor = CMTime(value: 90, timescale: 30)
```  

<br>


## Observing Time (미디어 재생 시간 변화 관찰)


대게 미디어의 현재 재생 시간을 관찰하는 행위는 미디어가 재생됨에 따라 UISlider를 갱신시켜주는 등의 UI를 갱신을 목적으로 한다. 이러한 지속적인 변화를 관찰하는 행위를 KVO 기법으로 하는 것은 부적합하다. AVPlayer는 미디어 재생의 시간 변화를 관찰하는 방법 두 가지를 제공하는데 그것이 바로 `Periodic Observation`과 `Boundary Observation`이다.

<br>

## Periodic Observation  


`addPeriodicTimeObserver(forInterval:queue:using:)` 메소드를 이용하면 일정한 주기의 시간 변화를 관찰할 수 있으며 이는 미디어의 재생 시간이 진행되는 것을 보여주는 UI를 갱신하는데 주로 사용한다. 이 메소드는 일정한 주기의 시간을 나타내는데 CMTime을 사용하고 해당 주기마다 실행되어야 하는 액션들을 Block 안에 정의해준다.

<br>

```swift
      var player: AVPlayer!
      var playerItem: AVPlayerItem!
      var timeObserverToken: Any?

      func addPeriodicTimeObserver() {
          // Notify every half second
          let timeScale = CMTimeScale(NSEC_PER_SEC)
          let time = CMTime(seconds: 0.5, preferredTimescale: timeScale)
          timeObserverToken = player.addPeriodicTimeObserver(forInterval: time,
                                                             queue: .main) {
              [weak self] time in
              // update player transport UI
          }
      }

      func removePeriodicTimeObserver() {
          if let timeObserverToken = timeObserverToken {
              player.removeTimeObserver(timeObserverToken)
              self.timeObserverToken = nil
          }
      }
``` 

<br>

## Boudary Observations  


시간을 관찰하는 다음 방법은 `addBoundaryTimeObserver(forTimes:queue:using:)` 메소드를 사용하는 것이다. 이 방법은 미디어의 전체 재생 타임라인 중에 원하는 시간대에 일어났으면 하는 행위들을 정의할 때 사용한다. 이 메소드는 액션이 발생하기를 원하는 시간대를 배열의 형태로 받고 원하는 액션을 Block안에 정의해준다.  

<br>

```swift
      var asset: AVAsset!
      var player: AVPlayer!
      var playerItem: AVPlayerItem!
      var timeObserverToken: Any?

      func addBoundaryTimeObserver() {

          // Divide the asset's duration into quarters.
          let interval = CMTimeMultiplyByFloat64(asset.duration, 0.25)
          var currentTime = kCMTimeZero
          var times = [NSValue]()

          // Calculate boundary times
          while currentTime < asset.duration {
              currentTime = currentTime + interval
              times.append(NSValue(time:currentTime))
          }

          timeObserverToken = player.addBoundaryTimeObserver(forTimes: times,
                                                             queue: .main) {
              // Update UI
          }
      }

      func removeBoundaryTimeObserver() {
          if let timeObserverToken = timeObserverToken {
              player.removeTimeObserver(timeObserverToken)
              self.timeObserverToken = nil
          }
      }
```

<br>

## Seeking Media

재생을 통해 미디어를 시간 순서에 따라 시청하고 듣는 것 이외에도 많은 사용자들이 원하는 시간대로 이동하여 특정 부분부터 혹은 특정 부분만을 즐기는 경우도 많다. 이러한 행위를 Seeking이라하며 AVPlayer와 AVPlayerItem은 이러한 기능을 가능케하는 메소드들을 제공한다.

<br>  

가장 흔한 방법은. `seek(to:)` 메소드를 사용하는 것으로 원하는 목적지 시간대의 CMTime 을 다음과 같이 넘겨주면 된다.

<br>


```swift	
      // Seek to the 2 minute mark
      let time = CMTime(value: 120, timescale: 1)
      player.seek(to: time)
```  

<br> 

`seek(to:)` 메소드를 이용하면 편리하고 빠르게 원하는 시간대로 이동할 수 있다. 하지만 이 메소드는 정확성보다는 신속함에 맞추어진 메소드이다. 이 뜻은 즉, **개발자가 원하는 시간대와 실제 플레이어가 이동하는 시간대가 다를 수 있다는 것**이다.  

<br>

보다 정교한 Seeking 동작을 원한다면 `seek(to:toleranceBefore:toleranceAfter:)`를 통해 허용되는 시간 편차를 지정할 수 있다. 아주 정교하게 Seeking 작업을 원한다면 허용되는 시간 편차에 0 값을 지정해주면 된다.  

<br>

```swift
      // Seek to the first frame at 3:25 mark
      let seekTime = CMTime(seconds: 205, preferredTimescale: Int32(NSEC_PER_SEC))
      player.seek(to: seekTime, toleranceBefore: kCMTimeZero, toleranceAfter: kCMTimeZero)
```


> 중요! seek(to:toleranceBefore:toleranceAfter:) 메소드에 허용되는 편차 값을 너무 작게 지정하게 되면 추가적인 디코딩 지연에 빠질 수 있으며 이는 앱의 Seeking 작업에 영향을 미친다.


<br>

<hr>


## Reference  


- [AVFoundation Programming Guide](https://developer.apple.com/library/archive/documentation/AudioVideo/Conceptual/MediaPlaybackGuide/Contents/Resources/en.lproj/ExploringAVFoundation/ExploringAVFoundation.html#//apple_ref/doc/uid/TP40016757-CH4-SW1)

- [Media Playback Programming Guide](https://developer.apple.com/library/archive/documentation/AudioVideo/Conceptual/AVFoundationPG/Articles/02_Playback.html)

    














