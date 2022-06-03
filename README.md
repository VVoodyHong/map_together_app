### Windows 환경 설정

1. futter SDK 다운로드

    https://flutter-ko.dev/docs/get-started/install/windows

2. flutter SDK를 설치하고자 하는 위치에 이동

    **권한 상승이 필요한 디렉토리에는 설치 X**

    ex) C:\src\flutter (O)
        C:\Program Files (X)

3. PATH 설정

    시스템 환경 변수 설정에서 "설치된 경로\flutter\bin" 추가

4. cmd 실행
    ```
    flutter doctor // 누락된 작업 자동 체크
        - 4가지 내외 누락된 작업 나옴
        - Solution이 함께 제공 되므로 절차에 맞춰 해결
        - 플러그인 인스톨 작업은 아래 참조

    flutter pub get // 앱에 패키지 추가하기
    ```

### Mac 환경설정

1. futter SDK 다운로드

    https://flutter-ko.dev/docs/get-started/install/macos

2. 환경변수 설정

    $ vi .bash_profile
    export PATH="$PATH:설치된 경로/flutter/bin" 입력
    $ :wq!

    flutter --version 입력으로 확인 가능
    *버전 확인이 안될 경우 시스템 환경설정 -> 보안 및 개인 정보 보호 -> 일반 -> [다음에서 다운로드한 앱 허용] 확인
     [App Store 및 확인된 개발자]로 변경하고 터미널에서 flutter --version 입력 후 허용 해주면됨

3. 터미널 실행
    ```
    flutter doctor // 누락된 작업 자동 체크
        - 4가지 내외 누락된 작업 나옴
        - Solution이 함께 제공 되므로 절차에 맞춰 해결
        - 플러그인 인스톨 작업은 아래 참조
    ```

4. 플러그인 인스톨

    flutter doctor 진단 후 누락된 작업 중 아래 작업 해결 방법
        Flutter plugin not installed;
        Dart plugin not installed;

    1)  android studio -> Configure -> plugin에서 flutter 설치 ( flutter 설치 시 dart 자동 설치 됨)
    2) cmd 실행

    ```
    flutter channel dev
    flutter upgrade
    flutter config --android-studio-dir="안드로이드 스튜디오 설치 경로"
    flutter doctor -v
    ```
    3)Xcode CocoaPods not installed. 오류 시 cocoapods 설치

    ```
    $ sudo gem install cocoapods
    $ pod setup
    ```

5. 터미널 실행
    ```
    flutter pub get // 앱에 패키지 추가하기
    ```


### model 생성 명령어

```
flutter packages pub run build_runner build
```

## 안드로이드 로컬 서버 접속

1. adb 위치로 이동
```
$ cd ~/Libarary/Android/sdk/platfrom-tools
```

2. 연결된 디바이스 리스트 확인
```
$ ./adb devices
```
- 리스트 중 연결된 디바이스만 있어야 연결 가능

3. 로컬 서버 포트로 연결
```
$ ./adb reverse tcp:8088 tcp:8088
8088
```

