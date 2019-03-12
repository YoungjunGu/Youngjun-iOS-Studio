# CoreLocation

CoreLocation은 주벼 iBeacon과 관련된 장치의 지리적 위치,고도,방향 또는 위치를 결정하는 서비스를 제공한다. 이 프레임워크는 Wi-Fi,GPS,블루투스,magnetometer(자력계),기압계 및 셀룰러 하드웨어를 포함한 모든 사용가능한 onboard HW를 사용하여 데이트를 수집한다.

> 사용자 위치 검색의 전반적인 흐름

![image](https://user-images.githubusercontent.com/33486820/54212468-53e37480-4526-11e9-9de0-afed0813078f.png)

## 사용자로부터 위치 권환 요청

사용자의 위치 데이터를 요청하기 전에 사용자의 위치 서비스 사용권한을 요청해야한다.


앱이 활성화되어있을때 `.requestWhenInUseAuthorization()` 을 호출하여 위치 데이터를 가져오거나 앱이 활성상태이거나 백그라운드에서 위치 데이터를 얻으려면 `.requestAlwaysAuthorization()`을 호출하여 할 수 있다.(Waze / Google지도가 backgorund 에있는 경우에도 위치 데이터를 계속 얻을 수있는 방법이다)


```swift
//앱이 사용중일 떄만 권한 요청
//사용자에게 앱을 실행 했을 때 alert box를 띄워준다.
locationManager.requestWhenInUseAuthorization()

//앱이 사용중일 때나 background 상황일때 권한 요청
locationManager.requestAlwaysAuthorization()
```

- Info.plist 에서 지정하는 방법

<img width="605" alt="스크린샷 2019-03-13 오전 12 31 27" src="https://user-images.githubusercontent.com/33486820/54213207-614d2e80-4527-11e9-9a91-24444e4fad5d.png">

![image](https://user-images.githubusercontent.com/33486820/54213244-71fda480-4527-11e9-86d1-0bcb4fe22589.png)


- 사용자가 '허용' 또는 '허용안함'을 탭하면 Delegate Method `didChangeAuthorization status`가 호출


```swift
extension ViewController : CLLocationManagerDelegate {
   
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("location manager authorization status changed")
    }
}
```

> 주의:  한 가지 주의해야 할 점은 delegate 메소드 (didChangeAuthorization 상태)는 사용자에게 권한 대화 상자가 표시되지 않은 경우에도 `locationManager.delegate = self` 행 다음에 항상 호출된다는 것


- 권한 부여 상태 handling


```swift
extension ViewController : CLLocationManagerDelegate {
    // called when the authorization status is changed for the core location permission
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("location manager authorization status changed")
        
        switch status {
        case .authorizedAlways:
            print("user allow app to get location data when app is active or in background")
        case .authorizedWhenInUse:
            print("user allow app to get location data only when app is active")
        case .denied:
            print("user tap 'disallow' on the permission dialog, cant get location data")
        case .restricted:
            print("parental control setting disallow location data")
        case .notDetermined:
            print("the location permission dialog haven't shown before, user haven't tap allow/disallow")
        }
    }
}
```

> 현재 승인 상태를 확인

```swift
let status = CLLocationManager.authorizationStatus()
```

사용자의 Device에서 `CLLocationManager.locationServicesEnabled()`를 사용하여 위치 서비스가 사용 설정되어있는지 확인해야 한다. 사용자가 위치 서비스 기능을 사용중지를 했음에도 앱에서 접근을 허용했을 수도 있다. 이런 경우 응용 프로그램에서 `kCLErrorDenied` 오류 코드와 함께 위치 데이터를 검색하려고 하면 Delegate Method `locationManager: didFailWithError:`가 호출된다.


## 사용자의 현재 위치 검색(Current Location)

위치 서비스 사용이 승인이 된 후 `locationManager.requestLocation()` (위치 데이터의 일회성 전송) 을 호출하여 위치를 요청하거나 `locationManager.startUpdatingLocation`을 사용하여 위치 업데이트 스트림을 진행할수 있다.

- `locationManager.requestLocation()` 

- `locationManager.startUpdatingLocation`


이 두방법 모두 iOS 장치에 현재 위치 데이터를 검색하도록 지시하고 위치 데이터가 검색되면 delegate method `didUpdateLocations locations:`가 호출된다.

> 차이점

- `.requestLocation()` 은 `didUpdateLocations locations:`를 한번만 호출 한다.

	- `requestLocation()` 흐름
    
    ![image](https://user-images.githubusercontent.com/33486820/54215545-76c45780-452b-11e9-8bfe-3d55c61044a3.png)
    
    - `didUpdateLocation locations: .reuqestLocation` 을 사용할때 한번만 호출
    - .requestLocation ()은 한 위치 만 didUpdateLocations 위치 배열에 전달한다.


- `.startUpdatingLocation locations`는 몇초마다 호출을 계속하거나 `locationManager.stopUpdatingLocation`를 호출하여 위치를 변경할 때까지 위치가 변경될 때마다 계속 호출한다.

	- `startUpdatingLocation()` 흐름
    
    ![image](https://user-images.githubusercontent.com/33486820/54215695-b4c17b80-452b-11e9-93aa-53a76bb92143.png)
    
    - `didUpdateLocations locations: locationManager.stopUpdatingLocation`을 호출 할 때까지 / 몇 초마다 위치 정보가 업데이트 될 때마다 호출한다.
    - `.startUpdatingLocation ()` 은 두 개 이상의 위치 didUpdateLocations 위치 배열에 전달할 수 있습니다 .
    








