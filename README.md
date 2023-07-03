# RF

## 규칙

### 브랜치 전략
![title](https://media.vlpt.us/images/yejine2/post/e6833c35-f4ff-493a-b5a2-b4cd82f91f13/git-flow.png)   
[이미지 출처](https://www.campingcoder.com/2018/04/how-to-use-git-flow/)

#### main 브랜치
- 기준이 되는 브랜치로 사용자에게 제품이 배포됨.
- main 브랜치에서 개발을 진행하면 안됨.

#### develop 브랜치
- develop 브랜치 위에서 자유롭게 개발자들이 작업. 
- develop 브랜치를 개발할 때는 feature 브랜치를 따서 feature 브랜치 위에서 작업.

#### hotfix 브랜치
- main 브랜치의 서브용으로 프로젝트를 긴급 수정해야할 때 사용하는 브랜치.
- 완료된 hotfix 브랜치는 하나는 main, 다른 하나는 develop 브랜치와 병합.

#### feature 브랜치
- 새로운 기능을 추가하는 브랜치로 develop 브랜치로부터 파생.
- 기능 추가 완료 후 develop 브랜치에 병합.

### 커밋 규칙
1) 커밋 메시지 제목에 타입을 표시

    ex) Type : Commit Message

2) 커밋 종류
    - feat 	: 새로운 기능 추가
    - fix 		: 버그 수정
    - docs 	: 문서 수정
    - style 	: 코드 formatting, 세미콜론(;) 누락, 코드 변경이 없는 경우
    - refactor : 코드 리팩토링
    - test 	: 테스트 코드, 리팩토링 테스트 코드 추가
    - chore 	: 빌드 업무 수정, 패키지 매니저 수정

