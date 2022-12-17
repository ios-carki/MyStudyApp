# ScreenShot

<img width="710" alt="스크린샷 2022-12-17 오전 3 22 40" src="https://user-images.githubusercontent.com/44957712/208163975-9e9618e8-1e70-42bd-a2d7-ffa7584b418c.png">

<img width="469" alt="스크린샷 2022-12-17 오전 3 27 07" src="https://user-images.githubusercontent.com/44957712/208164674-f3a86026-b4ed-4b23-ac9f-b794d8027f44.png">

* * *
# Issue

1. 회원가입 API Request
- Status Code 401 Error Handling
  - 만료된 User idToken

- 인터넷 미연결(Status Code: 501) - FCMtoken 값전달

- 토큰 갱신 로직 해결 필요

- 전 - 서버에 회원가입 요청을 보낸 뒤 만료된 토큰 Status Code 수신 시 토큰 갱신 코드 실행

- 예정 - 통신 전 만료된  토큰인지 분기처리 후 회원가입 통신으로 변경
