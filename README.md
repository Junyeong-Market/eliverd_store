[![Conventional Commits](https://img.shields.io/badge/Conventional%20Commits-1.0.0-yellow.svg)](https://conventionalcommits.org)
![Flutter CI](https://github.com/Junyeong-Market/eliverd_store/workflows/Flutter%20CI/badge.svg)
![Contributors](https://img.shields.io/badge/Contributors-Hoseung_Choi,_Unperknown,_GSM_Park-blue.svg)
![Github top language](https://img.shields.io/github/languages/top/Junyeong-Market/eliverd_store)
![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/Junyeong-Market/eliverd_store)

# 📦🐦❗🚚

Eliverd 플랫폼의 상점용 모바일 애플리케이션입니다.

## 📲 실행 방법

### 불러오기
```shell script
git clone https://github.com/Junyeong-Market/eliverd_store.git -b master
```

### 실행
```shell script
flutter pub get
flutter run
```

Android Studio, Intellij IDEA, VS Code 등의 IDE를 이용하면 더 편리하게 실행할 수 있습니다!

## 🏗️ 디자인

![상점용 Eliverd UI - 5/29](doc/images/running_app.gif)

## ✏️ 기여 방법

### 기능 구현인 경우

#### 1. Issue 생성하기

아래 메뉴얼에 따라서 구현할 기능에 필요한 백로그 리스트를 모두 Issue에 올립니다.

| Title | Labels | Assignees | Projects | Milestone |
|:-:|:-:|:-:|:-:|:-:|
| 구현할 기능 | backlog로 고정 | 기여에 참여하는 모든 사람 | Eliverd 스프린트 중 가장 최신 | Eliverd 스프린트 중 가장 최신 |

#### 2. Branch 생성하기

자신의 Github username과 구현할 기능에 대한 이름을 지어서 **`develop` Branch를 기반으로** `username/기능` 형식을 지켜 만듭니다.

*예시: Unperknown이 인증 절차 관련 기능을 구현할 때에 `unperknown/auth` Branch를 만든다.*

#### 3. Pull Request 만들기

반드시 아래 메뉴얼에 따라 PR를 남기고 나서 기능 구현을 진행하도록 합니다.

**주의: PR를 올릴 때 Base Branch는 반드시 `develop` Branch로 명시해야 합니다!**

| Title | Labels | Assignees | Reviewers | Projects | Milestone | Linked Issues |
|:-:|:-:|:-:|:-:|:-:|:-:|:-:|
| 구현한 기능에 대한 요약 | new feature로 고정 | 기여에 참여하는 모든 사람 | 최소한 Unperknown(개발 담당)은 포함해야 함 | 할당된 Eliverd 스프린트 | 할당된 Eliverd 스프린트 | 1번 과정에서 만든 모든 Issue(백로그) |

#### 4. 기능 구현하기

이 레포지토리에 참여하는 모든 기여자는 Conventional Commits를 준수해야 합니다. 이를 숙지하여 Commit 메시지를 작성하도록 합니다.

#### 5. 마무리하기

3번 과정에서 올린 PR에서 CI 통과 여부와 리뷰 결과에 따라서 Merge되면 기능 구현이 마무리됩니다.

### 그 외

Issue를 올려서 앞 경우를 제외한 기여를 할 수 있습니다(Pull Request로 요청하면 안됩니다). 아래 메뉴얼에 따라서 요청합니다.

| Title | Assignees |
|:-:|:-:|
| 요청할 사항 | 자기 자신 |

## 👪 기여자

### 준영이네 마트(Junyeong Market) 팀
- [🔗Hoseung Choi](https://github.com/startergate): 프로젝트 총괄(백엔드 API 구현)
- [🔗Unperknown](https://github.com/Unperknown): 모바일 앱 개발
- [🔗GSM Park](https://github.com/Parkjonghyo): 데스크탑 앱 개발


## 🗓 마일스톤

### 개발
#### 5/8(금) - 프로젝트 착수 👩‍💻👨‍💻
#### 5/18(월) - 1차 스프린트 마감1️⃣
#### 5/28(목) - 2차 스프린트 마감2️⃣
#### 6/7(일) - 3차 스프린트 마감3️⃣
#### 6/17(수) - 4차 스프린트 마감4️⃣
#### 6/27(토) - 5차 스프린트 마감5️⃣
#### 7/7(화) - 6차 스프린트 마감6️⃣
#### 7/8(수) - 산출물 시연(& 프리젠테이션) 👨‍🏫👩‍🏫

## License
 
The MIT License (MIT)

Copyright (c) 2020 준영이네 마트

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
