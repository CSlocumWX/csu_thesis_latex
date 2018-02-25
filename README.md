## An Unofficial Colorado State University Thesis/Dissertation LaTeX Template

This repository contains a LaTeX template for Colorado State
University theses and dissertations. Note that this repository is not the
[official Colorado State University Thesis/Dissertation LaTeX Template](https://github.com/idfah/csuthesis).
However, this unofficial LaTeX document class for the Colorado State University
Thesis/Dissertation automates generation of some of the
preliminary pages (e.g., copyright page) and offers additional flexibility.

Where the formatting guidelines allows, this template defaults to formatting used
in publications by the [American Meteorological Society](https://www.ametsoc.org/).
Specifically, the [AMS reference and citation format](https://www.ametsoc.org/ams/index.cfm/publications/authors/journal-and-bams-authors/formatting-and-manuscript-components/references/) style is used.

### Style optional arguments for the document class
 * **master** - including 'masters' will change 'Doctor of Philosophy' to 'Master of Science' for the degree
 * **10pt, 11pt, 12pt** - CSU allows the font size of the main text to be within 10-12 pts. The title page, copyright page, and abstract are fixed at 12pt
 * **times** - [Adobe Systems Utopia (1989)](https://en.wikipedia.org/wiki/Utopia_(typeface)) is the default serif font. Using the `times` optional argument will load the `mathptmx` package and change the serif font to something akin to Times New Roman.
 * **hyperref** - enables clickable links in document (note that there is a known glitch with hyperref in which the table of contents page numbers might be off. Make sure you check if you decide to use `hyperref`)
 * **blue** - makes the text for urls and references blue rather than black (assumes that hyperref is used)
 * **smallfoot** - makes the page number `\scriptsize` rather than `\footnotesize`
 * **linenumbers** - if you want linenumbers, you can have linenumbers
 * **nocopyright** - CSU now requires the copyright page. If the style changes back, nocopyright restores older CSU format

No guarantees are made that the template complies to current
university style guidelines.

### Example LaTeX template
Below is example LaTeX using the template. This example is similar to what is in the `./csu_thesis_and_dissertation_template.tex` file.
```latex
% Use commas to add additional optional style arguments.
% In this example, we are only using the 11pt option.
\documentclass[11pt]{csuthesis}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Title page
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % Title, your name, and your Dept.
    \title{Epic title here}
    \author{John Doe}
    \departmentname{Atmospheric Science}
  % Graduating term block
    \gradterm{Fall}
    \gradyear{2018}
  % Committee block
    \advisor{Jane Doe}
    \coadvisor{John Doe} %optional
    \committee{Jane Doe \and John Doe \and Jane Doe}
\begin{document}
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % PRELIMINARIES
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    \begin{abstract}
        % Abstract text here
    \end{abstract}
    \begin{acknowledgments}     % optional (delete section if unwanted)
        % Acknowledgment text here
    \end{acknowledgments}
    \begin{dedication}          % optional (delete section if unwanted)
        % Dedication text here
    \end{dedication}
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % Make Title Page and Table of Contents
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    \maketitle
    \tableofcontents
    \listoftables    %optional (delete line if unwanted)
    \listoffigures   %optional (delete line if unwanted)
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % CHAPTERS and/or TEXT
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Using input is a nice way to help organize your work
    \input{./chap1/chapter1.tex}
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % REFERENCES
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % Create a bibliography directory and place your .bib file there.
    {\clearpage}
    \bibliographystyle{ametsoc_csu}
    {\setstretch{1}
    \bibliography{references}}
\end{document}
```
