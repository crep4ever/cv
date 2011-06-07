%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File :   cv.cls
% Author : Romain Goffe <romain.goffe@gmail.com>
% Date :   06/07/2011
% Description : LaTeX class for curriculum vitae
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cv}[2011/06/07]
\LoadClass[french,a4paper,skipsamekey,revbib]{curve}

%font
\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}
\RequirePackage[english,frenchb]{babel}
\RequirePackage{pifont}
\RequirePackage{palatino}
\RequirePackage{inconsolata}

%layout
\RequirePackage[a4paper,nohead,nofoot,hmargin=1.5cm,vmargin=1.5cm]{geometry}

%graphics
\RequirePackage{graphicx}
\RequirePackage{xcolor}

%hyperref
\definecolor{tango-green-1}{HTML}{8ae234}
\definecolor{tango-green-3}{HTML}{4e9a06}
\definecolor{tango-blue-3}{HTML}{204a87}
\definecolor{tango-red-3}{HTML}{a40000}
\definecolor{green1}{HTML}{d1e4ae}

\RequirePackage[pdftex,
  hyperindex=true,
  pdfpagelabels,
  bookmarks,
  bookmarksopen,
  colorlinks=true,
  linkcolor=tango-red-3,
  citecolor=tango-green-3,
  urlcolor=tango-blue-3]{hyperref}

%-----------------------------------------------------------------------
%figures
\graphicspath{ {img/} }

%-----------------------------------------------------------------------
%metadata
\hypersetup{%
  pdfauthor = {Romain Goffe},%
  pdftitle = {Curriculum Vitae},%
  pdfkeywords = {},%
  pdfcreator = {PDFLaTeX},%
  pdfproducer = {PDFLaTeX}%
}

%-----------------------------------------------------------------------
%headers
\rightheader{~}
\headerscale{.55}

%-----------------------------------------------------------------------
%titles
\titlefont{\bfseries\Large}
\subtitlefont{\bfseries\large}
\rubricfont{\bfseries\scshape\LARGE}
\subrubricfont{\fontfamily{pag}\selectfont\bfseries\itshape\large}
\keyfont{\fontfamily{pag}\selectfont\bfseries}

\prefix{\ding{52}}
\continuedname{~~(suite)}

%-----------------------------------------------------------------------
%rubrics
\pagestyle{empty}

%%spaces
\setlength\rubricspace{20pt}
\setlength\subrubricbeforespace{20pt}
\setlength\subrubricspace{3pt}

\makeatletter
% underline h1 titles
\def\@@rubrichead#1{%
  \@rubricfont%
  \makebox[0pt][l]{\raisebox{-0.3cm}{\colorbox{green1}{\makebox[\linewidth-2\fboxsep]{}}}}%
  \vspace{0.1cm}\makebox[\linewidth-2\fboxsep][l]{#1}}
\@subrubricmark{#1}
% small box before h2 titles
\iffalse
\def\@@rubrichead#1{%
  \@rubricfont%
  \makebox[0pt][l]{\rule[0mm]{\linewidth}{3cm}}%
  \makebox[\linewidth-2\fboxsep][c]{#1}}
\fi
\def\@@subrubric#1{%
  \rule{0bp}{\@beforespace}
       {\@subrubricfont%
         \makebox[0pt][l]{{\colorbox{green1}{\makebox{\textcolor{green1}{I}}}}}%
         \vspace{0.1cm}\makebox[\linewidth-2\fboxsep][l]{~~~~#1}}
       \@subrubricmark{#1}}
\makeatother

%-----------------------------------------------------------------------
%columns
\makeatletter
\def\mymulticol{\@nextentry\noalign{\gdef\@nextentry{}}
  \multicolumn}
\makeatother

%-----------------------------------------------------------------------
%tabular
\renewcommand{\arraystretch}{1.2}

%-----------------------------------------------------------------------
%macros
\newcommand{\detail}[1]{%
  \begin{footnotesize}%
    \emph{~~#1}%
  \end{footnotesize}%
}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
