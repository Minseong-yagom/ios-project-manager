# 프로젝트 관리 앱
> 리뷰어: [개굴](https://github.com/yoo-kie)
## 앱 소개
프로젝트를 (해야 할 일, 진행 중인 일, 끝낸 일) 3가지로 나누어 관리하는 앱 입니다.

## 개발자
|iOS|
|:---:|
|[Minseong](https://github.com/Minseong-yagom)|
|<img width="150" src="https://avatars.githubusercontent.com/u/94295586?v=4"/>|

## 프로젝트 기간
> 2022.07.04(월) ~ 07.29(금)
---
## 외부라이브러리
<img src="https://img.shields.io/badge/SwiftLint-F05138?style=flat-square&logo=swift&logoColor=white"/> <img src="https://img.shields.io/badge/Realm-39477F?style=flat-square&logo=realm&logoColor=white"/>
### 외부라이브러리 선택 이유
**SwiftLint**

다른 iOS개발자들과 기본적인 코딩컨벤션을 맞추기 위해 사용하였습니다.

**Realm**

아래와 같은 이유로 사용하였습니다.
- SQLite와 같이 오픈소스며, 모바일에 최적화된 라이브러리
- SQLite, CoreData 보다 속도가 빠르고 성능면에서 더 우수
- 많은 작업들을 처리하기 위해 코드가 많이 필요하지 않음, 메인 스레드에서 데이터의 읽기, 쓰기 작업을 모두 할 수 있기 때문에 보다 편리
- 대용량의 데이터 무료로 사용가능, 용량의 적고 큼에 상관없이 속도와 성능이 유지
---
## 목차
[**1. 프로젝트 구조**](#프로젝트-구조)  
[**2. 실행화면**](#실행화면)  
[**3. 고민한점**](#고민한점)  
[**4. 트러블 슈팅**](#트러블-슈팅)  
[**5. 코드 리뷰**](#코드-리뷰)   
[**6. 키워드**](#키워드)  

---
## 프로젝트 구조
![](https://i.imgur.com/mQzncDt.png)


## 실행화면
|Home 화면|Project 추가|
|:---:|:---:|
|![](https://i.imgur.com/Gm3wcZY.gif)|![](https://i.imgur.com/kLSza4Y.gif)

|Project 추가취소|Project 수정|
|:---:|:---:|
|![](https://i.imgur.com/xIFRuD4.gif)|![](https://i.imgur.com/1HtWHgs.gif)|

|Proejct Category 이동|Project 삭제|
|:---:|:---:|
|![](https://i.imgur.com/yievs32.gif)|![](https://i.imgur.com/j4g60om.gif)|

---
## 고민한점
**Local DB(SQLite <span style="color:red">vs</span> CoreData <span style="color:red">vs</span> UserDefaults <span style="color:red">vs</span> Realm)**


---
### Realm
**장점**
- SQLite와 같이 오픈소스이며, 모바일에 최적화된 라이브러리
- SQLite, CoreData 보다 속도가 빠르고 성능면에서 더 우수
- 많은 작업들을 처리하기 위해 코드가 많이 필요하지 않음, 메인 스레드에서 데이터의 읽기, 쓰기 작업을 모두 할 수 있기 때문에 보다 편리
- 대용량의 데이터 무료로 사용가능, 용량의 적고 큼에 상관없이 속도와 성능이 유지
- MongoDB Atlas 및 Device Sync를 통한 에지-클라우드 동기화를 지원

**단점**
- 타사 라이브러리를 추가해야 하므로 앱 크기가 증가
- SQLite 및 Firebase에 비해 작은 커뮤니티

---
### 하위 버전 호환성에는 문제가 없는가?
|Realm| 
|:-:|
|XCode 13.1 이상|
|iOS 9 이상|
|Swift Package Manager를 통해 설치하는 경우 iOS 11 이상이 필요|

|iPhone|iPad|
|:---:|:---:|
|<img width="310px" src="https://i.imgur.com/A2mxBmX.png"/>|<img width="315px" src="https://i.imgur.com/ONrcGeB.png"/>|


iOS, ipadOS의 OS 점유율을 확인하였고
하위버전 호환성에 대한 문제가 큰 영향이 없을것이라 판단하였습니다.

---
### 안정적으로 운용 가능한가?
시장에서 증명된 것이라 안정적으로 운용이 될 것이라 판단하였습니다.

---
### 미래 지속가능성이 있는가?
Realm을 인수한 Mongo는 DB-engines에서 랭킹 5등에 위치하고 있고, 회사 규모가 크고 안정적이며 여러 회사를 인수하여 기능 업데이트 등을 많이하고 있는 것으로 보아 지속가능성이 있어보입니다.

---
### 리스크를 최소화 할 수 있는가? 알고있는 리스크는 무엇인가?
메인스레드를 이용하고 있는데 다른 스레드 접근 시 에러가 발생한다고 합니다.
사용할 때 쓰레드를 지정해줌으로써 위 리스크를 해결하는 것 같습니다.

---
### 어떤 의존성 관리도구를 사용하여 관리할 수 있는가?
Cocoapods을 이용하여 관리할 수 있습니다.

---
## 트러블 슈팅
1️⃣
realmDB에서 데이터를 가져와 cell을 구성하는 과정에서 cell이 구성이 안되는 문제가 발생하였다.
무엇이 문제인지 lldb로 계속 헤메다가 projects의 값이 nil인것을 발견
-> realmdata를 read하는 기능을 실행는 것을 빼먹은 것을 확인
> read실행 후 projects의 값이 잘 들어왔고 이후 cell구성을 해결하였다.
 
2️⃣
edit화면을 Present하는 과정에서
![](https://i.imgur.com/ZEsjWG6.png)
View 컨트롤러를 생성하고 editView를 구성하는 함수를 바로 호출하였다.
![](https://i.imgur.com/m18GyRY.png)
그 결과 IBOutlet nil 오류가 발생
![](https://i.imgur.com/mI3S6xw.png)
스토리보드에서 받아온 구성 정보로 만든 인스턴스가 IBOutlet에 연결되기 전 시점에 접근했기 때문에 문제가 생긴 것이였다.

> uuid 정보도 함께 생성자로 주입해준 후, viewDidLoad 시점에 configureEditView 함수를 호출하는 로직으로 변경해서 문제를 해결하였다.

### 3️⃣

![](https://i.imgur.com/OREKAFZ.png)

같은 Stack 안에 있는 cell CountLabel, TODOLabel의 높이가 같음으로써 CountLabel의 cornerRadius를 아무리 변경해도 동그라미가 안되는 문제가 발생

attribute가 fill이여서 높이가 자동으로 채워지는 것을 발견

>attribute center로 변경해서 문제를 해결하였다.
---
## 코드 리뷰

[STEP1](https://github.com/yagom-academy/ios-project-manager/pull/130), [STEP2](https://github.com/yagom-academy/ios-project-manager/pull/148), [STEP2-2](https://github.com/yagom-academy/ios-project-manager/pull/164)

---
## 키워드
- Cocoapod
- CollectionView
- Composition Layout
- Date Picker
- Popover
- Realm
- Storyboard
- SwiftLint
- TableView
- UICollectionView
- 스와이프를 통한 삭제
