\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{Template/UofMThesis_Class}[2021/03/23 The University of Manitoba Thesis/Dissertation Class]
\LoadClassWithOptions{report}
% The class file is a superclass of `report`.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Packages and their patches. %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{cite} % Handles the space after `\cite{}` automatically.
\RequirePackage{microtype}
% Micro-adjusts font spacing.
% `microtype` does not work with `latex` and please use `pdflatex`, `lualatex` or `xelatex` instead if one tries to compile `Main.tex` using command lines.
\RequirePackage[nodisplayskipstretch, doublespacing]{setspace}
% Double-spaced for text but not for mathematical formulae.

\RequirePackage{fancyhdr} % Fancy style headers.
\setlength{\headheight}{15pt}
% Sets `\headheight` to 15pt to get rid of the headheight-related warning message caused by `fancyhdr`, when the default font size is 12pt.

\RequirePackage[Bjornstrup]{fncychap} % `Bjornstrup` heading styles for chapter titles.
\renewcommand\DOCH % Silences the warning messages generated by `Bjornstrup`.
{
	\settowidth{\py}{\CNoV\thechapter}
	\addtolength{\py}{-6pt} % Shifts such amount of space right.
	\fboxsep = 0pt
	\colorbox{gray!30}{\rule{0pt}{40pt}\parbox[b]{\textwidth}{\hspace*{\fill}}}
	\kern -\py \raise 20pt
	\rlap{\color{gray}\CNoV\thechapter} \\
}

% Enables epigraphs and loads `minipage` automatically.
% Try to avoid ANY footnotes in epigraphs please.
\RequirePackage{epigraph}
\renewcommand{\epigraph}[2] % Makes epigraphs single-spaced.
{
	\vspace{\beforeepigraphskip}
	\vbox
	{
		\epigraphsize
		\begin{\epigraphflush}
			\begin{singlespace}
				\begin{minipage}{\epigraphwidth}
					\@epitext{#1} \\
					\@episource{#2}
				\end{minipage}
			\end{singlespace}
		\end{\epigraphflush}
	}
	\nointerlineskip
	\vspace*{\afterepigraphskip}
	\ifepigraphnoindent\@afterheading\fi
}

\RequirePackage{tocbibind}
% Enables the table of contents (ToC), the list of tables (LoT), the list of figures (LoF) and the bibliography to show in the bookmark.
\RequirePackage[format = hang, font = sf, labelfont = bf]{caption}
% Sets sans serif text and boldface caption labels with indented caption text; the option `format = hang` sets up a hanging indention.
\usepackage[framemethod = tikz]{mdframed}
% Defines customised boxed/framed environments (`notice`, `highlight` and `highlight*`).
% `mdframed` renews the `theorem` environment so it has to be loaded before `amsthm`.
% It loads `kvoptions`, `xparse`, `etoolbox`, `color` and `tikz` automatically.
\RequirePackage{mathtools} % An add-on of `amsmath` loading `amsmath` automatically.
\RequirePackage{amsthm, amssymb}
% If `amsthm` is used with a non-AMS document class and with `amsmath`, `amsthm` must be loaded after `amsmath`, not before.
\RequirePackage[pdftex, breaklinks = true, pagebackref = true]{hyperref}
% Generates hypertext marks.
% `breaklinks = true` allows links to break over lines.
% `pagebackref = true` activates back references inside the bibliography.
% With FEW exceptions, `hyperref` should **always** be loaded last.

% Enables proper footnote displays for `tabular` and `mdframed` with `\tablefootnote{}`.
% Do not use `\tablefootnote{}` in the `minipage` environment (likewise, `\epigraph{}`) since `tablefootnote` barely supports the `minipage` package.
\RequirePackage{tablefootnote}
\AfterEndEnvironment{mdframed}
% Prints footnotes for `mdframed` at the bottom of the page instead of after the frame.
{
	\tfn@tablefootnoteprintout
	\gdef\tfn@fnt{0}
}

\RequirePackage[toc, page]{appendix} % Changes grouping for bookmarks of the appendix.
\RequirePackage{bookmark} % A new bookmark organisation for `hyperref`.

% For debugging use only.
%\RequirePackage{refcheck}
% Shows useless labels, unlabelled equations, unused bibliography references.
% `refcheck` should be loaded after `hyperref` and all AMS-related packages.
%\RequirePackage[l2tabu, orthodox]{nag}
% Warns users of common mistakes and outdated packages.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Field filling, exception handling and PDF settings. %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Defines internal commands starting with `@` is to prevent users accidently from changing the macro names outside the class file.
\newcommand{\documentID}[1]{\newcommand\@documentID{#1}}
\newcommand{\degreename}[1]{\newcommand\@degreename{#1}}
\newcommand{\department}[1]{\newcommand\@department{#1}}
\newcommand{\graduationmonth}[1]{\newcommand\@graduationmonth{#1}}
\newcommand{\graduationyear}[1]{\newcommand\@graduationyear{#1}}
\newcommand{\advisor}[1]{\newcommand\@advisor{#1}}
\newcommand{\subject}[1]{\newcommand\@subject{#1}}
\newcommand{\keywords}[1]{\newcommand\@keywords{#1}}

\input{Front_Matter/Fields}

\ifdefempty{\@documentID}
{
	\ClassError{UMThesis_Class}{\noexpand\documentID cannot be blank}{Check \noexpand\documentID in ./Front_Matter/Fields.tex}
	\stop
}
{}

\ifdefempty{\@degreename}
{
	\ClassError{UMThesis_Class}{\noexpand\degreename cannot be blank}{Check \noexpand\degreename in ./Front_Matter/Fields.tex}
	\stop
}
{}

\ifdefempty{\@department}
{
	\ClassError{UMThesis_Class}{\noexpand\department cannot be blank}{Check \noexpand\department in ./Front_Matter/Fields.tex}
	\stop
}
{}

\ifdefempty{\@graduationmonth}
{
	\ClassError{UMThesis_Class}{\noexpand\graduationmonth cannot be blank}{Check \noexpand\graduationmonth in ./Front_Matter/Fields.tex}
	\stop
}
{}

\ifdefempty{\@graduationyear}
{
	\ClassError{UMThesis_Class}{\noexpand\graduationyear cannot be blank}{Check \noexpand\graduationyear in ./Front_Matter/Fields.tex}
	\stop
}
{}

\ifdefempty{\@advisor}
{
	\ClassError{UMThesis_Class}{\noexpand\advisor cannot be blank}{Check \noexpand\advisor in ./Front_Matter/Fields.tex}
	\stop
}
{}

\ifnumequal{\@documentID}{0} % Defines `\@document` based on the value of `\@documentID`.
{\newcommand{\@document}{thesis}}
{
	\ifnumequal{\@documentID}{1}
	{\newcommand{\@document}{dissertation}}
	{
		\ClassError{UMThesis_Class}{\noexpand\documentID is supposed to be either `0` (thesis) or `1` (dissertation)}{Check \noexpand\documentID in ./Front_Matter/Fields.tex}
		\stop
	}
}

\hypersetup
{
	bookmarksnumbered = true, % Adds index numbers for chapters/sections.
	colorlinks = true, % `false` for boxed links; `true` for coloured links.
	citecolor = blue,
	% Changes the colour of citation links into `blue` instead of default glaring `green`.
	pdfnewwindow = true, % Links are opened in a new window.
	pdfauthor = \@author,
	pdfcreator = \@author,
	pdftitle = \@title,
	pdfsubject = \@subject,
	pdfkeywords = \@keywords,
	pdfborder = 0 0 0
	% Makes all links invisible; so the document looks decent when printed.
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Command (re)definitions. %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Redefines `\cleardoublepage`.
\def\cleardoublepage
{
	\clearpage\if@twoside\ifodd\c@page\else
	\hbox{}
	\vspace*{\fill}
	\begin{center}
		This page is intentionally left blank.
	\end{center}
	\vspace{\fill}
	\thispagestyle{empty}
	\newpage
	\if@twocolumn\hbox{}\newpage\fi\fi\fi
}

% Defines the theorem style using `amsthm`. Only some of frequently-used ones are listed here.
% All the counters are reset at every new chapter.
% See two links below for more information:
% https://en.wikibooks.org/wiki/LaTeX/Theorems#Theorem_styles and
% https://www.overleaf.com/learn/latex/theorems_and_proofs
\theoremstyle{plain}
\newtheorem{conjecture}{Conjecture}[chapter]
\newtheorem{corollary}{Corollary}[chapter]
\newtheorem{lemma}{Lemma}[chapter]
\newtheorem{proposition}{Proposition}[chapter]
\newtheorem{theorem}{Theorem}[chapter]

\theoremstyle{definition}
\newtheorem{example}{Example}[chapter]
\newtheorem{definition}{Definition}[chapter]

\theoremstyle{remark}
\newtheorem{claim}{Claim}[chapter]
\newtheorem{observation}{Observation}[chapter]
\newtheorem{remark}{Remark}[chapter]

% Sets up the `notice` environment.
\mdfdefinestyle{notice}
{
	topline = false,
	bottomline = false,
	leftline = false,
	rightline = false,
	singleextra = % A non-split frame.
	{
		\fill [black] (P-|O) circle [radius = 0.5em];
		% `P`: upper right corner; `(O)`: lower left corner.
		% `(P-|O)` or `(O|-P)`: upper left corner.
		\node at (P-|O) {\color{white}\scriptsize\bfseries i};
	},
	firstextra =
	% If it is a split frame, then let it draw the icon only for the first part.
	{
		\fill [black] (P-|O) circle [radius = 0.5em];
		% `P`: upper right corner; `(O)`: lower left corner.
		% `(P-|O)` or `(O|-P)`: upper left corner.
		\node at (P-|O) {\color{white}\scriptsize\bfseries i};
	},
	extra = % Always draws a left line.
	{
		\draw [very thick] (P-|O) ++ (0, -1em) -- (O);
	}
}

\newenvironment{notice}[1][Notice:] % The default title is "Notice:".
{
	\medskip
	\begin{mdframed}[style = notice]
		\noindent{\textbf{#1}}
}
{
	\end{mdframed}
}

% Sets up the `highlight` environment.
\mdfdefinestyle{highlight}
{
	roundcorner = 5pt,
	innertopmargin = \baselineskip,
	singleextra = % A non-split frame.
	{
		\draw (P-|O) node [xshift = 1em, anchor = west, fill = gray!20, draw, rounded corners = 5pt] {\bfseries \highlighttitle};
	},
	firstextra =
	% If it is a split frame, then let it draw the title box only for the first part.
	{
		\draw (P-|O) node [xshift = 1em, anchor = west, fill = gray!20, draw, rounded corners = 5pt] {\bfseries \highlighttitle};
	}
}

% `highlight*` simply disallows label references.
\newenvironment{highlight*}[1][]
{
	\medskip
	\newcommand{\highlighttitle}{#1}
	\begin{mdframed}[style = highlight]
}
{
	\end{mdframed}
}

% `highlight` is a wrapper of `highlight*` with a global counter for label references.
\newcounter{highlights}
\setcounter{highlights}{0}
\newenvironment{highlight}[1][]
{
	\refstepcounter{highlights}
	\begin{highlight*}[#1]
}
{
	\end{highlight*}
}

\newcommand{\maketitlepage}
{
	\phantomsection
	% Adds a phantom section to display the bookmark correctly with `hyperref`.
	\addcontentsline{toc}{chapter}{Title Page}
	\begin{titlepage}
		\begin{center}
			{\LARGE \bfseries \@title} \\[2em]
			by \\[2em]
			\@author \\[2em]
			A \@document\ submitted to \\
			The Faculty of Graduate Studies of \\
			The University of Manitoba \\
			in partial fulfillment of the requirements \\
			for the degree of \\[2em]
			\@degreename \\[2em]
			\@department \\
			The University of Manitoba \\
			Winnipeg, Manitoba, Canada \\
			\@graduationmonth\ \@graduationyear \\[6em]
			Copyright \copyright\ \@graduationyear\ \@author \\
		\end{center}
	\end{titlepage}
}

\renewenvironment{abstract}
{
	\phantomsection
	\addcontentsline{toc}{chapter}{Abstract}
	\noindent
	\begin{minipage}[t]{0.45\textwidth}
		\begin{flushleft}
			{\expandafter \MakeUppercase \@document} Advisor \\
			{\bfseries \@advisor}
		\end{flushleft}
	\end{minipage}
	\hspace{\fill}
	\begin{minipage}[t]{0.45\textwidth}
		\begin{flushright}
			Author \\
			{\bfseries \@author}
		\end{flushright}
	\end{minipage}
	\vspace{2em}
	\begin{center}
		{\large \bfseries \@title}
	\end{center}
	\vspace{2em}
	\begin{center}
		{\Large \bfseries \abstractname}
	\end{center}
}
{
	\ifdefempty{\@keywords}
	{}
	{
		\\[2em]
		\textbf{Keywords:} \@keywords
	}
}

\newenvironment{acknowledgements}
{
	\phantomsection
	\addcontentsline{toc}{chapter}{Acknowledgements}
	\chapter*{Acknowledgements}
}
{}

\newenvironment{dedication}
{
	\phantomsection
	\addcontentsline{toc}{chapter}{Dedication}
	\begin{quote}
		\begin{flushright}
			\em
}
{
		\end{flushright}
	\end{quote}
}

\newcommand{\frontmatterpagestyle}
{
	\pagestyle{plain}
	\pagenumbering{roman} % The page numbers for the front matter are roman.
}

\newcommand{\mainmatterpagestyle}
{
	\pagestyle{fancy}
	\cfoot{}
	\renewcommand{\chaptermark}[1]{\markboth{##1}{##1}}
	\fancyhead[LE, RO]{\thepage}
	\fancyhead[LO, RE]{\textit{\chaptername\ \thechapter: \leftmark}}
	\pagenumbering{arabic} % The page numbers for the main/back matter are arabic.
}

\endinput % The LaTeX engine will stop loading anything after this line.