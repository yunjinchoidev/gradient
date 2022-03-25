# project5
### 프로젝트 기술 안내
* Spring MVC
* AJAX
* Gantt Chart
* Full-Calendar
* 칸반보드
* 다국어처리
* SMTP 메일 전송
* 채팅
* JSTL

### 프로젝트 소개
프로젝트 관리 시스템(PMS System)
계획, 조직, 관리하는 것을 도와주고 , 리소스 추산치를 만드는 시스템

### 구현 범위
![image](https://user-images.githubusercontent.com/59445197/160097556-e36235b6-8591-42db-82c9-82feb05a13ad.png)

### 프로젝트 기능
#### 주요 기능
![image](https://user-images.githubusercontent.com/59445197/160097369-3601e890-180d-43ef-88f5-49abe75f7a8c.png)

#### 리스크
1. 게시글 목록 화면
* 페이징 처리 - 상단의 게시글 수 Select Box의 값과 일치하게 페이징 처리
* 검색 처리 - 프로젝트명, 리스크, 작성일, 완료예정일, 중요도, 진행사항, 담당자를 기준으로 검색
* 전체 게시글 개수 - 검색 시에도 검색된 게시물 만큼 출력
* JSTL을 이용하여 분기 처리한 중요도 및 진행사항 처리
2. 등록
* 등록 버튼 클릭 시 출력되는 모달을 활용한 등록화면
* Select 쿼리를 통한 프로젝트 리스트를 SelectBox에 출력
* Session을 이용한 담당자 Insert 처리
3. 상세화면
* 작성자가 아닐 시 수정, 삭제 버튼 hide
* JSTL을 이용하여 분기 처리한 중요도와 진행도
* 답글 버튼 클릭 시 댓글 작성 form hide, 답글 작성 form show
* 댓글 기능 - 작성자가 아닐 시 댓글 삭제 버튼 hide
* 답글 기능 - 작성자가 아닐 시 댓글 답글 버튼 hide
4. 수정
* input value에 리스크 게시물에 해당되는 키 값을 조건으로 데이터를 가져와 할당
5. 삭제

#### 예산

### 프로젝트 역할
* 장훈주 - 예산-ALL, 리스크-ALL, 품질-품질평가, 인증서 발급

### 버전
1.0
