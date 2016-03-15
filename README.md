# Priming
---

## Design

### Autolaout

### Simple & Intuitive

## Timer & inputs

## Information gathering
###HTTP
- 서버와 클라이언트 사이에 이루어지는 요청/응답 프로토콜
- ex) 클라이언트가 HTTP를 통하여 웹 서버로부터 웹페이지나 그림 정보를 요청하면 서버는 이 요청에 응답하여 필요한 정보를 해당 사용자에게 전달한다.



###Mailgun

- 개발자들을 위한 메일송신서비스를 제공하는 사이트

- swift에서는 앱 사용자의 동의 없이 자동으로 메일을 전송할 수 없으므로 이 문제를 해결하기 위해 주로 사용되는 방법이 mailgun을 사용하는 것

```
1. 메일을 보내는 코드를 짜면 (http request로 서버에 요청)
2. mailgun에서 그 요청에 따라
3. 원하는 메일을 보내줌(실험 참가자의 응답을 전송한다.)
```
###HTTP request
1. Request Line (mailgun에 data를 보내고 싶다는 request를 정의)
2. HTTP 헤더는 클라이언트와 서버 사이에서 모든 종류의 정보를 전송하는데 이용되며 크게 4가지로 분류할 수 있다. 본 앱에서는 maligun을 통해 메일을 보내기 위해
authentication 과정이 필요했고 따라서 API key 정보를 header에 넣어줬다.

* General - 클라이언트, 서버 또는 HTTP와 관계된 정보
* Request - 서버에 요청하는 정보
* Response - 서버의 응답 정보
* Entitiy - 클라이언트와 서버 사이에 전송되는 데이터에 대한 정보

### Others
* Message Body (optional): 서버로 보낼 data 정보(메일 정보: 발신자, 수신자, 메일 내용)를 담았음. 이 부분은 또한 request를 한 후의 서버에서 보낸 response 메시지 (보통 100 ~ 200 대는 good, 300대는 soso, 400대는 bad을 나타낸다.)를 보여줄 수도 있는 부분