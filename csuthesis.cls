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
%   20180225 -- Christopher Slocum removed the geometry package, made
%               page number spacing dynamic, fixed headings, and cleaned
%               up the class file so that it is easier to follow
%
% Options for the documentclass
% =============================
% masters
% -------
%   including 'masters' will change 'Doctor of Philosophy'
%   to 'Master of Science' for the degree
%
% 10pt, 11pt, 12pt
% ----------------
%   The title page, copyright page, and abstract are fixed at 12pt,
%   but you can change the body to one of three options
%
% times
% -----
%   Adobe Systems Utopia (1989) is the default serif font. Using
%   times will load mathptmx
%
% hyperref
% --------
%   enables inpage links (including the DOI). Can mess up the
%   table of contents, so make sure to double check
%
% blue
% ----
%   makes the text for urls and references blue rather than black
%   requires the hyperref option
%
% smallfoot
% ---------
%   makes the page number scriptsize rather than footnotesize
%
% linenumbers
% -----------
%   if you want linenumbers, you can have linenumbers
%
% nocopyright
% -----------
%   CSU now requires the copyright page. If this changes, nocopyright
%   restores old format

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{csuthesis}[2018/02/25 CSU thesis and disseration class]

%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Document class options
%
%%%%%%%%%%%%%%%%%%%%%%
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
%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Load amsbook class
%
%%%%%%%%%%%%%%%%%%%%%%%%
\LoadClass[\@@ptsize, oneside, reqno]{amsbook}  % amsbook provides the foundation
                                                % for the thesis class. amsbook does
                                                % not play nice with some LaTeX commands :(
%%%%%%%%%%%%%%%%%%%%%%%%
%
%    parse preamble input
%
%%%%%%%%%%%%%%%%%%%%%%%%
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

%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Page layout/formatting
%
%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage{indentfirst}
\RequirePackage[doublespacing]{setspace}
% getting the page number placement right.
% 0.5 in is 36 pts. We subtract the font size and add some back
% to find the footskip value
\newlength{\footskipamount}
\ifsmallfoot
    \makeatletter
        \setlength{\footskipamount}{33pt minus \@@ptsize \relax}
    \makeatother
\else
    \makeatletter
        \setlength{\footskipamount}{33pt minus \@@ptsize \relax}
    \makeatother
\fi

% Setting the page
% Creates one inch margins around the edges of the document
\pdfpagewidth 8.5in
\pdfpageheight 11in
\headheight 0pt
\headsep 0pt
\footskip \footskipamount  % puts page number 0.5 in below text (e.g., 0.5in from bottom of page)
\marginparwidth 0pt
\marginparsep 0pt
\oddsidemargin \dimexpr 1in -1in
\topmargin \dimexpr 1in -1in
\textwidth \dimexpr \pdfpagewidth -2\oddsidemargin -2in
\textheight \dimexpr \pdfpageheight -2\topmargin -2in
% Penalties to control the behavior of orphans and widows
% The higher the values, the more important it is for LaTeX
% to follow the penalty. 150 to 500 are pretty high values and
% 10000 is the maximum allowed value for the penalties.
% See https://tex.stackexchange.com/a/51264 for more details
% on penalty optins within LaTeX
\clubpenalty=10000
\widowpenalty=10000
% The penalties above handle how the bottom of the document appears for
% the most part. \raggedbottom ends up mostly influencing footnote placement.
% For this reason, I switched back to \flushbottom.
%\raggedbottom
\flushbottom

% set page heading style (plain) and page numbering size
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

% math and symbol packages
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
    % This turns doi entries in the references to links
    \newcommand*{\doi}[1]{\href{http://dx.doi.org/\detokenize{#1}}{doi: \detokenize{#1}}}
\fi

\RequirePackage[pdftex]{lscape}
%%%%%%%%%%%%%%%%%%%%%%%%
%
%  customizing the table of contents appearance excluding the heading
%
%%%%%%%%%%%%%%%%%%%%%%
\DeclareRobustCommand{\gobblefour}[4]{}
\newcommand*{\SkipTocEntry}{\addtocontents{toc}{\gobblefour}}
\makeatletter
    %\@tocline{<level>}{<space above>}{<indent from left margin>}{<hang indent>}{<font attributes>}
    \def\l@figure{\@tocline{0}{0pt}{-1.5mm}{11mm}{\ \ }}
    \def\l@table{\@tocline{0}{0pt}{-1.5mm}{11mm}{\ \ }}
    % adding more space between numbers and dots
    % http://mirrors.concertpass.com/tex-archive/macros/latex/contrib/tocloft/tocloft.pdf
    \renewcommand{\@pnumwidth}{2em}  % default value is 1.55 em
    \renewcommand{\@tocrmarg}{2.55em}  % default value is 2.55 em
\makeatletter
\renewcommand{\contentsname}{Table of Contents}
\renewcommand{\bibname}{\MakeUppercase{References}}

%%%%%%%%
%
% Chapter "Primary" Headings
%
%%%%%%%%
\def\@makechapterhead#1{\global\topskip 0.5in\relax
  \begingroup
    \normalsize\normalfont\scshape\bfseries\centering
    \ifnum\c@secnumdepth>\m@ne
      \leavevmode \hskip-\leftskip
      \rlap{\vbox to\z@{\vss
          \centerline{\normalsize\mdseries
          \uppercase\@xp{\chaptername}\enspace\thechapter}
          \vskip 3em}}
     \hskip\leftskip\fi
     \normalsize#1\par
  \endgroup
  \skip@ 3em \advance\skip@-\normalbaselineskip
  \vskip\skip@ }

\def\@makescsuhead#1{\global\topskip 0pc\relax
    \begingroup
        \normalsize\normalfont\centering
        \MakeUppercase{#1}\par
        \skip@ 3em \advance\skip@-\normalbaselineskip
        \vskip\skip@
    \endgroup}

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

%%%%%%%%
%
% Figure and table formatting
%
%%%%%%%%
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
        \rightskip\@pnumwidth plus 4em \parfillskip-\@pnumwidth
        #5\leavevmode\hskip-\@tempdima #6\nobreak\relax
        \dotfill\hbox to\@pnumwidth{{\normalfont\@tocpagenum{#7}}}\par % the dotfill makes a dotted line across to the page number.
        \nobreak
        \endgroup
      \fi}
\makeatother


%%%%%%%%%%%%%
%
%   Special pages
%
%%%%%%%%%%%%%
\makeatletter
    %%%%%%%%%%%%%
    % abstract
    %%%%%%%%%%%%%
    \renewenvironment{abstract}{%
        \ifx\maketitle\relax
            \ClassWarning{\@classname}{Abstract should precede
                \protect\maketitle\space in CSU Thesis document class; reported}%
        \fi
        \global\setbox\abstractbox=\vtop
        {%\fontsize{12}{14}\selectfont
        \bgroup
            \begin{center}
                \begin{singlespace}
                    {\normalsize\uppercase{Abstract}}\par
                    \skip@ 3em \advance\skip@-\normalbaselineskip
                    \vskip\skip@
                \end{singlespace}
                    {\MakeUppercase{\@title}}\par
                    \skip@ 3em \advance\skip@-\normalbaselineskip
                    \vskip\skip@
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
      {
      \bgroup
          \begin{center}
              {\normalsize\uppercase{Acknowledgments}}
          \end{center}
          \par\skip@ 3em \advance\skip@-\normalbaselineskip
          \vskip\skip@
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
      {
      \bgroup
          \begin{center}
              {\normalsize\uppercase{Dedication}}
          \end{center}
          \par\skip@ 3em \advance\skip@-\normalbaselineskip
          \vskip\skip@
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
    %%%%%%%%%%%%%
    % Copyright page
    %%%%%%%%%%%%%
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
    %%%%%%%%%%%%%
    % Add the Abstract, Acknowledgements, and Dedication pages to the Table of Contents
    %%%%%%%%%%%%%
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

\makeatother

%%%%%%%%%%%%
%
% Appendix formatting
%
%%%%%%%%%%%%
\newif\iffirstappendix
\renewenvironment{appendix}[1][1]%
{\vskip0em\pagebreak[3]
    \ifthenelse{\equal{#1}{1}}%
    %%%%%%%%%%%%%
    % Single appendix
    %%%%%%%%%%%%%
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
            {\textnormal APPENDIX\vskip1em%
        }
        \end{center}
    }
    %%%%%%%%%%%%%
    % Multiple appendices
    %%%%%%%%%%%%%
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
            {\textnormal APPENDIX \thechapter\vskip1em}%
        \end{center}
    }
}%
% Appendix title formatting and table of contents entry
\long\def\appendixtitle#1{{\centering\bf\scshape #1\vskip1em}{\addcontentsline{toc}{chapter}{\appendixname~\thechapter.~~ #1}}}


%%%%%%%%%%%%
%
% Line number formatting (optional)
%
%%%%%%%%%%%%
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
