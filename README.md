# Priming
---
## Introduction


## Design

### Auto-layout
#### portrait mode
<img src = "https://raw.githubusercontent.com/ynebin/Priming/master/Screenshots/1.jpg" height="200">
#### landscape mode
<img src = "https://raw.githubusercontent.com/ynebin/Priming/master/Screenshots/2.jpg" height="200">

### Simple & Intuitive
<img src = "https://raw.githubusercontent.com/ynebin/Priming/master/Screenshots/1.jpg" height="200">
<img src = "https://raw.githubusercontent.com/ynebin/Priming/master/Screenshots/3.jpg" height="200">


## Data Import

## Timer & Input

## Information gathering
###HTTP
- 서버와 클라이언트 사이에 이루어지는 요청/응답 프로토콜

- ex) 클라이언트가 HTTP를 통하여 웹 서버로부터 웹페이지나</br> 그림 정보를 요청하면 서버는 이 요청에 응답하여 필요한 정보를</br> 해당 사용자에게 전달한다.

###Alamofire (https://github.com/Alamofire/Alamofire)

- Swift용 HTTP 네트워킹 라이브러리
- HTTP request를 더욱 간략하게 작성할 수 있음

- #####HTTP → Alamofire
<img src = "https://raw.githubusercontent.com/ynebin/Priming/master/Screenshots/HTTP.jpg" height="200">
<img src = "https://raw.githubusercontent.com/ynebin/Priming/master/Screenshots/Alamofire.jpg" height="200">

 

###Mailgun

- 개발자들을 위한 메일송신서비스를 제공하는 사이트

- Swift에서는 앱 사용자의 동의 없이 자동으로 메일을 전송할 수 없으므로 이 문제를 해결하기 위한 주된 방법이 mailgun을 사용하는 것

```
1. 메일을 보내는 코드를 짜면 (http request로 서버에 요청)
2. mailgun에서 그 요청을 받아들여
3. 원하는 메일을 보내준다 (실험 참가자의 응답을 전송한다.)
```

<img src = "https://raw.githubusercontent.com/ynebin/Priming/master/Screenshots/Mailgun.jpg" height="200">
 [이미지 출처] https://documentation.mailgun.com/quickstart-sending.html#how-to-start-sending-email

###HTTP request format
1) Request Line: mailgun에 data 전송을 원한다는 request를 명시

2) HTTP Header: 클라이언트와 서버 사이에서</br> 모든 종류의 정보를 전송하는데 이용되며</br> 크게 4가지로 분류할 수 있다.</br> 본 앱에서는 maligun을 통해 메일을 보내기 위해</br> **authentication** 과정이 필요했고</br> 따라서 API key 정보를 header에 넣어주었다.

```
* General - 클라이언트, 서버 또는 HTTP와 관계된 정보
* Request - 서버에 요청하는 정보
* Response - 서버의 응답 정보
* Entitiy - 클라이언트와 서버 사이에 전송되는 데이터에 대한 정보
```

3) Message Body (optional): 서버로 보낼 data 정보(발신자, 수신자, 메일 내용)를 담았다.