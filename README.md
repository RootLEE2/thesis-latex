# POSTECH 학위논문 LaTeX 템플릿

POSTECH 「대학원 학위논문 작성 지침」 **2026년 4월 1일판**을 적용한 영문 학위논문 템플릿입니다. `thesis.tex`는 석사 예제이며, 같은 클래스에서 박사 양식도 사용할 수 있습니다. [작성 지침 PDF](guidelines/POSTECH-thesis-guidelines-2026-04-01.pdf) · [예제 PDF](thesis.pdf) · [반영 내역](FORMAT-NOTES.md)

최신 지침은 PODIUM에서 **더보기(···) → 규정집 → 제2편 학칙 → 제3장 학위수여규정 → D03-3-1~1**에서 확인할 수 있습니다. [PODIUM](https://podium.postech.ac.kr/) · [POSTECH 학술정보팀 제출 가이드](https://postechlibrary.github.io/thesis-guide/)

## Overleaf에서 사용

1. GitHub에서 저장소를 ZIP으로 내려받아 Overleaf의 **New Project → Upload Project**로 업로드합니다. 직접 묶을 때는 `thesis.tex`, `postech-ucs.cls`, `mybib.bib`, `latexmkrc` 네 파일을 ZIP의 최상위에 넣습니다.
2. 컴파일러를 **XeLaTeX**, 메인 문서를 **thesis.tex**로 설정합니다.
3. `thesis.tex`의 제목, 이름, 소속, 학번, 심사위원, 날짜와 본문을 교체하고 컴파일합니다. 제출용 PDF에는 지도교수와 심사위원의 실제 서명 또는 날인이 필요합니다.

## 문서 구성

`final` 옵션은 앞표지, 속표지, 제출승인서, 심사완료 검인서를 만듭니다. 초록은 1,000단어 이내로 작성합니다. 초록부터 로마 숫자로 매기며, 초록 다음 백색별지의 쪽번호는 표시하지 않습니다. 그림·표 목차가 필요하면 `\listoffigures`와 `\listoftables`의 주석을 해제합니다. 모든 목차 뒤에서 `\mainmatter`로 본문 1쪽을 시작합니다.

본문 뒤에는 국문요약, 참고문헌, 감사의 글, 이력서를 둡니다. 이력서에는 이름·학력·경력·학회활동을 기재합니다. 끝의 `\thesiscopyright`, `\label{paperlastpagelabel}`, `\thesisbackmatter`는 저작권 위임 문구, 초록의 본문 쪽수, 마지막 백색별지와 뒤표지를 처리합니다.

## 학위와 소속

- 석사는 `master`와 심사위원 세 명, 박사는 `doctor`와 심사위원 다섯 명을 지정합니다. `\referee[1]`이 위원장입니다.
- `\author[english]{Hong}{Gildong}`처럼 성과 이름을 입력하면 **Gildong Hong** 순서로 출력합니다. 한글 이름이 없으면 `\author[korean]{}{}`를 사용합니다.
- 예제는 `\department{CITE}{engineering}`을 사용합니다. 일반 학과 코드는 `MA`, `PH`, `CH`, `LS`, `MS`, `ME`, `IME`, `EE`, `CSE`, `CE`, `CITE`, `EV`, `GSAI`, `AMS`, `ANE`, `IBB`, `ST`, `FT`, `BE`입니다.
- 융합대학원 전공 코드는 `SDS`, `MED`, `DST`, `MSI`, `CFT`, `QIS`, `IDS`, `SYN`입니다. 이 중 `MSI`, `CFT`, `IDS`의 박사 코드는 4월 지침 참조 5에 제시되어 있지 않습니다.
- 소속을 직접 지정하려면 `\department` 다음에 `\departmentinfo{한글 명칭}{영문 소속명}{영문 전공명}{학위코드}`를 추가합니다. 참조 5와 13에서 실제 소속의 표기와 학위코드를 확인합니다.

## 로컬 빌드

TeX Live(ko.TeX, 은글꼴, TeX Gyre 포함)와 `latexmk`가 있는 환경에서 실행합니다.

```sh
latexmk -xelatex -interaction=nonstopmode -halt-on-error thesis.tex
```

`make`로도 빌드할 수 있습니다. `make clean`은 중간 생성 파일을 정리합니다.

클래스는 [Junshin Park의 POSTECH 학위논문 템플릿](https://github.com/lonelywing/POSTECH_thesis_template_latex)을 바탕으로 했으며, 원저자와 KAIST 템플릿의 기여를 클래스 파일에 기록했습니다.
