#도움이 될지 모르겠지만..
##HTTP
- 서버와 클라이언트 사이에 이루어지는 요청/응답 프로토콜

- ex) 클라이언트가 HTTP를 통하여 웹 서버로부터 웹페이지나 그림 정보를 요청하면 서버는 이 요청에 응답하여 필요한 정보를 해당 사용자에게 전달한다.

##기본 용어
- request: 클라이언트가 특정 사이트에서 데이터를 가져오거나 데이터를 그 사이트로 보내는 등의 행위를 하고 싶을 때,
서버에게 요청하는 것

- response: 서버에서 클라이언트의 request에 대해 클라이언트가 원하는 데이터를 가져오거나 request가 잘 처리되었는지, 잘 처리되지 못했다면 어떤 문제 때문인지 등을 알려주는 것

###HTTP의 기본 용어는 아니지만..
####Mailgun

- 개발자들을 위한 메일송신서비스를 제공하는 사이트

- swift에서는 앱 사용자의 동의 없이 자동으로 메일을 전송할 수 없으므로 이 문제를 해결하기 위해 주로 사용되는 방법이 mailgun을 사용하는 것

> 우리 코드의 경우
> 
1. 메일을 보내는 코드를 짜면 (http request로 서버에 요청)
2. mailgun에서 그 요청에 따라
3. 원하는 메일을 보내줌
 - 실험 참가자가 인풋을 작성한 후 실험 참가 버튼을 누를 때마다 인풋 정보를 담은 메일을 보내준다

##HTTP request 기본 서식

###1. Request Line

어느 사이트에 어떤 request를 하는지를 명시해주는 부분
>우리 코드의 경우
>
→ mailgun에 data(우리가 보낼 메일의 기본 정보)를 보내고 싶다는 request를 정의했음

###2 Header

- HTTP message headers are used to precisely describe the resource being fetched or the behavior of the server or the client.
- They provide required information about the request or response, or about the object sent in the message body.

> 우리 코드의 경우
> 
maligun을 통해 메일을 보내기 위해서는
authentication 과정이 필요하므로 <br>(자신이 mailgun을 쓰기에 적합한 사람이라는 걸 보여주는 것..?) <br>이 과정에서 필요한 API key 정보를 header에 넣어줌

###3 Message Body (optional하므로 없어도 됨)
- 우리 코드에서는 서버로 보낼 data 정보(메일 정보: 발신자, 수신자, 메일 내용)를 이 부분(body)에 담았음sork 
- 또한 request를 한 후의 서버에서 보낸 response 메시지를 보여줄 수 있는 부분

###+) Response Message
- request 이후에 서버에서 보낸 response message를 통해 <br>자신이 요청한 request가 잘 받아들여졌는지, <br>그렇지 않다면 그 문제가 무엇인지 등을 확인할 수 있음
- message body에서 response message를 print하도록 설정하면 <br>코드가 실행되었을 때 debug area에서 확인할 수 있음
<br>주로 request가 잘 받아들여지지 않았을 때 그 원인이 무엇인지를 찾기 위해 response message를 확인하는 경우가 많은 듯!