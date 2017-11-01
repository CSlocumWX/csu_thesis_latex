% Name: csuthesis class
% Purpose: Try to conform to the current CSU Grad School formatting flavor of
% the semester.
%
% History:
%   2009     -- Ankur Dave's creating your own LaTex class information
%               under CC-GNU GPL version 2.0. Presumably, the taken from
%               http://ankurdave.com/tex/
%   20121101 -- Leif Anderson in the CSU developed a crude foundation
%               for the csuthesis class.
%   20130101 -- Christopher Slocum greatly modified the work to fix some
%               known problem and to change the class to conform to 
%               American Meteorological Standards. The AMS LaTex template
%               provided a starting point. AMS is referred to as ametsoc in the
%               comments to avoid confusion.
%   20131020 -- Christopher Slocum fixed issues related to ToC and added more
%               ametsoc requirements.
%   20131108 -- Christopher Slocum fixed issues with spacing and ToC
%   20170825 -- Christopher Slocum fixed the hyperlink issues
%               Updated chapter, section, subsection, subsubsection format
%               Added font size, font family, and url color options
%               Came up with a better way to do the TOC
%               Updated Appendix formatting so that it matches AMS style

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{csuthesis}[2017/08/25 CSU thesis and disseration class]

% documentclass options
\newif\ifphd \phdtrue
\DeclareOption{masters}{\phdfalse}
\newif\ifmasterofscience \masterofsciencetrue
\DeclareOption{nonscience}{\masterofsciencefalse}
\newif\ifhyperref \hyperreffalse
\DeclareOption{hyperref}{\hyperreftrue}
\newif\ifblue \bluefalse
\DeclareOption{blue}{\bluetrue}
\newif\iftimes \timesfalse
\DeclareOption{times}{\timestrue}
\newif\ifsmallfoot \smallfootfalse
\DeclareOption{smallfoot}{\smallfoottrue}
\newif\iflinenumbers \linenumbersfalse
\DeclareOption{linenumbers}{\linenumberstrue}
\newif\ifnocopyright \nocopyrightfalse
\DeclareOption{nocopyright}{\nocopyrighttrue}
\def\@@ptsize{12pt}
\DeclareOption{10pt}{\def\@@ptsize{10pt}}
\DeclareOption{11pt}{\def\@@ptsize{11pt}}
\DeclareOption{12pt}{\def\@@ptsize{12pt}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{amsbook}}
\ProcessOptions\relax
% read in amsbook
\LoadClass[\@@ptsize, oneside, reqno]{amsbook}  % amsbook provides the foundation
                                           % for the thesis class. amsbook does
                                           % not play nice with some LaTex
% parse preamble input
\makeatletter
    \global \let \@author \@empty 
    \global \let \@date \@empty 
    \global \let \@title \@empty
    \global \let \@departmentname \@empty
    \global \let \@gradterm \@empty
    \global \let \@gradyear \@empty
    \global \let \@advisor \@empty

    \newcommand{\committee}[1]{\gdef\@committee{\xandlist{\\ \> }{ and }{\\ \>}{#1}}}
    \newcommand{\@committee}{\@latex@warning@no@line{No \noexpand\committee given}}

    \def\author#1{\gdef\@author{#1}}
    \def\@author{\@latex@warning@no@line{No \noexpand\author given}}
    \def\departmentname#1{\gdef\@departmentname{#1}}
    \def\gradterm#1{\gdef\@gradterm{#1}}
    \def\gradyear#1{\gdef\@gradyear{#1}}
    \def\advisor#1{\gdef\@advisor{#1}}
    \def\coadvisor#1{\gdef\@coadvisor{#1}}
\makeatother
% basic page formatting
\RequirePackage[dvips, letterpaper, heightrounded, textwidth=6.5in, textheight=9.0in, top=1in, left=1in,
                foot=0.5in, lmargin=1in, rmargin=1in, tmargin=1in, bmargin=1in, footskip=0.5in]{geometry}
\topskip=9pt
\RequirePackage{indentfirst}
% set double spacing
\RequirePackage[doublespacing]{setspace}
% page headings and numbering
\makeatletter
    \def\ps@plain{\ps@empty
     \def\@evenfoot{%
       \normalfont\ifsmallfoot\scriptsize\else\footnotesize\fi
       \centerline{\thepage}
       }%
     \def\@oddfoot{%
       \normalfont\ifsmallfoot\scriptsize\else\footnotesize\fi
       \centerline{\thepage}}
    }
    \pagestyle{plain}
\makeatother

% import graphics
\RequirePackage{graphicx}
\RequirePackage{float}

% math stuff
\DeclareMathAlphabet{\CMcal}{OMS}{cmsy}{m}{n}
\RequirePackage{amsmath}
\RequirePackage{mathtools}
\RequirePackage[utopia]{mathdesign}
% you can pick your favorite font below,
% but leave mathdesign because it loads other features
\iftimes
    \RequirePackage{mathptmx}
\fi

% Citations and in page references
\RequirePackage{natbib}
\bibpunct{(}{)}{;}{a}{}{,}
\RequirePackage{url}
\RequirePackage{xcolor}
\ifhyperref
    \RequirePackage[breaklinks=true]{hyperref}
    \ifblue
        \hypersetup{
            colorlinks,
            linkcolor={black},
            citecolor={blue!80!black},
            urlcolor={blue!80!black}
        }
    \else
        \hypersetup{
            colorlinks,
            linkcolor={black},
            citecolor={black},
            urlcolor={black}
        }
    \fi
    \newcommand*{\doi}[1]{\href{http://dx.doi.org/\detokenize{#1}}{doi: \detokenize{#1}}}
\fi


\RequirePackage[pdftex]{lscape}

%%%%%%%%%%%%%%%%%%%%%%%%
%
%           customizing the table of contents appearance
%
%%%%%%%%%%%%%%%%%%%%%%
\DeclareRobustCommand{\gobblefour}[4]{}
\newcommand*{\SkipTocEntry}{\addtocontents{toc}{\gobblefour}}
\makeatletter
\def\l@figure{\@tocline{0}{0,0pt}{0pc}{9mm}{\ \ }}
\def\l@table{\@tocline{0}{0,0pt}{0pc}{9mm}{\ \ }}
\makeatletter
\renewcommand{\contentsname}{Table of Contents}
\renewcommand{\bibname}{\MakeUppercase{References}}

%%%%%%%%
%
% Chapter "Primary" Headings
%
%%%%%%%%

\def\@makechapterhead#1{\global\topskip .625in\relax
  \begingroup
    \normalsize\normalfont\scshape\bfseries\centering
    \ifnum\c@secnumdepth>\m@ne
      \leavevmode \hskip-\leftskip
      \rlap{\vbox to\z@{\vss
          \centerline{\normalsize\mdseries
              \uppercase\@xp{\chaptername}\enspace\thechapter}
          \vskip 3pc}}\hskip\leftskip\fi
     \normalsize#1\par \endgroup
  \skip@34\p@ \advance\skip@-\normalbaselineskip
  \vskip\skip@ }
\def\@makeschapterhead#1{\global\topskip .625in\relax
  \begingroup
  \normalsize\normalfont\scshape\bfseries\centering
  #1\par \endgroup
  \skip@34\p@ \advance\skip@-\normalbaselineskip
  \vskip\skip@ }
\def\@makescsuhead#1{\global\topskip 0pc\relax
    \begingroup
  \normalsize\normalfont\centering
  \MakeUppercase{#1}\par~\\ \endgroup
  \skip@34\p@ \advance\skip@-\normalbaselineskip
  \vskip\skip@ }
\def\@starttoc#1#2{%
  \begingroup
  \setTrue{#1}%
  \let\secdef\@gobbletwo \chapter
  \let\@secnumber\@empty 
  \ifx\contentsname#2%
  \else \@tocwrite{chapter}{#2}\fi
  \typeout{#2}\@xp\chaptermark\@xp{#2}%
  \@makescsuhead{#2}\@afterheading
  \parskip\z@skip
  \makeatletter
  \@input{\jobname.#1}%
  \if@filesw
  \@xp\newwrite\csname tf@#1\endcsname
    \immediate\@xp\openout\csname tf@#1\endcsname \jobname.#1\relax
  \fi
  \global\@nobreakfalse \endgroup
  \newpage
}

%%%%%%%%
%
% Section, subsection, and subsubsection headings
%
%%%%%%%%
\def\section{\@startsection{section}{1}%
  \z@{.7\linespacing\@plus\linespacing}{.5\linespacing}%
  {\normalfont\scshape}}
\def\subsection{\@startsection{subsection}{2}%
  \z@{.7\linespacing\@plus\linespacing}{.5\linespacing}%
  {\normalfont\it}}
\def\subsubsection{\@startsection{subsubsection}{3}%
  \z@{.7\linespacing\@plus\linespacing}{.5\linespacing}%
  {\normalfont\it}}

% AMS style for Figures and Tables
\renewcommand{\figurename}{\textsc{Fig.}}
\renewcommand{\tablename}{\textsc{Table}}
\renewcommand{\thefigure}{\arabic{figure}}
\renewcommand{\thetable}{\arabic{table}}
\renewcommand{\appendixname}{Appendix}

%%% Figure and Table caption formatting
\RequirePackage[margin=0.15in]{caption}
\setlength\abovecaptionskip{10\p@}
\setlength\belowcaptionskip{5\p@}


% section, table, figure, and equation nummbering
\numberwithin{table}{chapter}
\numberwithin{figure}{chapter}
\numberwithin{section}{chapter}
\numberwithin{equation}{chapter}


\renewcommand\bibsection{\centering\bibname\addcontentsline{toc}{chapter}{References} ~\\ ~\\}{}
\makeatother

%dotted line for TOC.  This is the definition of \@tocline, copied out of amsbook.
\makeatletter
\def\@tocline#1#2#3#4#5#6#7{\relax
  \ifnum #1>\c@tocdepth % then omit
  \else
    \par \addpenalty\@secpenalty\addvspace{#2}%
    \begingroup \hyphenpenalty\@M
    \@ifempty{#4}{%
      \@tempdima\csname r@tocindent\number#1\endcsname\relax
    }{%
      \@tempdima#4\relax
    }%
    \parindent\z@ \leftskip#3\relax \advance\leftskip\@tempdima\relax
    \rightskip\@pnumwidth plus4em \parfillskip-\@pnumwidth
    #5\leavevmode\hskip-\@tempdima #6\nobreak\relax
    \dotfill\hbox to\@pnumwidth{{\normalfont\@tocpagenum{#7}}}\par % the dotfill makes a dotted line across to the page number.
    \nobreak
    \endgroup
  \fi}
\makeatother

%%%%%%%%%%%%%
% abstract
%%%%%%%%%%%%%

\makeatletter
\renewenvironment{abstract}{%
    \ifx\maketitle\relax
        \ClassWarning{\@classname}{Abstract should precede
            \protect\maketitle\space in CSU Thesis document class; reported}%
    \fi
    \global\setbox\abstractbox=\vtop
    {\fontsize{12}{14}\selectfont
    \bgroup
    \begin{center}\begin{singlespace}{\uppercase{Abstract}}\\ ~\\\end{singlespace}
    {\MakeUppercase{\@title}}
    \end{center}%blank line below here so the abstract starts indented.
    }
}{%
\endlist\egroup
\ifx\@setabstract\relax \@setabstracta \fi
}

%%%%%%%%%%%%%
% acknowledgements
%%%%%%%%%%%%%
\newbox\ackbox
\newenvironment{acknowledgments}{%
  \ifx\maketitle\relax
    \ClassWarning{\@classname}{Acknowledgments should precede
      \protect\maketitle\space in the csuthesis class; reported}%
  \fi
  \global\setbox\ackbox=\vtop
  {\fontsize{12}{14}\selectfont
  \bgroup
    \begin{center}{\uppercase{Acknowledgments}}\end{center}
    }
    
}{
  \endlist\egroup
  \ifx\@setack\relax \@setacka \fi
}
\def\@setack{\@setacka \global\let\@setack\relax}
\def\@setacka{%
  \ifvoid\ackbox
  \else
    \skip@20\p@ \advance\skip@-\lastskip
    \advance\skip@-\baselineskip \vskip\skip@
    \box\ackbox
    \prevdepth\z@ % because \abstractbox is a vtop
  \fi
}



%%%%%%%%%%%%%
% dedication
%%%%%%%%%%%%%

\newbox\dedbox
\newenvironment{dedication}{%
  \ifx\maketitle\relax
    \ClassWarning{\@classname}{dedication should precede
      \protect\maketitle\space in the csuthesis class; reported}%
  \fi
  \global\setbox\dedbox=\vtop
  {\fontsize{12}{14}\selectfont
  \bgroup
    \begin{center}{\uppercase{Dedication}}\end{center}
    }
}{%
  \endlist\egroup
  \ifx\@setded\relax \@setdeda \fi
}
\def\@setded{\@setdeda \global\let\@setded\relax}
\def\@setdeda{%
  \ifvoid\dedbox
  \else
    \skip@20\p@ \advance\skip@-\lastskip
    \advance\skip@-\baselineskip \vskip\skip@
    \box\dedbox
    \prevdepth\z@ % because \abstractbox is a vtop
  \fi
}



%%%%%%%%%%%%%
% Title Page
%%%%%%%%%%%%%
\renewcommand{\maketitle}{%
    \begin{titlepage}
        \begin{center}{\fontsize{12}{14}\selectfont
            \ifphd
                \MakeUppercase{Dissertation}
            \else
                \MakeUppercase{Thesis}
            \fi
            ~\vfill
            {\MakeUppercase{\@title}}
            ~\vfill
            Submitted by \\
            \ifx @author \@empty
                \relax% Look, error handling!
            \else
                \@author \\
            \fi

            \ifx\@empty\@departmentname
                \MakeUppercase{Department Name not defined}
            \else
                Department of \@departmentname
            \fi

            ~\vfill
            In partial fulfillment of the requirements \\
            \ifphd
                For the Degree of Doctor of Philosophy \\ % The inconsistent capitalization between this line and the previous is required by the graduate school.
            \else
                \ifmasterofscience
                    For the Degree of Master of Science \\
                \else
                    For the Degree of Master of the Arts \\
                \fi
            \fi
            Colorado State University \\
            Fort Collins, Colorado \\
            \ifx\@gradterm\@empty
                \MakeUppercase{gradterm not defined}
            \else
                \ifx\@gradyear\@empty
                    \MakeUppercase{gradyear not defined}
                \else
                    \@gradterm~\@gradyear
                \fi
            \fi
            ~\vfill
        }\end{center}
        \begin{singlespace}{\fontsize{12}{14}\selectfont
            \ifphd
                Doctoral Committee:\\
            \else
                Master's Committee:\\
            \fi
            % blank line
            \begin{tabbing}
                \hspace*{0.5in}\=
                % Indent, still left:
                Advisor: \@advisor \\ \>
                \ifx\@coadvisor\undefined
                    \relax
                \else
                    Co-Advisor: \@coadvisor \\
                \fi
                % blank line
                ~\\ \> %
                \@committee
            \end{tabbing}
        }\end{singlespace}
    \end{titlepage}
    \ifnocopyright
        \relax
    \else
        % Make a copyright page
        \thispagestyle{empty}
        \vspace*{\fill}
        \begin{center}
            {\fontsize{12}{14}\selectfont Copyright by \@author~\@gradyear \\ All Rights Reserved}
        \end{center}
        \vspace*{\fill}
        \clearpage
    \fi
    \setcounter{page}{2} %the copyright page is not assigned a number nor counted
        \clearpage
        \addcontentsline{toc}{chapter}{{Abstract}}
        \unvbox\abstractbox
    \ifvoid\ackbox
    \else
        \clearpage
        \unvbox\ackbox
        \addcontentsline{toc}{chapter}{{Acknowledgments}}
    \fi
    % Dedication
    \ifvoid\dedbox
    \else
        \clearpage
        \unvbox\dedbox
        \addcontentsline{toc}{chapter}{{Dedication}}
    \fi
}

%%%%%%%%%%%%
%% Appendix


\newif\iffirstappendix
\renewenvironment{appendix}[1][1]%
{\vskip12pt\pagebreak[3]
    \ifthenelse{\equal{#1}{1}}%
    {\setcounter{chapter}{0}% reset counter
        \renewcommand\thechapter{A}
        \renewcommand\theequation{\thechapter\arabic{equation}}%
        \setcounter{equation}{0}% reset counter
        \setcounter{figure}{0}% reset counter
        \setcounter{table}{0}% reset counter
        \renewcommand\thefigure{\thechapter\arabic{figure}}
        \renewcommand\thetable{\thechapter\arabic{table}}
        \setcounter{section}{0}% reset counter
        \setcounter{subsection}{0}% reset counter
        \renewcommand\thesection{\thechapter\arabic{section}}
        \renewcommand\thesubsection{\thechapter\arabic{subsection}}
        \begin{center}%
        {\textnormal APPENDIX}%
        \end{center}}
    {
        \setcounter{chapter}{0}% reset counter
        \renewcommand\thechapter{#1}
        \setcounter{equation}{0}% reset counter
        \renewcommand\theequation{{\thechapter}\arabic{equation}}%
        \setcounter{section}{0}% reset counter
        \setcounter{subsection}{0}% reset counter
        \renewcommand\thefigure{\thechapter\arabic{figure}}
        \renewcommand\thetable{\thechapter\arabic{table}}
        \renewcommand\thesection{\thechapter\arabic{section}}
        \renewcommand\thesubsection{\thechapter\arabic{subsection}}
        \begin{center}%
            {\textnormal APPENDIX \thechapter}% 
        \end{center}}
}%

\long\def\appendixtitle#1{{\centering\bf\scshape #1\vskip1pt}{\addcontentsline{toc}{chapter}{\appendixname~\thechapter.~~ #1}}}

\makeatother

\RequirePackage{lineno}
\newcommand*\patchAmsMathEnvironmentForLineno[1]{%
  \expandafter\let\csname old#1\expandafter\endcsname\csname #1\endcsname
  \expandafter\let\csname oldend#1\expandafter\endcsname\csname end#1\endcsname
  \renewenvironment{#1}%
     {\linenomath\csname old#1\endcsname}%
     {\csname oldend#1\endcsname\endlinenomath}}% 
\newcommand*\patchBothAmsMathEnvironmentsForLineno[1]{%
  \patchAmsMathEnvironmentForLineno{#1}%
  \patchAmsMathEnvironmentForLineno{#1*}}%
\AtBeginDocument{%
\patchBothAmsMathEnvironmentsForLineno{equation}%
\patchBothAmsMathEnvironmentsForLineno{align}%
\patchBothAmsMathEnvironmentsForLineno{flalign}%
\patchBothAmsMathEnvironmentsForLineno{alignat}%
\patchBothAmsMathEnvironmentsForLineno{gather}%
\patchBothAmsMathEnvironmentsForLineno{multline}%
\patchBothAmsMathEnvironmentsForLineno{eqnarray}%
}
\iflinenumbers
    \linenumbers
\fi
