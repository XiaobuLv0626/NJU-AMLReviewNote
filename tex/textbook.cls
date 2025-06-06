\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{textbook}[24-08-2024 V1.0 textbook Class]
% /* -------------------------------------------------------------------------- */
% /* -------------------------------------------------------------------------- */
% /*                                    切换文类                                    */
% /* --------------
\usepackage{xcolor}
%------------------------------------------------------------ */
\DeclareKeys{% = \DeclareKeys[autoclass]
    lang .choice: ,
    lang/en .code:n = \def\textbook@class{book} ,
    lang/cn .code:n = \def\textbook@class{ctexbook} ,
    lang .initial:n = en ,
    unknown .code:n = \textbook@unknown ,
}

\ExplSyntaxOn
\clist_new:N \textbook@unknownoptions
\cs_new_protected:Npn \textbook@unknown
    {
        \bool_if:NTF \l__keys_no_value_bool
        { % eg. 12pt, twoside
            \clist_put_right:Nx \textbook@unknownoptions
            { \l_keys_key_str }
        }
        { % eg. zihao=4, fontset=windows
            \clist_put_right:Nx \textbook@unknownoptions
            { \l_keys_key_str = { \exp_not:o \l_keys_value_tl } }
        }
    }
\ExplSyntaxOff

\ProcessKeyOptions % = \ProcessKeyOptions[textbook]
\PassOptionsToClass\textbook@unknownoptions\textbook@class
%% 如果不需要过滤上面定义的 lang 等键，可以直接使用
%% \PassOptionsToClass\@raw@classoptionslist\textbook@class

\LoadClass{\textbook@class}
% /* ---------------------------------- 切换文类 ---------------------------------- */


% /* -------------------------------------------------------------------------- */
% /*                           判断 A4 paper程序                          */
% /* -------------------------------------------------------------------------- */
\ExplSyntaxOn
\cs_new:Npn \ifaivpaper@TF
    {
        \bool_lazy_and:nnTF
        { \dim_compare_p:nNn { 297mm } = { \paperheight } } % 不能是 29.7cm
        { \dim_compare_p:nNn { 210mm } = { \paperwidth  } }
    }
\ExplSyntaxOff
% \ifaivpaper@TF{a4paper内容}{not a4paper内容} % 这个用在想要判断a4paper的地方
% /* -------------------------------------------------------------------------- */
% /*                           判断 A4 paper程序                          */
% /* -------------------------------------------------------------------------- */
\RequirePackage{iftex}
\ifxetex
\RequirePackage{fontspec,anyfontsize}
% ----------------------------------- 字体设置 ----------------------------------- %
\setCJKmainfont[
    Path=fonts/,
    BoldFont={FZheiti_GBK.TTF},
    ItalicFont={FZBWKSK.TTF},
    SlantedFont={HYShuFang_75W.ttf},
    AutoFakeSlant
]{FZsong_GBK.TTF}
\setCJKsansfont[Path=fonts/,BoldFont={HYShuFang_75W.ttf},ItalicFont={FZBWKSK.TTF},SlantedFont = {FZkaiti_GBK.TTF}]{FZheiti_GBK.TTF}
\setCJKmonofont{FZfangsong_GBK.TTF}[Path=fonts/,]
\newCJKfontfamily[kaishu]\kaishu{FZkaiti_GBK.TTF}[Path=fonts/,]
\newCJKfontfamily[shufang]\shufang{HYShuFang_75W.ttf}[Path=fonts/,]
\newfontfamily\posche[Path=fonts/,]{STHeiti-Medium.ttc}
\setmainfont{Times New Roman}
\setsansfont[Path=fonts/,BoldFont={HONORSans-Bold.ttf}]{HONORSansCN-Regular.ttf}
\setmonofont{Latin Modern Mono}
\renewcommand{\partial}{∂}
\RequirePackage{zhnumber}
% ----------------------------------- 字体设置 ----------------------------------- %
\else
\RequirePackage[utf8]{inputenc} % UTF-8编码
% \RequirePackage{times} % Times New Roman Font
\RequirePackage[T1]{fontenc}
\RequirePackage{anyfontsize}
\RequirePackage{microtype} % Improves character and word spacing
\usepackage[english]{babel} % -- language: English --
\fi
\RequirePackage{amsmath,amsthm}
\RequirePackage{emptypage}
\RequirePackage[colorlinks
,linkcolor = dblue,		%%修改此处为你想要的颜色
anchorcolor = dblue,	%%修改此处为你想要的颜色
urlcolor = dblue,		%%修改此处为你想要的颜色
citecolor = dblue,		%%修改此处为你想要的颜色
]{hyperref}
\definecolor{allanblue}{rgb}{0.227451,0.372549,0.803922}
\definecolor{allanred}{rgb}{0.933333,0.172549,0.172549}
\definecolor{allangreen}{rgb}{0.133333,0.545098,0.133333}
\definecolor{allanorange}{rgb}{1,0.498039,0}
\definecolor{allanpurple}{rgb}{0.607843,0.188235,1}
\definecolor{allancyan}{rgb}{0,0.898039,0.933333}
\definecolor{allanyellow}{rgb}{1,0.843137,0}
\definecolor{allandarkblue}{rgb}{0.0980392,0.0980392,0.439216}
\RequirePackage[capitalise,nameinlink,noabbrev]{cleveref}
\RequirePackage[dvipsnames,svgnames,x11names,table]{xcolor}
\definecolor{myblue}{HTML}{4488bf}
% Define TU Delft colors.
\definecolor{tudelft-cyaan}{RGB}{0,166,214}
\definecolor{tudelft-wit}{RGB}{255,255,255}
\definecolor{tudelft-zwart}{RGB}{0,0,0}
\definecolor{tudelft-donkerblauw}{RGB}{12,35,64}
\definecolor{tudelft-turkoois}{RGB}{0,184,200}
\definecolor{tudelft-koningsblauw}{RGB}{0,118,194}
\definecolor{tudelft-paars}{RGB}{111,29,119}
\definecolor{tudelft-roze}{RGB}{239,96,163}
\definecolor{tudelft-bordeaux}{RGB}{165,0,52}
\definecolor{tudelft-rood}{RGB}{224,60,49}
\definecolor{tudelft-oranje}{RGB}{237,104,66}
\definecolor{tudelft-geel}{RGB}{255,184,28}
\definecolor{tudelft-groen}{RGB}{108,194,74}
\definecolor{tudelft-bosgroen}{RGB}{0,155,119}
\definecolor{tudelft-donkergrijs}{RGB}{92,92,92}

\RequirePackage{calc}
\RequirePackage{tikz}
\usetikzlibrary{backgrounds,calc,shadows,positioning,fit}
% /* ---------------- Define the layers to be used in document. --------------- */
\pgfdeclarelayer{background} %背景
\pgfdeclarelayer{foreground} %上层
\pgfdeclarelayer{top} %顶部
\pgfdeclarelayer{bottom} %底部
\pgfsetlayers{bottom,background,main,foreground,top}
% /* -------------------------------------------------------------------------- */
\RequirePackage[most]{tcolorbox}
\RequirePackage{etoolbox} % Easy programming to modify TeX stuff
% /* -------------------------------------------------------------------------- */
% /*                                  文本与边注距离调整                                 */
% /* -------------------------------------------------------------------------- */
\RequirePackage{geometry}
\ifodd\value{page}
\newgeometry{left=2cm,right=2cm+.33\linewidth+.5cm,top=2.5cm,bottom=2.2cm,marginparwidth=.33\linewidth, marginparsep=.5cm,head=0pt} % set proper headheight
\else
\newgeometry{left=2cm+.33\linewidth+.5cm,right=2cm,top=2.5cm,bottom=2.2cm,marginparwidth=.33\linewidth, marginparsep=.5cm,head=0pt} % set proper headheight
\fi
% /* -------------------------------------------------------------------------- */
\RequirePackage{csquotes}
\RequirePackage[
backend=biber,style=numeric-comp,
sorting=nty,hyperref=true,giveninits=true,
maxnames=99,minnames=99
]{biblatex}
\RequirePackage{imakeidx}
\addbibresource{main.bib}
\RequirePackage{graphicx,eso-pic} % Required for inserting images
% 设置图片路径
\graphicspath{{figures/}{picture/}{images/}} % 图片目录为 "images/"
% 设置默认的图片扩展名
\DeclareGraphicsExtensions{.jpg,.jpeg,.png,.pdf} % 设置 JPG、JPEG、PNG 和 PDF 为默认扩展名
% /* ----------------------------------- 判断条件用法 ----------------------------------- */
\RequirePackage{xifthen} % Easy conditionals
% \ifthenelse{判断条件}{肯定结构}{否定结构}
% \whiledo{判断条件}{while语句}
% /* ----------------------------------------------------------------------------------- */
\RequirePackage{adjustbox,varwidth}
\RequirePackage{mathrsfs}
% /* -------------------------------------------------------------------------- */
% /*                                    边注实现                                    */
% /* -------------------------------------------------------------------------- */
\RequirePackage{ragged2e} % Required to achieve better ragged paragraphs
% /* -------------------------------------------------------------------------- */
% /*                                  Sidenote                                  */
% /* -------------------------------------------------------------------------- */
\RequirePackage{marginnote} % Provides an offset option for the marginals instead of a float
\RequirePackage{caption} % Handles the captions (in the margin)
\RequirePackage{xparse} % New LaTeX3 syntax to define macros and environments
\RequirePackage[strict]{changepage} % Changepage package for symmetric twoside handling
\ExplSyntaxOn
\newcounter{sidenote} % make a counter
\setcounter{sidenote}{1} % init the counter
\DeclareExpandableDocumentCommand{\IfNoValueOrEmptyTF}{ m +m +m }
{
 \IfNoValueTF{#1}
  {#2}
  {\tl_if_empty:nTF {#1} {#2} {#3}}
}
\NewDocumentCommand \@sidenotes@thesidenotemark { m }
{
    \leavevmode
    \ifhmode
        \edef \@x@sf {\the \spacefactor }
        \nobreak
    \fi
    \hbox {\@textsuperscript {\color{dblue}\bf #1 }} % change
    \ifhmode
        \spacefactor \@x@sf
    \fi
    \relax
}
\NewDocumentCommand \@sidenotes@multisign { } {3sp}
\NewDocumentCommand \@sidenotes@multimarker { }
{
  \kern-\@sidenotes@multisign
  \kern\@sidenotes@multisign\relax
}
\NewDocumentCommand \@sidenotes@multichecker { }
{
  \dim_compare:nNnTF \lastkern = \@sidenotes@multisign
  {\@sidenotes@thesidenotemark{,}}
  {}
}
\NewDocumentCommand \@sidenotes@placemarginal { +m +m }
{
  \IfNoValueOrEmptyTF{#1}
    {\marginpar{#2}}
    {\marginnote{#2}[#1]}
}
\NewDocumentCommand \sidenote { o o +m }
{
  \sidenotemark[#1]
  \sidenotetext[#1][#2]{#3}
  \@sidenotes@multimarker
}
\NewDocumentCommand \sidenotemark { o }
{
  \@sidenotes@multichecker
  \IfNoValueOrEmptyTF{#1}
    {\@sidenotes@thesidenotemark{\thesidenote}}
    {\@sidenotes@thesidenotemark{#1}}
  \@sidenotes@multimarker
}
\NewDocumentCommand \sidenotetext { o o +m }
{
  \IfNoValueOrEmptyTF{#1}
    {
      \@sidenotes@placemarginal{#2}{\textsuperscript{\bfseries\color{dblue}\thesidenote}{}~#3} %change
  \refstepcounter{sidenote}
}
    {\@sidenotes@placemarginal{#2}{\textsuperscript{#1}~#3}}
}
\DeclareCaptionStyle{sidecaption}{font=footnotesize}
\NewDocumentCommand \sidecaption {s o o m}
{
  \captionsetup{style=sidecaption}
  \IfBooleanTF{#1}
  { % starred
    \IfNoValueOrEmptyTF{#2}
    {\marginnote{\caption*{#4}}}
    {\marginnote{\caption*{#4}}[#2]}
  }
  { % unstarred
  \IfNoValueOrEmptyTF{#2}
    {\def\@sidenotes@sidecaption@tof{#4}}
    {\def\@sidenotes@sidecaption@tof{#2}}
  \IfNoValueOrEmptyTF{#3}
    {\marginnote{\caption[\@sidenotes@sidecaption@tof]{#4}}}
    {\marginnote{\caption[\@sidenotes@sidecaption@tof]{#4}}[#3]}
  }
}
\newsavebox{\@sidenotes@marginfigurebox}
\DeclareCaptionStyle{marginfigure}{font=footnotesize}
\NewDocumentEnvironment{marginfigure} { o }
{
  \begin{lrbox}{\@sidenotes@marginfigurebox}
    \begin{minipage}{\marginparwidth}
      \captionsetup{type=figure,style=marginfigure}
}
{
    \end{minipage}%
  \end{lrbox}%
  \@sidenotes@placemarginal{#1}{\usebox{\@sidenotes@marginfigurebox}}
}
\newsavebox{\@sidenotes@margintablebox}
\DeclareCaptionStyle{margintable}{font=footnotesize}
\NewDocumentEnvironment{margintable} { o }
{
  \begin{lrbox}{\@sidenotes@margintablebox}
    \begin{minipage}{\marginparwidth}
      \captionsetup{type=table,style=margintable}
}
{
    \end{minipage}
  \end{lrbox}
  \@sidenotes@placemarginal{#1}{\usebox{\@sidenotes@margintablebox}}
}
\AtBeginDocument{%
\newlength{\@sidenotes@extrawidth}
\setlength{\@sidenotes@extrawidth}{\marginparwidth}
\addtolength{\@sidenotes@extrawidth}{\marginparsep}}
\NewDocumentEnvironment{autoadjustwidth}{ m m }%
{
    \bool_if:NTF \sidenotes_oneside
    {
        \begin{adjustwidth}{#1}{#2}
    }
    {
        \begin{adjustwidth*}{#1}{#2}
    }
}
{
    \bool_if:NTF \sidenotes_oneside
    {
        \end{adjustwidth}
    }
    {
        \end{adjustwidth*}
    }
}
\DeclareCaptionStyle{widefigure}{font=footnotesize}
\RenewDocumentEnvironment{figure*}{ O{htbp} }
{
    \begin{figure}[#1]
        \begin{autoadjustwidth}{}{-\@sidenotes@extrawidth}
        \begin{minipage}{\linewidth}
        \captionsetup{style=widefigure}
}
{
\end{minipage}
        \end{autoadjustwidth}
    \end{figure}
}
\DeclareCaptionStyle{widetable}{font=footnotesize}
\RenewDocumentEnvironment{table*}{ O{htbp} }
{
    \begin{table}[#1]
        \begin{autoadjustwidth}{}{-\@sidenotes@extrawidth}
        \begin{minipage}{\linewidth}
        \captionsetup{style=widetable}
}
{
\end{minipage}
        \end{autoadjustwidth}
    \end{table}
}
\ExplSyntaxOff
% /* -------------------------------------------------------------------------- */
\ExplSyntaxOn
\NewDocumentCommand \sidecite { o o m }
{
    \IfNoValueOrEmptyTF{#1} % before citation
    {
        \IfNoValueOrEmptyTF{#2}
            {
                \sidenote{\footnotesize\fullcite{#3}}
            }
            {
                \sidenote{\footnotesize\fullcite[#2]{#3}}
            }
    }
    {
        \IfNoValueOrEmptyTF{#2} % after citation
            {
                \sidenote{\footnotesize\fullcite[#1]{#3}}
            }
            {
                \sidenote{\footnotesize\fullcite[#1][#2]{#3}}
            }
    }
}
\ExplSyntaxOff
% /* -------------------------------------------------------------------------- */
\RequirePackage[maxfloats=45]{morefloats}% a lot of marginals need more float 'memory'
\RequirePackage{marginfix}% automatically adjust the side-floats nicely
% fullwidth environment, text across textwidth+marginparsep+marginparwidth
\RequirePackage{needspace}
\definecolor{dblue}{HTML}{006284}
% \colorlet{dblue}{SkyBlue4}
% /* -------------------------------------------------------------------------- */
\RequirePackage[hang]{subfigure}
\setcounter{tocdepth}{2}
\setcounter{secnumdepth}{2}%增加编号深度
\RequirePackage{enumitem}
\setlist[itemize]{itemsep=1pt, parsep=1pt} % 对所有itemize环境生效
\setlist[enumerate]{itemsep=1pt, parsep=1pt} % 对所有enumerate环境生效
\newcommand*\circled[1]{\tikz[baseline=(char.base)]{
            \node[shape=circle,draw,inner sep=1pt] (char) {#1};}}
\newcommand*{\eitemi}{\tikz \draw [baseline, ball color=dblue,draw=none] circle (3pt);}
\newcommand*{\eitemii}{\tikz \draw [baseline, fill=dblue,draw=none,circular drop shadow] circle (3pt);}
\newcommand*{\eitemiii}{\tikz \draw [baseline, fill=dblue,draw=none] circle (3pt);}
\setlist[enumerate,1]{label=\color{dblue}\arabic*.}
\setlist[enumerate,2]{label=\color{dblue}(\alph*).}
\setlist[enumerate,3]{label=\color{dblue}\Roman*.}
\setlist[enumerate,4]{label=\color{dblue}\Alph*.}
\setlist[itemize,1]{label={\eitemi}}
\setlist[itemize,2]{label={\eitemii}}
\setlist[itemize,3]{label={\eitemiii}}
% \setlist[itemize]{nosep,                     % 取消 itemize 的默认间距
%     before={\vspace*{-\parskip}},          % 取消 itemize 和后续段落之间的空白
%     leftmargin=*}		                    % 取消 itemize 的左边距
% \setlist[enumerate]{leftmargin=*}	        % 取消 enumerate 的左边距
\RequirePackage{fancyhdr}
\fancyhf{}
\newcommand{\headstyle}{
\begin{tikzpicture}[remember picture,overlay]
\ifodd\value{page}
    \node[text=black,font=\sffamily\bfseries,inner sep=0pt,above] (pagenumber) at ([shift={(-1.5cm,-2cm)}]current page.north east) {\thepage};
    \draw[line width=0.5pt,black] ([shift={(-.2cm,2.2cm)}]pagenumber.south west)--++(0,-2.2cm);
    \node[text=black,font=\small\normalfont,inner sep=0pt,left] (headmark) at ([shift={(-.4cm,0mm)}]pagenumber.west) {\rightmark};
\else
    \node[text=black,font=\sffamily\bfseries,inner sep=0pt,above] (pagenumber) at ([shift={(1.5cm,-2cm)}]current page.north west) {\thepage};
    \draw[line width=0.5pt,black] ([shift={(.2cm,2.2cm)}]pagenumber.south east)--++(0,-2.2cm);
    \node[text=black,font=\small\normalfont,inner sep=0pt,right] (headmark) at ([shift={(.4cm,0mm)}]pagenumber.east) {\leftmark};
\fi
\end{tikzpicture}
}

\newcommand{\subtitle}[1]{\newcommand{\@subtitle}{#1}}
\newcommand{\publishers}[1]{\newcommand{\myPublisher}{#1}}
\newcommand{\myauthor}{Your Author Name}
\newcommand{\mypublishers}{Your Publisher Name}

\fancypagestyle{Mainpage}{
\fancyhf{}
\fancyhead[C]{\headstyle}
\fancyfoot{}
\renewcommand{\headrulewidth}{0pt} % 去掉页眉横线
\setlength{\headsep}{10pt} % 文本与页眉间距
}
\setlength{\headheight}{18pt} % 页眉高度

\makeatletter
% 章节样式
\RequirePackage{etoc} % Required to insert local tables of contents
\RequirePackage[explicit,clearempty,toctitles,newlinetospace]{titlesec}
% clearempty-Modifies the behaviour of \cleardoublepage so that the empty page style will be used in empty pages.% 令part或章后的空白页清除页面样式
% toctitles-Changes the behaviour of the optional argument in sectioning titles so that it sets only the running heads and not the TOC entries, which will be based on the full title.% 通俗而言,\chapter[short]{title}或\section[short]{title} 里面的可选参数只会影响页眉和页脚，而不会再影响目录的显示 %这个可选参数用于缩写，防止页眉和页脚中太长放不下
% newlinetospace-Replaces every occurrence of \\ or \\* in titles by a space in running heads and TOC entries. This way, you do not have to repeat the title just to remove a formatting command. % 将标题中的换行符在目录中去除
\newcommand\partimg[1]{\def\@partimg{#1}}
\newcommand\chapimg[1]{\def\@chapimg{#1}}

\titleformat{\part}{\Large\bfseries\filcenter}{}{1em}{
\newpage\thispagestyle{empty}
  \makebox[0pt][l]{%
  \begin{tikzpicture}[remember picture, overlay]%
  \node[inner sep=0pt] (background) at (current page.center) {%
  		\adjustbox{width=1.1\paperwidth, height=1.5\paperheight, keepaspectratio}{% 强制图片至纸张尺寸，但可能裁切
			\includegraphics{\@partimg}
		}
  };
  \node[text=black,font=\sffamily\bfseries,right] (parttitle) at ([shift={(2cm,2cm)}]current page.west) {\color{white}
    \ifxetex
  \begin{varwidth}{.9\linewidth}
      第\ \thepart\ 部分 \\ #1
  \end{varwidth}
  \else
  \begin{varwidth}{.9\linewidth}
    \thepart \\ #1
\end{varwidth}
  \fi
  };
    \end{tikzpicture}}
    \newpage\thispagestyle{empty}
    }

\titleformat{name=\part,numberless}{\Large\bfseries\filright}{}{1em}{
    \newpage\thispagestyle{empty}
  \makebox[0pt][l]{%
  \begin{tikzpicture}[remember picture, overlay]%
  \node[inner sep=0pt] (background) at (current page.center) {%
  		\adjustbox{width=1.1\paperwidth, height=1.5\paperheight, keepaspectratio}{% 强制图片至纸张尺寸，但可能裁切
			\includegraphics[width=\paperwidth, height=1.5\paperheight, keepaspectratio]{\@partimg}
		}
  };
  \node[text=black,font=\sffamily\bfseries,right] (parttitle) at ([shift={(2cm,2cm)}]current page.west) {\color{white}
    \begin{varwidth}{.9\linewidth}
      #1
  \end{varwidth}
  };
    \end{tikzpicture}}
    \newpage\thispagestyle{empty}
    }


% /* -------------------------------------------------------------------------- */
% /*                                chapter Style                               */
% /* -------------------------------------------------------------------------- */

\newcommand{\chapternumstyle}[1]{
    \thispagestyle{empty}
\makebox[0pt][l]{
    \begin{tikzpicture}[remember picture,overlay]
    \node[inner sep=0pt] (chapimg) at ([shift={(0,-.02\paperheight)}]current page.north) {
			\includegraphics[width=1.1\paperwidth, keepaspectratio]{\@chapimg}
    };
    % /* -------------------------------------------------------------------------- */
    \def\rad{3.6pt}
    \def\innerroundcorner{6pt}
    \def\innerlefthsep{3mm}
    \def\innerleftvsep{4mm}
    \node[inner sep=0pt] (vbar) at ([shift={(.7\linewidth,-4cm)}]current page.north west) {
    \begin{tikzpicture}
    \path[]node[append after command={% 主体
    (chap.north west) -- (chap.south west) --(chap.south east) -- (chap.north east) --cycle
    },
    text=white,font=\sffamily\Large\bfseries,align=center,inner ysep=4mm,inner xsep=4.5mm] (chap) at (0,0) {
    \hspace*{3mm}
    \begin{varwidth}{\linewidth}
        \setlength\baselineskip{22pt} {\textcolor{purple!70!white}{\Huge\thechapter}} \\[-.6em]\tikz\draw[white,dotted,opacity=0.7](0,0)--++(\linewidth,0);\\[.1em] #1
    \end{varwidth}
    }; %
     \fill[white!50!black] ([shift={(\innerlefthsep,-\innerleftvsep)}]chap.north west) arc[start angle=180, end angle=0, radius=\rad] -- ([shift={(\innerlefthsep+2*\rad,\innerleftvsep)}]chap.south west) arc[start angle=0, end angle=-180, radius=\rad] --cycle; % The vertical white bar on the left
  \end{tikzpicture}};
  \ifodd\value{page}
  \draw[line width=0.5pt,black] ([shift={(-1.8cm,0cm)}]current page.south east)--++(0,2cm);
  \node[text=black,font=\sffamily\small,above right] (pagenum) at ([shift={(-1.8cm,1.5cm)}]current page.south east) {\thepage};
  \else
  \draw[line width=0.5pt,black] ([shift={(1.8cm,0cm)}]current page.south west)--++(0,2cm);
  \node[text=black,font=\sffamily\small,above left] (pagenum) at ([shift={(1.8cm,1.5cm)}]current page.south west) {\thepage};
  \fi
    \end{tikzpicture}}
}

\newcommand{\chapternonumstyle}[1]{
    \thispagestyle{empty}
\makebox[0pt][l]{
    \begin{tikzpicture}[remember picture,overlay]
        \node[inner sep=0pt] (chapimg) at ([shift={(0,-.02\paperheight)}]current page.north) {
			\includegraphics[width=1.1\paperwidth, keepaspectratio]{\@chapimg}
    };
    % /* -------------------------------------------------------------------------- */
    \def\rad{3.6pt}
    \def\innerroundcorner{6pt}
    \def\innerlefthsep{3mm}
    \def\innerleftvsep{4mm}
    \node[inner sep=0pt,right] (vbar) at ([shift={(1.8cm,-4cm)}]current page.north west) {
    \begin{tikzpicture}
    \path[]node[append after command={% 主体
    (chap.north west) -- (chap.south west) --(chap.south east) -- (chap.north east) --cycle
    },
    text=white,font=\sffamily\Large\bfseries,align=center,inner ysep=4mm,inner xsep=4.5mm] (chap) at (0,0) {
    \hspace*{3mm}
    \begin{varwidth}{\linewidth}
          #1
    \end{varwidth}
    }; %
     \fill[white!50!black] ([shift={(\innerlefthsep,-\innerleftvsep)}]chap.north west) arc[start angle=180, end angle=0, radius=\rad] -- ([shift={(\innerlefthsep+2*\rad,\innerleftvsep)}]chap.south west) arc[start angle=0, end angle=-180, radius=\rad] --cycle; % The vertical white bar on the left
  \end{tikzpicture}};
  \ifodd\value{page}
  \draw[line width=0.5pt,black] ([shift={(-1.8cm,0cm)}]current page.south east)--++(0,2cm);
  \node[text=black,font=\sffamily\small,above right] (pagenum) at ([shift={(-1.8cm,1.5cm)}]current page.south east) {\thepage};
  \else
  \draw[line width=0.5pt,black] ([shift={(1.8cm,0cm)}]current page.south west)--++(0,2cm);
  \node[text=black,font=\sffamily\small,above left] (pagenum) at ([shift={(1.8cm,1.5cm)}]current page.south west) {\thepage};
  \fi
    \end{tikzpicture}}
}

% ---------------------------------------------------------------------------- %
%                                    Minitoc                                   %
% ---------------------------------------------------------------------------- %
% Some New Lengths used later
\newlength{\hscale}
\newlength{\vscale}

% By default, the scales are set to work for a4paper
\setlength{\hscale}{1mm}
\setlength{\vscale}{1cm}

\newcounter{margintocdepth} % Set the depth of the margintoc
\setcounter{margintocdepth}{2} % 2 is the depth of the level subsection

\newlength{\mtocshift} % Length of the vertical offset used for margin tocs
\setlength{\mtocshift}{3.5\vscale}% \mtocshift is overridden by \setchapterstyle

% Thanks for Kaobook!!
% Optional title for margintoc (by hCarlFelix, 
% https://github.com/fmarotta/kaobook/issues/101)
% We want to create an additional entries in the toc which is to be used for the margintoc
% We define these as mtocsection and mtocsubsection for section and subsection`
\newcommand{\mtocsection}[1]{
    \addcontentsline{toc}{mtocsection}{%
        \ifnum\value{secnumdepth}>0 \protect\numberline{\thesection}%
        \else \protect\nonumberline%
        \fi #1}%
}
\newcommand{\mtocsubsection}[1]{
    \addcontentsline{toc}{mtocsubsection}{%
        \ifnum\value{secnumdepth}>1 \protect\numberline{\thesubsection}%
        \else \protect\nonumberline%
        \fi #1}%
}

% Next, we redefine \section and \subsection so that they accept an additional parameter
% \section[alternative-title-for-toc]{title-as-written-in-text}[alternative-title-for-margintoc]

% Adapted from Frank Mittelbach's answer at Stackexchange
% https://tex.stackexchange.com/a/109560/226693
\let\oldsection\section  % save the old command
\let\oldsubsection\subsection  % save the old command

\RenewDocumentCommand\section{s o m o}{%
    \IfBooleanTF{#1}{%
        \oldsection*{#3}
        \IfNoValueF{#2}{% if TOC arg is given create a TOC entry
            \addxcontentsline{toc}{section}[\thesection]{#2}%
        }%
    }{% no star given
        \IfNoValueTF{#2}{%
            \oldsection{#3}%
        }{% no TOC arg
            \oldsection[#2]{#3}%
        }%
        \IfNoValueTF{#4}{% optional label given, if not we do nothing
            \mtocsection{#3}%
        }{%
            \mtocsection{#4}%
        }%
    }%
}

\RenewDocumentCommand\subsection{s o m o}{
    \IfBooleanTF{#1}{%
        \oldsubsection*{#3}%
        \IfNoValueF{#2}{% if TOC arg is given create a TOC entry
            \addxcontentsline{toc}{subsection}[\thesubsection]{#2}%
        }%
    }{% no star given
        \IfNoValueTF{#2}{%
            \oldsubsection{#3}%
        }{% no TOC arg
            \oldsubsection[#2]{#3}%
        }%
        \IfNoValueTF{#4}{% optional label given, if not we do nothing
            \mtocsubsection{#3}%
        }{%
            \mtocsubsection{#4}%
        }%
    }%
}

\etocsetlevel{mtocsection}{6}% dummy sectioning level
\etocsetlevel{mtocsubsection}{6}% dummy sectioning level


\RequirePackage{placeins} % Provide \FloatBarrier Command
% Command to print a table of contents in the margin
\NewDocumentCommand{\margintoc}{O{\mtocshift}}{ % The first parameter is the vertical offset; by default it is \mtocshift
  \begingroup%
      % Move regular section and subsection to level 6 so that they won't be included and instead set let the mtoc versions take their place.
      % Adapted from https://tex.stackexchange.com/a/133559/226693
      \etocsetlevel{section}{6}
      \etocsetlevel{subsection}{6}
      \etocsetlevel{mtocsection}{1}
      \etocsetlevel{mtocsubsection}{2}

      % Define default widths
      \def\margintocnumwidth{-.8mm}%
      \def\margintocpagenumwidth{8pt}%
      \setlength{\RaggedRightParfillskip}{0pt}

      % Dry run to get the needed widths
      \etocsetstyle{mtocsection}%
        {}%
        {\setbox0\hbox{\small\etocthenumber\kern.8mm}%%
          \setbox1\hbox{\small\etocthepage}}%
        {\ifdim\wd0>\margintocnumwidth \edef\margintocnumwidth{\the\wd0} \fi%%
          \ifdim\wd1>\margintocpagenumwidth \edef\margintocpagenumwidth{\the\wd1} \fi}%
        {}%
      \etocsetstyle{mtocsubsection}%
        {}%
        {\setbox0\hbox{\small\etocthenumber\kern.8mm}%
          \setbox1\hbox{\small\etocthepage}}%
        {\ifdim\wd0>\margintocnumwidth \edef\margintocnumwidth{\the\wd0} \fi%
          \ifdim\wd1>\margintocpagenumwidth \edef\margintocpagenumwidth{\the\wd1} \fi}%
        {}%
      \etocsetstyle{subsubsection}%
        {}%
        {}%
        {}%
        {}%
      \etocsetstyle{paragraph}%
        {}%
        {}%
        {}%
        {}%
      \etocsettocstyle{}{%
        \global\let\margintocnumwidth\margintocnumwidth%
        \global\let\margintocpagenumwidth\margintocpagenumwidth%
      }%
      \localtableofcontents%

      % Set the style for section entries
      \etocsetstyle{mtocsection}%
      {\parindent 0pt \parskip 2.5pt \parfillskip 0pt \RaggedRight}%
      {\leftskip \margintocnumwidth \rightskip \margintocpagenumwidth} %
      {\small\makebox[0pt][r]{\makebox[\margintocnumwidth][l]{\etocnumber}}\etocname\nobreak\leaders\hbox{\hbox to 1.5ex {\hss.\hss}}\hfill\rlap{\makebox[\margintocpagenumwidth][r]{\etocpage}}\par}%
      {}%
  % Set the style for subsection entries
      \etocsetstyle{mtocsubsection}%
      {\parindent 0pt \parskip 0.25pt \parfillskip 0pt \RaggedRight}%
      {\leftskip \margintocnumwidth \rightskip \margintocpagenumwidth}%
      {\footnotesize\makebox[0pt][r]{\makebox[\margintocnumwidth][l]{\etocnumber}}\etocname\nobreak\leaders\hbox{\hbox to 1.5ex {\hss.\hss}}\hfill\rlap{\makebox[\margintocpagenumwidth][r]{\etocpage}}\par}%
      {\parskip 2.5pt}%
  % Set the global style of the toc
  \etocsettocstyle{\sffamily\normalfont\small\color{dblue}}{}%
  \etocsetnexttocdepth{subsection}%
      % Print the table of contents in the margin
      \begin{marginfigure}[#1] % the first parameter is needed!
          \localtableofcontents
      \end{marginfigure}
      \FloatBarrier%
  \endgroup%
}

%-------------------------------------------------------------------------------%

\titleformat{\chapter}{\Large\bfseries\filright}{}{1em}{\chapternumstyle{#1}}[\margintoc]
\titleformat{name=\chapter,numberless}{\Large\bfseries\filright}{}{1em}{\chapternonumstyle{#1}}[]

\assignpagestyle{\chapter}{empty}
\assignpagestyle{\part}{empty}
% \titlespacing{\chapter}{0pt}{0pt}{-50pt}
\titlespacing{\chapter}
{0pt} % left sep
{*0} % before sep % *n (n ex)
{3.5cm} % after sep
[0pt] % right sep
\makeatother

\titleformat{\section}{\color{dblue}\sffamily\bfseries} {\thesection.}{.5em}{#1}
\titleformat{name=\section,numberless}{\color{dblue}\sffamily\bfseries} {\thesection.}{.5em}{#1}
\titlespacing{\section}
{0pt} % left sep
{*2} % before sep % *n (n ex)
{*1} % after sep
[0pt] % right sep

\titleformat{\subsection}{\color{black}\normalsize\bfseries} {\thesubsection.}{.5em}{#1}
\titleformat{name=\subsection,numberless}{\color{black}\normalsize\bfseries} {\thesubsection.}{.5em}{#1}
\titlespacing{\subsection}
{0pt} % left sep
{*1.5} % before sep % *n (n ex)
{*.75} % after sep
[0pt] % right sep
% /* -------------------------------------------------------------------------- */

\newenvironment{importantbox}{%
  \begin{tcolorbox}[colback=allanred!15, colframe=allanred, arc=5pt, boxrule=0.7pt, left=15pt, right=15pt, top=10pt, bottom=10pt]%
  \small
}{%
  \end{tcolorbox}%
}
\newcounter{thm}[chapter] 
%note
\newtcolorbox[auto counter,number within=chapter,number format=\arabic]{prompt}[1][]{
	title={Prompt~\thetcbcounter},
	colframe=allancyan!50,
	colback=allancyan!10!white,
	boxed title style={colback=allancyan},
	overlay unbroken and first={
		\node[below right,font=\small,color=allancyan,text width=.8\linewidth]
		at (title.north east) {#1};
	}
}
%remark
\newtcolorbox[auto counter,number within=chapter,number format=\arabic]{remark}[1][]{
	title={Remark~\thetcbcounter},
	colframe=orange!80,
	colback=orange!5!white,
    fontupper=\itshape,
	boxed title style={colback=green},
	overlay unbroken and first={
		\node[below right,font=\small,color=orange,text width=.8\linewidth]
		at (title.north east) {#1};
	}
}
%keynote
\newtcolorbox[auto counter,number within=chapter,number format=\arabic]{Keynote}[1][]{
	title={Keynote~\thetcbcounter},
	colframe=red!50,
	colback=red!5!white,
    fontupper=\itshape,
	boxed title style={colback=red},
	overlay unbroken and first={
		\node[below right,font=\small,color=red,text width=.8\linewidth]
		at (title.north east) {#1};
	}
}
% Define Extension environment.
\makeatletter
\newtcbtheorem[number within=chapter]{Extension}{Extension}{enhanced,
    breakable,
    colback = tudelft-groen!8!white,
    frame hidden,
    borderline west = {2pt}{0pt}{tudelft-groen},
    coltitle = tudelft-groen,
    fonttitle = \bfseries\sffamily,
    boxrule = 0sp,
    sharp corners,
    detach title,
    before upper = \tcbtitle\par\smallskip,
    description font = \mdseries,
    separator sign none,
    segmentation style={solid, tudelft-groen},
    #1
}{ext}
\makeatother
%
% Define Example environment.
\makeatletter
\newtcbtheorem[number within=chapter]{Example}{Example}{enhanced,
    breakable,
    colback = tudelft-bosgroen!5!white,
    colframe = allangreen,
    coltitle = allangreen,
    fonttitle = \bfseries,
    boxrule = 1pt,
    sharp corners,
    detach title,
    before upper = \tcbtitle\par\smallskip,
    description font = \mdseries,
    separator sign none,
    description delimiters parenthesis,
    #1
}{ex}
\makeatother
%
% Define Theorem environment.
\makeatletter
\newtcbtheorem[number within=chapter]{Theorem}{Theorem}{
    enhanced,
    breakable,
    colback = tudelft-paars!4!white,
    frame hidden,
    borderline west = {2pt}{0pt}{tudelft-paars},
    coltitle = tudelft-paars,
    fonttitle = \bfseries\sffamily,
    boxrule = 0sp,
    sharp corners,
    detach title,
    before upper = \tcbtitle\par\smallskip,
    description font = \mdseries,
    separator sign none,
    segmentation style={solid, tudelft-paars},
    % 添加阴影设置
    drop shadow southeast, % 阴影方向为右下
    shadow={1mm}{-1mm}{1mm}{black!35!white}, % 阴影偏移和颜色
}{thm}

\makeatother
% Define Corollary environment.
\makeatletter
\newtcbtheorem[number within=chapter]{Corollary}{Corollary}{enhanced,
    breakable,
    colback = tudelft-roze!9!white,
    frame hidden,
    borderline west = {2pt}{0pt}{tudelft-roze},
    coltitle = tudelft-roze,
    fonttitle = \bfseries\sffamily,
    boxrule = 0sp,
    sharp corners,
    detach title,
    before upper = \tcbtitle\par\smallskip,
    description font = \mdseries,
    separator sign none,
    segmentation style={solid, tudelft-roze},
    #1
}{cor}
%
% Define Lemma environment.
\makeatletter
\newtcbtheorem[number within=chapter]{Lemma}{Lemma}{enhanced,
    breakable,
    colback = tudelft-rood!5!white,
    frame hidden,
    borderline west = {2pt}{0pt}{tudelft-rood},
    coltitle = tudelft-rood,
    fonttitle = \bfseries\sffamily,
    boxrule = 0sp,
    sharp corners,
    detach title,
    before upper = \tcbtitle\par\smallskip,
    description font = \mdseries,
    separator sign none,
    segmentation style={solid, tudelft-rood},
    #1
}{lem}
%
% Define Proposition environment.
\makeatletter
\newtcbtheorem[number within=chapter]{Proposition}{Proposition}{enhanced,
    breakable,
    colback = allanblue!8!white,
    frame hidden,
    borderline west = {2pt}{0pt}{allanblue},
    coltitle = allandarkblue,
    fonttitle = \bfseries\sffamily,
    boxrule = 0sp,
    sharp corners,
    detach title,
    before upper = \tcbtitle\par\smallskip,
    description font = \mdseries,
    separator sign none,
    segmentation style={solid, allanblue},
    #1
}{prp}
%
% Commands for tcolorbox environments.
\newcommand{\ext}[3]{\begin{Extension}{#1}{#2}#3\end{Extension}}
\newcommand{\ex}[3]{\begin{Example}{#1}{#2}#3\end{Example}}
\newcommand{\thm}[3]{\begin{Theorem}{#1}{#2}#3\end{Theorem}}
\newcommand{\cor}[3]{\begin{Corollary}{#1}{#2}#3\end{Corollary}}
\newcommand{\lem}[3]{\begin{Lemma}{#1}{#2}#3\end{Lemma}}
\newcommand{\prp}[3]{\begin{Proposition}{#1}{#2}#3\end{Proposition}}

\usepackage{listings}
\usepackage{xcolor}
\usepackage{multirow} % 用于支持多行单元格
\usepackage{tikz}
\usetikzlibrary{trees}
% 定义 MATLAB 代码样式
\lstdefinestyle{matlab}{
    language=Matlab,
    basicstyle=\ttfamily\small,
    keywordstyle=\color{blue}\bfseries,
    commentstyle=\color{green},
    stringstyle=\color{red},
    frame=single, % 外部线框
    rulecolor=\color{black}, % 线框颜色
    breaklines=true, % 自动换行
    numbers=left, % 行号位置
    numberstyle=\tiny\color{black}, % 行号样式
    captionpos=b % 标题位置
}












% /* -------------------------------------------------------------------------- */

\makeindex

\usepackage{bm}
 \newcommand{\bd}{\partial}
\newcommand{\bdd}{\overline{\partial}}
\newcommand{\pdd}[2][]{\frac{\partial #1}{\partial #2}}
\newcommand{\supp}{\operatorname{Supp}}
\newcommand{\xu}{\sqrt{-1}}
\newcommand{\lang}[1]{\left\langle #1\right\rangle}
\newcommand{\Line}{\noindent\tikz\draw[line width=0.65pt,gray!80,dashed] (0,0)--++(.99\linewidth,0);\par}
%---------------------------------
\newcommand{\fraka}{{\mathfrak a}}
\newcommand{\frakb}{{\mathfrak b}}
\newcommand{\frakc}{{\mathfrak c}}
\newcommand{\frakd}{{\mathfrak d}}
\newcommand{\frake}{{\mathfrak e}}
\newcommand{\frakf}{{\mathfrak f}}
\newcommand{\frakg}{{\mathfrak g}}
\newcommand{\frakh}{{\mathfrak h}}
\newcommand{\fraki}{{\mathfrak i}}
\newcommand{\frakj}{{\mathfrak j}}
\newcommand{\frakk}{{\mathfrak k}}
\newcommand{\frakl}{{\mathfrak l}}
\newcommand{\frakm}{{\mathfrak m}}
\newcommand{\frakn}{{\mathfrak n}}
\newcommand{\frako}{{\mathfrak o}}
\newcommand{\frakp}{{\mathfrak p}}
\newcommand{\frakq}{{\mathfrak q}}
\newcommand{\frakr}{{\mathfrak r}}
\newcommand{\fraks}{{\mathfrak s}}
\newcommand{\frakt}{{\mathfrak t}}
\newcommand{\fraku}{{\mathfrak u}}
\newcommand{\frakv}{{\mathfrak v}}
\newcommand{\frakw}{{\mathfrak w}}
\newcommand{\frakx}{{\mathfrak x}}
\newcommand{\fraky}{{\mathfrak y}}
\newcommand{\frakz}{{\mathfrak z}}
%---------------------------------
%---------------------------------
\newcommand{\frakA}{{\mathfrak A}}
\newcommand{\frakB}{{\mathfrak B}}
\newcommand{\frakC}{{\mathfrak C}}
\newcommand{\frakD}{{\mathfrak D}}
\newcommand{\frakE}{{\mathfrak E}}
\newcommand{\frakF}{{\mathfrak F}}
\newcommand{\frakG}{{\mathfrak G}}
\newcommand{\frakH}{{\mathfrak H}}
\newcommand{\frakI}{{\mathfrak I}}
\newcommand{\frakJ}{{\mathfrak J}}
\newcommand{\frakK}{{\mathfrak K}}
\newcommand{\frakL}{{\mathfrak L}}
\newcommand{\frakM}{{\mathfrak V}}
\newcommand{\frakN}{{\mathfrak N}}
\newcommand{\frakO}{{\mathfrak O}}
\newcommand{\frakP}{{\mathfrak P}}
\newcommand{\frakQ}{{\mathfrak Q}}
\newcommand{\frakR}{{\mathfrak R}}
\newcommand{\frakS}{{\mathfrak S}}
\newcommand{\frakT}{{\mathfrak T}}
\newcommand{\frakU}{{\mathfrak U}}
\newcommand{\frakV}{{\mathfrak V}}
\newcommand{\frakW}{{\mathfrak W}}
\newcommand{\frakX}{{\mathfrak X}}
\newcommand{\frakY}{{\mathfrak Y}}
\newcommand{\frakZ}{{\mathfrak Z}}
%---------------------------------
%---------------------------------
\newcommand{\bA}{{\mathbb A}}
\newcommand{\bB}{{\mathbb B}}
\newcommand{\bC}{{\mathbb C}}
\newcommand{\bD}{{\mathbb D}}
\newcommand{\bE}{{\mathbb E}}
\newcommand{\bF}{{\mathbb F}}
\newcommand{\bG}{{\mathbb G}}
\newcommand{\bH}{{\mathbb H}}
\newcommand{\bI}{{\mathbb I}}
\newcommand{\bJ}{{\mathbb J}}
\newcommand{\bK}{{\mathbb K}}
\newcommand{\bL}{{\mathbb L}}
\newcommand{\bM}{{\mathbb M}}
\newcommand{\bN}{{\mathbb N}}
\newcommand{\bO}{{\mathbb O}}
\newcommand{\bP}{{\mathbb P}}
\newcommand{\bQ}{{\mathbb Q}}
\newcommand{\bR}{{\mathbb R}}
\newcommand{\bS}{{\mathbb S}}
\newcommand{\bT}{{\mathbb T}}
\newcommand{\bU}{{\mathbb U}}
\newcommand{\bV}{{\mathbb V}}
\newcommand{\bW}{{\mathbb W}}
\newcommand{\bX}{{\mathbb X}}
\newcommand{\bY}{{\mathbb Y}}
\newcommand{\bZ}{{\mathbb Z}}
%---------------------------------
%---------------------------------
\newcommand{\mA}{{\mathcal A}}
\newcommand{\mB}{{\mathcal B}}
\newcommand{\mC}{{\mathcal C}}
\newcommand{\mD}{{\mathcal D}}
\newcommand{\mE}{{\mathcal E}}
\newcommand{\mF}{{\mathcal F}}
\newcommand{\mG}{{\mathcal G}}
\newcommand{\mH}{{\mathcal H}}
\newcommand{\mI}{{\mathcal I}}
\newcommand{\mJ}{{\mathcal J}}
\newcommand{\mK}{{\mathcal K}}
\newcommand{\mL}{{\mathcal L}}
\newcommand{\mM}{{\mathcal V}}
\newcommand{\mN}{{\mathcal N}}
\newcommand{\mO}{{\mathcal O}}
\newcommand{\mP}{{\mathcal P}}
\newcommand{\mQ}{{\mathcal Q}}
\newcommand{\mR}{{\mathcal R}}
\newcommand{\mS}{{\mathcal S}}
\newcommand{\mT}{{\mathcal T}}
\newcommand{\mU}{{\mathcal U}}
\newcommand{\mV}{{\mathcal V}}
\newcommand{\mW}{{\mathcal W}}
\newcommand{\mX}{{\mathcal X}}
\newcommand{\mY}{{\mathcal Y}}
\newcommand{\mZ}{{\mathcal Z}}
%---------------------------------
%---------------------------------
\newcommand{\sA}{{\mathscr A}}
\newcommand{\sB}{{\mathscr B}}
\newcommand{\sC}{{\mathscr C}}
\newcommand{\sD}{{\mathscr D}}
\newcommand{\sE}{{\mathscr E}}
\newcommand{\sF}{{\mathscr F}}
\newcommand{\sG}{{\mathscr G}}
\newcommand{\sH}{{\mathscr H}}
\newcommand{\sI}{{\mathscr I}}
\newcommand{\sJ}{{\mathscr J}}
\newcommand{\sK}{{\mathscr K}}
\newcommand{\sL}{{\mathscr L}}
\newcommand{\sM}{{\mathscr V}}
\newcommand{\sN}{{\mathscr N}}
\newcommand{\sO}{{\mathscr O}}
\newcommand{\sP}{{\mathscr P}}
\newcommand{\sQ}{{\mathscr Q}}
\newcommand{\sR}{{\mathscr R}}
\newcommand{\sS}{{\mathscr S}}
\newcommand{\sT}{{\mathscr T}}
\newcommand{\sU}{{\mathscr U}}
\newcommand{\sV}{{\mathscr V}}
\newcommand{\sW}{{\mathscr W}}
\newcommand{\sX}{{\mathscr X}}
\newcommand{\sY}{{\mathscr Y}}
\newcommand{\sZ}{{\mathscr Z}}
%---------------------------------
%------------------------- end list of symbols --------------
\usepackage{joinbox} % images side by side
\usepackage{physics}
\RequirePackage{bropd}
\theoremstyle{plain}
\newtheorem{theorem}[thm]{Theorem}
\newtheorem{lemma}[thm]{Lemma}
\newtheorem{corollary}[thm]{Corollary}
\newtheorem{proposition}[thm]{Proposition}

\theoremstyle{definition}
\newtheorem{construction}[thm]{Construction}
\newtheorem{notations}[thm]{Notations}
\newtheorem{question}[thm]{Question}
\newtheorem{claim}[thm]{Claim}
\newtheorem{assumption}[thm]{Assumption}
\newtheorem{assumptions}[thm]{Assumptions}
\newtheorem{properties}[thm]{Properties}
\newtheorem{example}[thm]{Example}
\newtheorem{comments}[thm]{Comments}
\newtheorem{blank}[thm]{}
\newtheorem{observation}[thm]{Observation}
\newtheorem{defn-thm}[thm]{Definition-Theorem}
\newtheorem{conjecture}[thm]{Conjecture}
\usepackage{extarrows}

\endinput