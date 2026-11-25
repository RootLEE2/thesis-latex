%% TeX: UTF-8
%%
%% POSTECH Thesis Template for LaTeX
%%
%% @version      0.10 (2026-04-01 graduate thesis guidelines)
%% @releasedate  Mar. 2021
%%
%% @author       Junshin Park 박준신
%%               mailto:lonelywing@postech.ac.kr
%%
%% @requirements
%%    current distribution of TeXLive
%%      + ko.TeX
%%
%% 본 템플릿은 학사관리팀의 지원으로 진행되었습니다.
%% 또한, 본 템플릿은 kaist latex Thesis template을 기반으로 작성되었음을 밝힙니다.
%% Sae Hee Ryu의 지원이 한 스푼 들어갔습니다.
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{postech-ucs}[2026/11/25 v0.10 Graduate thesis guidelines dated 2026-04-01]

%% 옵션 설정을 위한 boolean 변수선언
\newif\if@isDoctor
\newif\if@isKorean
\newif\if@isFinal
\newif\if@PDFdoc\@PDFdocfalse
\newif\if@dvips\@dvipsfalse

%% 새 옵션 모음 - doctor|master, korean|english, final|draft
\DeclareOption{doctor} {\@isDoctortrue}
\DeclareOption{master} {\@isDoctorfalse}
\DeclareOption{korean} {\@isKoreantrue}
\DeclareOption{english}{\@isKoreanfalse}
\DeclareOption{final}  {\@isFinaltrue}
\DeclareOption{draft}  {\@isFinalfalse}
\DeclareOption{pdfdoc} {\@PDFdoctrue}
\DeclareOption{dvips}  {\@dvipstrue}

%% leqno,fleqn,openbib 옵션은 그대로 report 클래스에 전달
\DeclareOption{leqno}  {\PassOptionsToClass{leqno}  {report}}
\DeclareOption{fleqn}  {\PassOptionsToClass{fleqn}  {report}}
\DeclareOption{openbib}{\PassOptionsToClass{openbib}{report}}

\ExecuteOptions{master,english,final}         % master,english,final이 기본값
\ProcessOptions

%% 11pt,onecolumn,oneside 옵션으로 report 클래스 불러오기
\RequirePackage{fix-cm} % Scale the math fonts when using exact DTP point sizes.
\LoadClass[11pt,onecolumn,oneside]{report} % ver0.3 : 본문 글자 크기 11pt


%%들여쓰기
\usepackage{indentfirst}

% Exhibit 1 uses HCR Batang. Exhibits 2--12 use Batang, with Gulim
% for the three CV subheadings. Local font files take precedence.
\newcommand*{\postech@coverfont}{}
\newcommand*{\postech@cvfont}{\sffamily}
\RequirePackage{iftex}
\ifPDFTeX
  \renewcommand{\rmdefault}{ptm}
  \RequirePackage[nonfrench]{dhucs}
  \ClassWarningNoLine{postech-ucs}{Use XeLaTeX for the fonts in the guideline illustrations}
\else
  \RequirePackage{fontspec}
  \RequirePackage{kotex}
  \setsanshangulfont{UnDotum.ttf}[BoldFont=UnDotumBold.ttf,AutoFakeSlant]
  \IfFileExists{fonts/batang.ttc}{%
    \setmainfont{batang.ttc}[Path=fonts/,AutoFakeBold,AutoFakeSlant]
    \setmainhangulfont{batang.ttc}[Path=fonts/,AutoFakeBold,AutoFakeSlant]
  }{%
    \IfFontExistsTF{Batang}{%
      \setmainfont{Batang}[AutoFakeBold,AutoFakeSlant]
      \setmainhangulfont{Batang}[AutoFakeBold,AutoFakeSlant]
    }{%
      \setmainfont{texgyretermes-regular.otf}[
        BoldFont=texgyretermes-bold.otf,ItalicFont=texgyretermes-italic.otf,
        BoldItalicFont=texgyretermes-bolditalic.otf]
      \setmainhangulfont{UnBatang.ttf}[BoldFont=UnBatangBold.ttf,AutoFakeSlant]
      \ClassWarningNoLine{postech-ucs}{Batang unavailable. Using TeX Gyre Termes and UnBatang}%
    }%
  }
  \IfFileExists{fonts/HANBatang.ttf}{%
    \newfontfamily\postech@hcrlatin{HANBatang.ttf}[Path=fonts/]
    \newhangulfontfamily\postech@hcrhangul{HANBatang.ttf}[Path=fonts/]
  }{%
    \IfFontExistsTF{HCR Batang}{%
      \newfontfamily\postech@hcrlatin{HCR Batang}
      \newhangulfontfamily\postech@hcrhangul{HCR Batang}
    }{%
      \ClassWarningNoLine{postech-ucs}{HCR Batang unavailable. Using the main fonts on the cover}%
    }%
  }
  \@ifundefined{postech@hcrlatin}{}{%
    \renewcommand*{\postech@coverfont}{\postech@hcrlatin\postech@hcrhangul}}
  \IfFileExists{fonts/gulim.ttc}{%
    \newfontfamily\postech@gulim{gulim.ttc}[Path=fonts/]
    \let\postech@cvfont\postech@gulim
  }{%
    \IfFontExistsTF{Gulim}{%
      \newfontfamily\postech@gulim{Gulim}
      \let\postech@cvfont\postech@gulim
    }{%
      \ClassWarningNoLine{postech-ucs}{Gulim unavailable. Using the sans-serif font in CV subheadings}%
    }%
  }
\fi
\RequirePackage{ifthen,refcount,graphicx,xcolor}
\RequirePackage[unicode,bookmarks=true,hidelinks]{hyperref}
\let\gt\sffamily
\DeclareTextFontCommand{\textgt}{\gt}

\AtBeginDocument{%                           % \begin{document}와 함께 실행
    \hypersetup{pageanchor=false}
    \checkparameters                        % 문서 변수가 올바른지 점검
    \if@isFinal                             % final 옵션이 지정되어 있으면
        \makefrontcover \maketitle         % 앞표지, 속표지 생성
        \makeapproval                      % 제출승인서, 심사완료검인 생성
    \else \fi }
\AtEndDocument{}                             % \end{document}와 함께 실행

%% Graduate thesis guidelines dated 2026-04-01, Exhibits 1 and 8.
% Body begins 20+15=35 mm from the top and ends 15+15=30 mm
% from the bottom. These totals reproduce the HWP header/footer areas.
\RequirePackage[paperwidth=210mm,paperheight=297mm,includeheadfoot,
  left=25mm,right=25mm,top=20mm,bottom=15mm,
  headheight=15mm,headsep=0mm,footskip=15mm]{geometry}
\RequirePackage{setspace}
% The guideline's point values are DTP points (1/72 in); TeX bp matches
% them. 11 bp at 170% gives 18.7 bp baseline-to-baseline.
\let\postech@reportsize\normalsize
\renewcommand*\normalsize{%
  \postech@reportsize
  \fontsize{11bp}{18.7bp}\selectfont}
\let\postech@reportfootnotesize\footnotesize
\renewcommand*\footnotesize{%
  \postech@reportfootnotesize
  \fontsize{9bp}{15.3bp}\selectfont}
\normalsize
\setlength\parindent{2em}
\newcommand{\blankpage}{\clearpage\null\thispagestyle{empty}\clearpage}
\newcommand{\mainmatter}{\clearpage\pagenumbering{arabic}\pagestyle{postech}}
\newcommand{\thesiscopyright}{%
  \par\vspace{2\baselineskip}\noindent
  본 학위논문 내용에 관하여 학술·교육 목적으로 사용할 모든 권리를
  포항공과대학교에 위임함.\par}
\newcommand{\thesisbackmatter}{%
  \clearpage\hypersetup{pageanchor=false}
  \blankpage % white endpaper required after CV
  \blankpage % plain back cover; spine/cover binding is handled by the printer
}

%% 본문이 영어로 되어있는지 한글로 되어있는지 설정
\newcommand{\@korean}{korean}
\newcommand{\@english}{english}
\newcommand{\@textlang}{}                    % 텍스트 기본언어 변수선언
\if@isKorean                                 % korean 옵션이 지정되어 있으면
    \let\@textlang\@korean                  % 텍스트 기본언어는 한글
\else                                        % english 옵션이 지정되어 있으면
    \let\@textlang\@english                 % 텍스트 기본언어는 영문
\fi

%% POSTECH 공식 영문명칭
\newcommand{\@postech}{Pohang University of Science and Technology}

%% pagestyle
\def\ps@postech{\let\@mkboth\@gobbletwo
     \let\@oddhead\@empty
     \def\@oddfoot{\reset@font\hfil-\ \thepage\ -
     \hfil}%
     \let\@evenhead\@empty\let\@evenfoot\@oddfoot
}

\pagestyle{postech}

%%
%% 문서 정보 변수 정의
%%

% @command title 논문 제목
% @options [default: (none)]
% - korean: 한글제목 | english: 영문제목
\renewcommand{\title}[2][korean] {%
    \ifthenelse{\equal{#1}{korean}}%
        {\newcommand{\@titleKor}{#2}}{}%
    \ifthenelse{\equal{#1}{english}}%
        {\newcommand{\@titleEng}{#2}}{}%
}
\@onlypreamble{\title}

% @command author 저자 이름
% @param family_name, given_name 성, 이름을 구분해서 입력
% @options [default: (none)]
% - korean: 한글이름 english: 영문이름
\renewcommand{\author}[3][korean] {%
    \ifthenelse{\equal{#1}{korean}}
        {\newcommand{\@authorKorFN}{#2}
         \newcommand{\@authorKorGN}{#3}
         \newcommand{\@authorKor}{#2\ #3}}{}%
    \ifthenelse{\equal{#1}{english}}
        {\newcommand{\@authorEngFN}{#2}
         \newcommand{\@authorEngGN}{#3}
         \newcommand{\@authorEng}{#3 #2}}{}%
}
\@onlypreamble{\author}

% @command advisor 지도교수 이름 (복수가능)
% @options [default: major]
% - major: 주 지도교수  | coopr: 부 지도교수 (공동지도교수 경우)
\newcommand{\advisor}[4][major]{%
    \ifthenelse{\equal{#1}{major}} {%       % 주 지도교수이면
        \newcommand{\@advisorMajorKor}{#2} % 한글이름 저장
        \newcommand{\@advisorMajorEng}{#3} % 영문이름 저장
        % nosign을 명시하지 않으면 주 지도교수가 서명한 것으로 간주
        \ifthenelse{\equal{#4}{nosign}}{}{%
            \newcommand{\@advisorSigned}{\@advisorMajorEng}} }{}%
    \ifthenelse{\equal{#1}{coopr}} {%       % 부 지도교수이면
        \newcommand{\@advisorCooprKor}{#2} % 한글이름 저장
        \newcommand{\@advisorCooprEng}{#3} % 영문이름 저장
        % signed를 명시해야 부 지도교수가 서명한 것으로 간주
        \ifthenelse{\equal{#4}{signed}}{%
            \newcommand{\@advisorSigned}{\@advisorCooprEng}}{} }{}%
}
\@onlypreamble{\advisor}

% @command department
%
\newcommand{\@degreeCode}{}             % 학위 영문코드
\newcommand{\@degreeName}{}             % 학위명
\newcommand{\@parentDeptNameKor}{}      % 학과/전공 첫째줄
\newcommand{\@childDeptNameKor}{}       % 학과/전공 둘째줄
\newcommand{\@parentDeptNameEng}{}      % 학과/전공 첫째줄
\newcommand{\@childDeptNameEng}{}       % 학과/전공 둘째줄
\newcommand{\@programDeptNameEng}{}     % 학위명
\newcommand{\@affFullNameKor}{}         % 학과/전공 한글이름
\newcommand{\@affFullNameEng}{}         % 학과/전공 영문이름
\newcommand{\@affFullNameEngCover}{}    % 학과/전공 영문이름(표지용)
\newcommand{\@degreeField}{}
\newcommand{\@degreePrefix}{\ifthenelse{\boolean{@isDoctor}}{D}{M}}
\newcommand{\postech@setdepartment}[4]{%
  \renewcommand{\@degreeCode}{\@degreePrefix #1}%
  \renewcommand{\@childDeptNameKor}{#2}%
  \renewcommand{\@childDeptNameEng}{#3}%
  \renewcommand{\@programDeptNameEng}{#4}}

\newcommand{\postech@convergencemajor}[3]{%
  \postech@setdepartment{#1}{융합대학원 #2 전공}%
    {Graduate School of Convergence Science and Technology (Major in #3)}{#3}}

% Department names and abstract codes from Exhibits 5 and 13.
\@namedef{postech@dept@SDS}{\postech@convergencemajor{SDS}{소셜데이터사이언스}{Social Data Science}}
\@namedef{postech@dept@MED}{\postech@convergencemajor{MED}{의과학}{Medical Science and Engineering}}
\@namedef{postech@dept@DST}{\postech@convergencemajor{DST}{국방과학기술}{Defense Science and Technology}}
\@namedef{postech@dept@MSI}{\postech@convergencemajor{MSI}{경영과학}{Management Science}}
\@namedef{postech@dept@CFT}{\postech@convergencemajor{CFT}{푸드테크융합}{Convergence Food Technology}}
\@namedef{postech@dept@QIS}{\postech@convergencemajor{QIS}{양자정보과학}{Quantum Information Science}}
\@namedef{postech@dept@IDS}{\postech@convergencemajor{IDS}{산업데이터사이언스}{Industrial Data Science}}
\@namedef{postech@dept@SYN}{\postech@convergencemajor{SYN}{합성생물학}{Synthetic Biology}}
\@namedef{postech@dept@ST}{\postech@setdepartment{ST}{반도체대학원}%
  {Graduate School of Semiconductor Technology}{Semiconductor Technology}}
\@namedef{postech@dept@FT}{\postech@setdepartment{FT}{친환경소재학과}%
  {Graduate Institute of Ferrous \& Eco Materials Technology (Department of Ferrous \& Eco Materials Technology)}%
  {Ferrous \& Eco Materials Technology}}
\@namedef{postech@dept@BE}{\postech@setdepartment{BE}{배터리공학과}%
  {Graduate Institute of Ferrous \& Eco Materials Technology (Department of Battery Engineering)}%
  {Battery Engineering}}
\@namedef{postech@masteronly@MSI}{}
\@namedef{postech@masteronly@CFT}{}
\@namedef{postech@masteronly@IDS}{}

% https://postech.ac.kr/admission-education/graduate/ 정보 및 순서를 따름
\newcommand{\department}[2] {%
    \if@isDoctor
      \@ifundefined{postech@masteronly@#1}{}{%
        \ClassError{postech}{No doctoral degree code is listed for #1}
          {Check Exhibit 5 of the graduate thesis guidelines.}}%
    \fi
    \@ifundefined{postech@dept@#1}{}{\@nameuse{postech@dept@#1}}%
    \renewcommand{\@degreeField}{#2}%
    \ifthenelse{\equal{#1}{MA}}
	    {\renewcommand{\@degreeCode}{\@degreePrefix #1}
    	\renewcommand{\@childDeptNameKor}{수학과}
    	\renewcommand{\@childDeptNameEng}{Department of Mathematics}
		\renewcommand{\@programDeptNameEng}{Mathematics}
    	\renewcommand{\@degreeField}{#2}} {}
    \ifthenelse{\equal{#1}{PH}}
        {\renewcommand{\@degreeCode}{\@degreePrefix #1}
         \renewcommand{\@childDeptNameKor}{물리학과}
         \renewcommand{\@childDeptNameEng}{Department of Physics}
   	    \renewcommand{\@programDeptNameEng}{Physics}
         \renewcommand{\@degreeField}{#2}} {}
    \ifthenelse{\equal{#1}{CH}}
        {\renewcommand{\@degreeCode}{\@degreePrefix #1}
         \renewcommand{\@childDeptNameKor}{화학과}
         \renewcommand{\@childDeptNameEng}{Department of Chemistry}
         \renewcommand{\@programDeptNameEng}{Chemistry}
         \renewcommand{\@degreeField}{#2}} {}
    \ifthenelse{\equal{#1}{LS}}
        {\renewcommand{\@degreeCode}{\@degreePrefix #1}
         \renewcommand{\@childDeptNameKor}{생명과학과}
         \renewcommand{\@childDeptNameEng}{Department of Life Sciences}
         \renewcommand{\@programDeptNameEng}{Life Sciences}
         \renewcommand{\@degreeField}{#2}} {}
    \ifthenelse{\equal{#1}{MS}}
	    {\renewcommand{\@degreeCode}{\@degreePrefix #1}
    	\renewcommand{\@childDeptNameKor}{신소재공학과}
        \renewcommand{\@childDeptNameEng}{Department of Materials Science and Engineering}
        \renewcommand{\@programDeptNameEng}{Materials Science and Engineering}
    	\renewcommand{\@degreeField}{#2}} {}
    \ifthenelse{\equal{#1}{ME}}
        {\renewcommand{\@degreeCode}{\@degreePrefix #1}
         \renewcommand{\@childDeptNameKor}{기계공학과}
         \renewcommand{\@childDeptNameEng}{Department of Mechanical Engineering}
         \renewcommand{\@programDeptNameEng}{Mechanical Engineering}
         \renewcommand{\@degreeField}{#2}} {}
    \ifthenelse{\equal{#1}{IME}}
        {\renewcommand{\@degreeCode}{\@degreePrefix #1}
         \renewcommand{\@childDeptNameKor}{산업경영공학과}
         \renewcommand{\@childDeptNameEng}{Department of Industrial and Management Engineering}
         \renewcommand{\@programDeptNameEng}{Industrial and Management Engineering}
         \renewcommand{\@degreeField}{#2}} {}
    \ifthenelse{\equal{#1}{EE}}
        {\renewcommand{\@degreeCode}{\@degreePrefix #1}
         \renewcommand{\@childDeptNameKor}{전자전기공학과}
         \renewcommand{\@childDeptNameEng}{Department of Electrical Engineering}
         \renewcommand{\@programDeptNameEng}{Electrical Engineering}
         \renewcommand{\@degreeField}{#2}} {}
     \ifthenelse{\equal{#1}{CSE}}
        {\renewcommand{\@degreeCode}{\@degreePrefix #1}
         \renewcommand{\@childDeptNameKor}{컴퓨터공학과}
         \renewcommand{\@childDeptNameEng}{Department of Computer Science and Engineering}
         \renewcommand{\@programDeptNameEng}{Computer Science and Engineering}
         \renewcommand{\@degreeField}{#2}} {}
     \ifthenelse{\equal{#1}{CE}}
        {\renewcommand{\@degreeCode}{\@degreePrefix #1}
         \renewcommand{\@childDeptNameKor}{화학공학과}
         \renewcommand{\@childDeptNameEng}{Department of Chemical Engineering}
         \renewcommand{\@programDeptNameEng}{Chemical Engineering}
         \renewcommand{\@degreeField}{#2}} {}
     \ifthenelse{\equal{#1}{CITE}}
        {\renewcommand{\@degreeCode}{\@degreePrefix #1}
         \renewcommand{\@childDeptNameKor}{IT융합공학과}
         \renewcommand{\@childDeptNameEng}{Department of Convergence IT Engineering}
         \renewcommand{\@programDeptNameEng}{Convergence IT Engineering}
         \renewcommand{\@degreeField}{#2}} {}
     \ifthenelse{\equal{#1}{EV}}
        {\renewcommand{\@degreeCode}{\@degreePrefix #1}
         \renewcommand{\@childDeptNameKor}{환경공학부}
         \renewcommand{\@childDeptNameEng}{Division of Environmental Science and Engineering}
         \renewcommand{\@programDeptNameEng}{Environmental Science and Engineering}
         \renewcommand{\@degreeField}{#2}} {}
     \ifthenelse{\equal{#1}{GSAI}}
        {\renewcommand{\@degreeCode}{\@degreePrefix #1}
         \renewcommand{\@childDeptNameKor}{인공지능대학원}
         \renewcommand{\@childDeptNameEng}{Graduate School of Artificial Intelligence}
         \renewcommand{\@programDeptNameEng}{Artificial Intelligence}
         \renewcommand{\@degreeField}{#2}} {}
     \ifthenelse{\equal{#1}{ITCE}}
        {\renewcommand{\@degreeCode}{\@degreePrefix #1}
         \renewcommand{\@childDeptNameKor}{정보전자융합공학부}
         \renewcommand{\@childDeptNameEng}{Division of IT Convergence Engineering}
         \renewcommand{\@programDeptNameEng}{IT Convergence Engineering}
         \renewcommand{\@degreeField}{#2}} {}
     \ifthenelse{\equal{#1}{AMS}}
        {\renewcommand{\@degreeCode}{\@degreePrefix #1}
         \renewcommand{\@childDeptNameKor}{첨단재료과학부}
         \renewcommand{\@childDeptNameEng}{Division of Advanced Materials Science}
         \renewcommand{\@programDeptNameEng}{Advanced Materials Science}
         \renewcommand{\@degreeField}{#2}} {}
     \ifthenelse{\equal{#1}{IBB} \OR \equal{#1}{I-BIO}}
        {\postech@setdepartment{IBB}{시스템생명공학부}%
           {Division of Interdisciplinary Bioscience \& Bioengineering}%
           {Interdisciplinary Bioscience \& Bioengineering}} {}
    \ifthenelse{\equal{#1}{DANE} \OR \equal{#1}{ANE}}
        {\renewcommand{\@degreeCode}{\@degreePrefix ANE}
         \renewcommand{\@childDeptNameKor}{첨단원자력공학부}
         \renewcommand{\@childDeptNameEng}{Division of Advanced Nuclear Engineering}
         \renewcommand{\@programDeptNameEng}{Advanced Nuclear Engineering}
         \renewcommand{\@degreeField}{#2}} {}
    \ifthenelse{\equal{#1}{TIM}}
        {\renewcommand{\@degreeCode}{\@degreePrefix #1}
         \renewcommand{\@childDeptNameKor}{기술경영과정}
         \renewcommand{\@childDeptNameEng}{Graduate Program for Technology and Innovation Management}
         \renewcommand{\@programDeptNameEng}{Technology and Innovation Management}
         \renewcommand{\@degreeField}{#2}} {}
    \ifthenelse{\equal{#1}{GIFT}}
        {\renewcommand{\@degreeCode}{\@degreePrefix #1}
         \renewcommand{\@childDeptNameKor}{친환경소재대학원}
         \renewcommand{\@childDeptNameEng}{Graduate Institute of Ferrous \& Eco Materials Technology}
         \renewcommand{\@programDeptNameEng}{Ferrous \& Eco Materials Technology}
         \renewcommand{\@degreeField}{#2}} {}

    \renewcommand{\@affFullNameKor}{%               % 학과/전공 한글이름
    	\ifthenelse{\equal{\@parentDeptNameKor}{}}
    		{\@childDeptNameKor}
    		{\@parentDeptNameKor, \@childDeptNameKor}
    }
    \renewcommand{\@affFullNameEng}{%               % 학과/전공 영문이름
        \ifthenelse{\equal{\@parentDeptNameEng}{}}%
            {\@childDeptNameEng}%
            {\@parentDeptNameEng, \@childDeptNameEng}%
    }
    \renewcommand{\@affFullNameEngCover}{%          % 학과/전공 영문이름
        	\ifthenelse{\equal{\@parentDeptNameEng}{}}
    		{\@childDeptNameEng}
    		{\@parentDeptNameEng \\ \@childDeptNameEng}
    }
    \renewcommand{\@degreeName}{%                       % 학위 영문이름
        \ifthenelse{\boolean{@isDoctor}}
            {Doctor of Philosophy} {%                 % 박사는 모두 Ph.D.
            \ifthenelse{\equal{\@degreeField}{science} \OR \equal{\@degreeField}{}}
                {Master of Science}{}%               % 이학석사는 M.S.
            \ifthenelse{\equal{\@degreeField}{engineering}}
                {Master of Science}{}%           % 공학석사는 M.E.
%            \ifthenelse{\equal{\@degreeField}{business}}
%                {Master of Business Administration}{}% 경영학석사는 M.B.A.
        }
    }
}
\@onlypreamble{\department}
% Explicit override for departments/programs outside the legacy code table.
% Use after \department{...}{science|engineering}; copy the four values
% from the departmental guide's Exhibits 5 and 13.
\newcommand{\departmentinfo}[4]{%
  \renewcommand{\@childDeptNameKor}{#1}%
  \renewcommand{\@childDeptNameEng}{#2}%
  \renewcommand{\@programDeptNameEng}{#3}%
  \renewcommand{\@degreeCode}{#4}}
\@onlypreamble{\departmentinfo}

% @command studentid 학번
\newcommand{\studentid}[1]{\newcommand{\@studentID}{#1}}
\@onlypreamble{\studentid}

% @command referee 심사위원 (석사과정 3인, 박사과정 5인)
\newcommand{\referee}[2][1] {%
    \ifthenelse{\equal{#1}{1}}{\newcommand{\@refereeChief} {#2}} {}%
    \ifthenelse{\equal{#1}{2}}{\newcommand{\@refereeSecond}{#2}} {}%
    \ifthenelse{\equal{#1}{3}}{\newcommand{\@refereeThird} {#2}} {}%
    \ifthenelse{\equal{#1}{4}}{\newcommand{\@refereeFourth}{#2}} {}%
    \ifthenelse{\equal{#1}{5}}{\newcommand{\@refereeFifth} {#2}} {}%
}
\@onlypreamble{\referee}

% @command approvaldate 지도교수논문승인일
% @param year,month,day 연,월,일 순으로 입력
\newcommand{\approvaldate}[3] {%
    \newcommand{\@approvalYear}{#1}
    \newcommand{\@approvalMonth}{#2}
    \newcommand{\@approvalDay}{#3}
}
\@onlypreamble{\approvaldate}

% @command refereedate 심사위원논문심사일
% @param year,month,day 연,월,일 순으로 입력
\newcommand{\refereedate}[3] {%
    \newcommand{\@refereeYear}{#1}
    \newcommand{\@refereeMonth}{#2}
    \newcommand{\@refereeDay}{#3}
}
\@onlypreamble{\refereedate}

% @command gradyear 졸업년도
\newcommand{\gradyear}[1]{\newcommand{\@gradYear}{#1}}
\@onlypreamble{\gradyear}

%%
%% 필요한 정보 중에 누락된 것이 없는지 점검 --> 제작중. 아직 불완전.
%%
\newcommand{\checkparameters}{%
    \@ifundefined{@titleKor}{%
        \ClassError{postech}{The korean title is not found}{}}{}
    \@ifundefined{@titleEng}{%
        \ClassError{postech}{The english title is not found}{}}{}
    \@ifundefined{@authorKor}{%
        \ClassError{postech}{The korean name of the author is not found}{}}{}
    \@ifundefined{@authorEng}{%
        \ClassError{postech}{The english name of the author is not found}{}}{}
    \@ifundefined{@advisorMajorKor}{%
        \ClassError{postech}{The korean name of the major advisor is not found}{}}{}
    \@ifundefined{@advisorMajorEng}{%
        \ClassError{postech}{The english name of the major advisor is not found}{}}{}
    \ifx\@degreeCode\@empty
        \ClassError{postech}{The department code is missing or unknown}
          {Use a code from the current guidelines or set \string\departmentinfo.}%
    \fi
}

%% Front cover: title 21 pt; degree, name, affiliation and year 16 pt.
\newcommand{\makefrontcover}{%
  \clearpage\begingroup\setstretch{1}\thispagestyle{empty}
  \postech@coverfont
  \vbox to \textheight{%
    \offinterlineskip
    \kern15mm % 35 mm above the text area + 15 mm = 50 mm from the sheet edge
    \vbox{\centering\fontsize{16bp}{20bp}\selectfont
      \strut\if@isDoctor Doctoral Dissertation\else Master’s Thesis\fi\par}
    \kern25mm % from the degree line box to the title line box
    \vbox{\centering\fontsize{21bp}{27bp}\selectfont\strut\@titleEng\strut\par}
    \vfil
    \vbox{\raggedright\fontsize{16bp}{22bp}\selectfont
      \@authorEng\ifthenelse{\equal{\@authorKorFN}{}}{}{ (\@authorKor)}\par\vspace{10mm}
      \@affFullNameEngCover\par\vspace{10mm}
      \@postech\par\vspace{10mm}\@gradYear\strut\par}
    \kern43mm % visual space below the year, above the reserved 30 mm lower margin
  }
  \clearpage\endgroup}

%% Title page: both titles 21 pt.
\renewcommand{\maketitle}{%
  \begingroup\setstretch{1}\thispagestyle{empty}
  \vspace*{44mm}
  {\centering\fontsize{21bp}{27bp}\selectfont
    \@titleKor\par\vspace{3mm}\@titleEng\par}
  \clearpage\endgroup}

%% Approval and committee certificate, Exhibits 3 and 4.
\newcommand*{\postech@committeename}[1]{%
  \sbox\@tempboxa{#1}%
  \ifdim\wd\@tempboxa>64mm
    \parbox[t]{64mm}{\raggedright#1}%
  \else
    \usebox\@tempboxa
  \fi}

\newcommand{\makeapproval}{%
  \begingroup\setstretch{1}\thispagestyle{empty}
  \vspace*{0mm}
  {\centering\fontsize{21bp}{27bp}\selectfont\@titleEng\par}
  \vspace{12mm}
  {\centering\fontsize{14bp}{25bp}\selectfont
    by\par\vspace{12mm}\@authorEng\par
    \@affFullNameEngCover\par\@postech\par\vspace{9mm}
    A \if@isDoctor dissertation\else thesis\fi\ submitted to the faculty of
    \@postech\ in partial fulfillment of the requirements for the degree of
    \@degreeName\ in \@programDeptNameEng.\par\vfill
    Pohang, Korea\par
    \@approvalMonth/\@approvalDay/\@approvalYear\par
    Approved by\par
    \@ifundefined{@advisorSigned}{\@advisorMajorEng}{\@advisorSigned} (Signature)\par
    Academic Advisor\par}
  \clearpage\endgroup
  \begingroup\setstretch{1}\thispagestyle{empty}
  \vspace*{0mm}
  {\centering\fontsize{21bp}{27bp}\selectfont\@titleEng\par}
  \vspace{12mm}
  {\centering
    {\fontsize{16bp}{22bp}\selectfont\@authorEng\par}\vspace{9mm}
    \fontsize{14bp}{23.8bp}\selectfont
    The undersigned have examined this \if@isDoctor dissertation\else thesis\fi\
    and hereby certify that it is worthy of acceptance for a
    \if@isDoctor doctoral\else master's\fi\ degree from POSTECH\par}
  \vfill
  {\raggedleft\fontsize{14bp}{20bp}\selectfont
    \@refereeMonth/\@refereeDay/\@refereeYear\par\vspace{8mm}
    \def\@extraCommitteeRows{}%
    \if@isDoctor
      \def\@extraCommitteeRows{%
        \\[2.4bp] Member & \postech@committeename{\@refereeFourth} & (Seal)%
        \\[2.4bp] Member & \postech@committeename{\@refereeFifth} & (Seal)}%
    \fi
    \begin{tabular}{@{}r l r@{}}
      Committee Chair & \postech@committeename{\@refereeChief} & (Seal)\\[2.4bp]
      Member & \postech@committeename{\@refereeSecond} & (Seal)\\[2.4bp]
      Member & \postech@committeename{\@refereeThird} & (Seal)
      \@extraCommitteeRows
    \end{tabular}\par}
  \vspace{15mm}
  \clearpage\endgroup}

%% Abstract: 11 pt metadata/body, 14 pt heading, <= 1,000 English words.
\newcommand{\@lastPage}{\pageref{paperlastpagelabel}}
\renewenvironment{abstract}{%
  \clearpage\pagenumbering{Roman}\pagestyle{postech}\hypersetup{pageanchor=true}
  \let\linebreak\space
  \vbox{\kern5mm % metadata begins 40 mm from the sheet edge
    \hbox{%
      \begin{minipage}[t]{25mm}
        \@degreeCode\par\@studentID
      \end{minipage}%
      \begin{minipage}[t]{\dimexpr\textwidth-25mm\relax}
        \raggedright
        \ifthenelse{\equal{\@authorKorFN}{}}{}{\@authorKor\hspace{0.35em}}%
        \@authorEng, \@titleEng, \@titleKor,\par
        \@affFullNameEng, \@gradYear, \@lastPage\ p.,
        \@ifundefined{@advisorCooprEng}
          {Advisor: \@advisorMajorEng.}
          {Advisors: \@advisorMajorEng, \@advisorCooprEng.}\par
        \if@isKorean\else Text in English.\fi
      \end{minipage}}}
  \vspace{14mm}
  {\raggedright\normalfont\rmfamily\mdseries\fontsize{14bp}{20bp}\selectfont\underline{ABSTRACT}\par}
  \vspace{6mm}\normalsize
  \setlength{\parindent}{2.5em}\ignorespaces
}{\par\clearpage\blankpage}

\newcommand{\makecontents}{\tableofcontents\listoftables\listoffigures}

%% Korean summary is placed after the main body and before references.
\newenvironment{summarykorean}{%
  \chapter*{요 약 문}
  \phantomsection\addcontentsline{toc}{chapter}{Summary (in Korean)}
  \vspace{30mm}
  \normalsize
}{\par\clearpage}
\newenvironment{summary}{\begin{summarykorean}}{\end{summarykorean}}

\newcommand{\acknowledgement}[1][default]{%
  \chapter*{Acknowledgements\\감사의 글}
  \phantomsection\addcontentsline{toc}{chapter}{Acknowledgements}%
  \vspace{40mm}}
\newcommand{\curriculumvitae}[1][default]{%
  \chapter*{Curriculum Vitae}
  \phantomsection\addcontentsline{toc}{chapter}{Curriculum Vitae}
  \def\@ccvlang{english}}

%%
%% 이력서 내부 요소 생성
%%
    \newenvironment{personaldata}{%            % 개인정보
        \thispagestyle{postech}               % ver0.2 : 쪽 번호없음
        \begin{list}{}{%
            \setlength{\labelwidth}{70pt}
            \setlength{\leftmargin}{\labelwidth}
            \addtolength{\leftmargin}{\labelsep}
            \setlength{\parsep}{0pt}
            \renewcommand{\makelabel}[1]{\textrm{##1\ \ :\ }}}
        \newcommand{\name}[1]{%               % 이름
            \ifx\@ccvlang\@korean
                \def\@arg{[이\hfill름]}
            \else
                \def\@arg{[Name\hfill]}
            \fi
            \expandafter\item\@arg ##1}
    }{\end{list}}

    \newenvironment{education}{%               % 학력
        \thispagestyle{postech}
        \vspace*{10mm} \noindent
%        \ifx\@ccvlang\@korean
%            \begin{center}
%                \makebox[2cm][s]{\textbf{\large 학 력}}
%            \end{center}
%        \else \textbf{\large Educations} \fi
        {\centering\normalfont\postech@cvfont\normalsize Education\par}
		\vspace{3mm}
        \begin{list}{}{%
            \setlength{\labelwidth}{95pt}
            \setlength{\leftmargin}{\labelwidth}
            \addtolength{\leftmargin}{\labelsep}
            \setlength{\parsep}{0pt}
            \renewcommand{\makelabel}[1]{\textrm{##1\hfill\ }}}
    }{\end{list}}

    \newenvironment{experience}{%                  % 경력
        \thispagestyle{postech}              % ver0.2 : 쪽 번호없음
        \vspace*{10mm} \noindent           % ver0.2 : 줄 간격 조정
%        \ifx\@ccvlang\@korean
%            \begin{center}
%                \makebox[2cm][s]{\textbf{\large 경 력}}
%            \end{center}
%        \else \textbf{\large Career} \fi
        {\centering\normalfont\postech@cvfont\normalsize Experience\par}
		\vspace{3mm}
        \begin{list}{}{%
            \setlength{\labelwidth}{95pt}
            \setlength{\leftmargin}{\labelwidth}
            \addtolength{\leftmargin}{\labelsep}
            \setlength{\parsep}{\z@}
            \renewcommand{\makelabel}[1]{\textrm{##1\hfill\ }}}
    }{\end{list}}

    \newcounter{itemnum1}
    \newenvironment{affiliation}{%                % 학회활동
        \thispagestyle{postech}                 % ver0.2 : 쪽 번호없음
        \vspace*{10mm} \noindent        % ver0.2 : 줄 간격 조정
%        \ifx\@ccvlang\@korean
%            \begin{center}
%                \makebox[2cm][s]{\textbf{\large 학 회 활 동}}
%            \end{center}
%        \else \textbf{\large Academic Activities} \fi
        {\centering\normalfont\postech@cvfont\normalsize Affiliation\par}
		\vspace{3mm}
        \begin{list}{}{%
            \usecounter{itemnum1}
            \setlength{\labelwidth}{95pt}
            \setlength{\leftmargin}{\labelwidth}
            \addtolength{\leftmargin}{\labelsep}
            \setlength{\parsep}{\z@}
%            \renewcommand{\makelabel}{\textgt{\arabic{itemnum1}.\ }}}
            \renewcommand{\makelabel}[1]{\textrm{##1\hfill\ }}}
    }{\end{list}}

%    \newcounter{itemnum2}
%    \newenvironment{publication}{%             % 연구업적
%        \vspace*{5mm} \noindent
%        \ifx\@ccvlang\@korean
%            \begin{center}
%                \makebox[2cm][s]{\textbf{\large 연 구 업 적}}
%            \end{center}
%        \else \textbf{\large Publications} \fi
%        \begin{list}{}{%
%            \usecounter{itemnum2}
%            \setlength{\labelwidth}{1.5em}
%            \setlength{\leftmargin}{\labelwidth}
%            \addtolength{\leftmargin}{\labelsep}
%            \setlength{\parsep}{\z@}
%            \renewcommand{\makelabel}{\textgt{\arabic{itemnum2}.\ }}}
%    }{\end{list}}

%%
%% 헤딩 재설정
%%
\renewcommand{\contentsname}{%
    \if@isKorean 목 차       \else Contents        \fi}
\renewcommand{\listfigurename}{%
    \if@isKorean 그 림 목 차 \else List of Figures \fi}
\renewcommand{\listtablename}{%
    \if@isKorean 표 목 차    \else List of Tables  \fi}
\renewcommand{\bibname}{%
    \if@isKorean 참 고 문 헌 \else REFERENCES      \fi}

%%%
%%% \part 재정의 - 아예 쓰지 못하게 막아버림. 이 명령을 호출하면 에러 발생.
%%%
\renewcommand\part{%
    \secdef\@part\@spart}
\def\@part[#1]#2{%
    \ClassError{postech}{The use of \protect\part\space is prohibited.
        \MessageBreak Consider the use of \protect\chapter\space instead}{}
}
\def\@spart#1{%
    \ClassError{postech}{The use of \protect\part\space is prohibited.
        \MessageBreak Consider the use of \protect\chapter\space instead}{}
}

%%
%% \chapter 재정의 - report 클래스로부터 복사하여 일부 수정
%%

% Chapter titles are 14 bp. Section headings use the regular 11 bp body face.
\renewcommand\section{\@startsection{section}{1}{\z@}%
  {-3.0ex \@plus -1ex \@minus -.2ex}{1.5ex \@plus .2ex}%
  {\normalfont\rmfamily\normalsize\mdseries}}
\renewcommand\subsection{\@startsection{subsection}{2}{\z@}%
  {-2.5ex \@plus -1ex \@minus -.2ex}{1.0ex \@plus .2ex}%
  {\normalfont\rmfamily\normalsize\mdseries}}
\renewcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
  {-2.0ex \@plus -.5ex \@minus -.2ex}{.8ex \@plus .2ex}%
  {\normalfont\rmfamily\normalsize\mdseries}}

\renewcommand{\thechapter}{\Roman{chapter}} %Enumerate chapter as Roman number
%\renewcommand{\thechapter}{\Roman{part}} %Enumerate chapter as Roman number
%\renewcommand{\thechapter}{\arabic{chapter}} %Enumerate chapter as Roman number
\renewcommand{\thesection}{\arabic{chapter}.\arabic{section}} %Enumerate section as arabic number
\renewcommand{\thefigure}{\arabic{chapter}.\arabic{figure}} % ver0.2 : figure 번호를 아라비아 숫자로 표기
\renewcommand{\thetable}{\arabic{chapter}.\arabic{table}}   % ver0.2 : table 번호를 아라비아 숫자로 표기
\renewcommand{\theequation}{\arabic{chapter}.\arabic{equation}}

\renewcommand\chapter{%
    \if@openright\cleardoublepage\else\clearpage\fi
%   \thispagestyle{plain}%
    \global\@topnum\z@
    \@afterindentfalse
%   \if@isKorean \parindent\z@ \else \fi % <-- 추가할지 여부 고민중
    \secdef\@chapter\@schapter}

\def\@chapter[#1]#2{%
    \ifnum \c@secnumdepth >\m@ne
        \refstepcounter{chapter}%
        \typeout{\@chapapp\space\thechapter.}%
        \addcontentsline{toc}{chapter}{%
        \protect \rmfamily{\numberline{\thechapter.}}#1
        }% <-- 목차에 나타나는 형식 - 변경사항
    \else
       \addcontentsline{toc}{chapter}{#1}%
%       \addcontentsline{toc}{}{#1}%
    \fi
    \chaptermark{#1}%
    \addtocontents{lof}{\protect\addvspace{10\p@}}%
    \addtocontents{lot}{\protect\addvspace{10\p@}}%

    \if@twocolumn
        \@topnewpage[\@makechapterhead{#2}]%
    \else
        \@makechapterhead{#2}%
        \@afterheading%
    \fi
}
\def\@makechapterhead#1{% <-- 전체 변경
    \vspace*{10\p@}
    {\centering \parindent\z@ \normalfont\rmfamily\mdseries\fontsize{14bp}{20bp}\selectfont
%    \ifthenelse{\equal{\@textlang}{korean}}
%        {제\hspace{1.4ex}\thechapter\hspace{1.4ex}장\hspace{2ex}}
%        {Chapter\hspace{1.4ex}\thechapter.\hspace{1ex}}
%        {\thechapter.\hspace{1ex}}
    \thechapter.\hspace{1ex}
	#1\par}
    \vspace*{20\p@}
}
\def\@schapter#1{%
    \if@twocolumn
        \@topnewpage[\@makeschapterhead{#1}]%
    \else
        \@makeschapterhead{#1}%
        \@afterheading
    \fi}
\def\@makeschapterhead#1{% <-- 전체 변경
    \vspace*{10\p@}
    {\centering \parindent\z@ \normalfont\rmfamily\mdseries\fontsize{14bp}{20bp}\selectfont #1\par}
    \vspace*{20\p@}
}

%% Contents/lists retain continuous uppercase Roman page numbering.
\renewcommand\tableofcontents{\chapter*{\contentsname}\@starttoc{toc}\clearpage}
\renewcommand\listoftables{\chapter*{\listtablename}\@starttoc{lot}\clearpage}
\renewcommand\listoffigures{\chapter*{\listfigurename}\@starttoc{lof}\clearpage}

%%
%% 목차에 나오는 형식 - report 클래스로부터 복사하여 일부 수정
%%
%\newcommand{\l@content}{\normalsize\bf\@dottedtocline{1}{0em}{0em}}
\newcommand{\l@content}{\normalfont\normalsize\@dottedtocline{1}{0em}{0em}}

\renewcommand*\l@chapter[2]{%
    \addpenalty{-\@highpenalty}\vskip 0.7em
    {\normalfont\normalsize\@dottedtocline{0}{0em}{2.5em}{#1}{#2}}}

\if@isKorean % 한글이면 각종 치수를 변경
    \renewcommand*\l@section{\@dottedtocline{1}{2.7em}{2.3em}}
    \renewcommand*\l@subsection{\@dottedtocline{2}{5.0em}{3.2em}}
    \renewcommand*\l@subsubsection{\@dottedtocline{3}{8.2em}{4.1em}}
    \renewcommand*\l@paragraph{\@dottedtocline{4}{11.2em}{5em}}
    \renewcommand*\l@subparagraph{\@dottedtocline{5}{13.2em}{6em}}
\else \fi     % 영문이면 가만히 내버려둠

%%
%% thebibliography 환경 재정의 - report 클래스로부터 복사하여 일부 수정
%%
\renewenvironment{thebibliography}[1]{%
    \chapter*{\rmfamily{\bibname}}%
    \@mkboth{\MakeUppercase\bibname}{\MakeUppercase\bibname}%
    \phantomsection\addcontentsline{toc}{chapter}{\rmfamily{\bibname}}%
    \vspace{30mm}%
    \renewcommand\@biblabel[1]{##1.}%
    \list{\@biblabel{\@arabic\c@enumiv}}%
        {\settowidth\labelwidth{\@biblabel{#1}}%
         \leftmargin\labelwidth
         \advance\leftmargin\labelsep
         \@openbib@code
         \usecounter{enumiv}%
         \let\p@enumiv\@empty
         \renewcommand\theenumiv{\@arabic\c@enumiv}}%
    \sloppy
    \clubpenalty4000
    \@clubpenalty \clubpenalty
    \widowpenalty4000%
    \sfcode`\.\@m%
}{  % Last page is labeled explicitly after CV and copyright in thesis.tex.
    \def\@noitemerr{\@latex@warning{Empty `thebibliography' environment}}%
    \endlist
}

%%
%% 한국식 날짜 표기 -> 영문식 날짜 표기
%%
\newcommand{\@dateUSenglish}[3]{%  % 미국식 날짜 표기
    \newcommand{\@year}{#1}%
    \newcommand{\@month}{#2}%
    \newcommand{\@day}{#3}%
    \ifcase\@month \or
        January \or February \or March \or April \or May \or June \or
        July \or August \or September \or October \or November \or December \fi
    \@day, \@year
}
\newcommand{\@dateBRenglish}[3]{%  % 영국식 날짜 표기
    \newcommand{\@year}{#1}%
    \newcommand{\@month}{#2}%
    \newcommand{\@day}{#3}%
    \@day\ifcase\@day \or
        st\or nd\or rd\or th\or th\or th\or th\or th\or th\or th\or
        st\or nd\or rd\or th\or th\or th\or th\or th\or th\or th\or
        st\or nd\or rd\or th\or th\or th\or th\or th\or th\or th\or th\fi
    \space\ifcase\@month \or
        January\or February\or March\or April\or May\or June\or
        July\or August\or September\or October\or November\or December\fi,
    \@year
}
