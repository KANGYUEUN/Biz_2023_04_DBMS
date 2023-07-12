# spring server Application File Upload
- HTML 에서 파일을 선택하여 Server로 업로드를 할때, form 에서 POST 방식으로 업로드를 한다.
- 원래 form에서 Server로 보내는 데이터는 Text 데이터다.
- 이 Text data 는 http 프로토콜의 Body(payload)에 담겨서 encoding  이 되어 전송된다.
- form 에서 `type="file"` 형식의 input tag를 이용하여 BTN 파일을 업로드 하면 데이터라 body 담기고 encoding 이 되는데
이 과정에서 Bin 파일이 깨져 버린다.
- 그래서 HTML에서는 form 의 전송되는 데이터에 새로운 규격을 추가 했다. Text type 의 데이터와 None Text type 데이터를 같이 
묶음으로 하여 Server 로 전송할 수 있도록 form 에 속성을 추가 하였다.
- form 에 `type="file"` 속성이 있는 input tag 가 있으면 form tag 에 `enctype="multipart/form-data"` 라는 속성을 첨가 해야 한다.
- form `enctype="multipart/form-data"` 라는 속성이 첨가 되어 있으면 HTML 데이터를 전송하는 http 프로토콜이 종전의 form 데이터를 전송하는 방법과 달리 작동한다.
- form 의 `enctype="multipart/form-data"`는 text data와 None text data 를 하나의 프로토콜 payload 에 묶어서 보내는 Html 의 규격이다. 

## Spring Controller 에서 multipart/form-data 받기
- Spring Controller 는 form 에서 전달되는 모든 데이터를 Text 로만 인식한다.
- form 에서 아무리 `multipart/form-data` 형식으로 데이터를 보내도 Spring Controller 에서는 그러한 데이터를 수신(인식) 하지 못한다.
- Spring Project 에서 파일 업로드 기능을 구현 하기 위해서는 다음의 2가지 Deprndecies를 설치.
```xml
<!-- https://mvnrepository.com/artifact/commons-fileupload/commons-fileupload -->
		<dependency>
			<groupId>commons-fileupload</groupId>
			<artifactId>commons-fileupload</artifactId>
			<version>1.5</version>
		</dependency>

		<!-- https://mvnrepository.com/artifact/commons-io/commons-io -->
		<dependency>
			<groupId>commons-io</groupId>
			<artifactId>commons-io</artifactId>
			<version>2.13.0</version>
		</dependency>
```