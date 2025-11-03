%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% `kthletter.cls'
%
% Originally ``brevmall.sty'' by Anders Forsgren.
% Modified by Rickard Norström.
% Converted to class and fixed for pdfTeX &c. by Mårten Svantesson
% This version dated September 22, 2005.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Available options
% ------------------
%
% window Place to address suitably for swedish window envelopes 
%        (C5H2 or S65H2)
%
% For specifying logotypes:
%
% KTH  KTH (default)
% ABE  Skolan för arkitektur och samhällsbyggnad
% BIO  Skolan för bioteknologi
% KOD  Skolan för datavetenskap och kommunikation
% EES  Skolan för elektro- och systemteknik
% ITM  Skolan för industriell teknik och management
% ICT  Skolan för informations- och kommunikationsteknik
% CHE  Skolan för kemivetenskap
% STH  Skolan för teknik och hälsa
% SCI  Skolan för teknikvetenskap
% KTHB KTH Biblioteket
% UF   Universitetsförvaltningen
%
% For specifying language (for hyphenation, text of template and date format):
%
% swedish  (default)
% american Gives date format like October 3, 2005
% british  Gives date format like 3rd October, 2005
% english  Date format varies between sofware versions
%
% For specifying color scheme of logotype:
%
% colour     Default, synonyms: color and cmyk, cmyk color specification
% monochrome Black and white, synonyms: svv and bw
% pms        Colour with pms colour specification
%
% Any other option is passed on to the letter class.
%
% Available commands
% ------------------
% 
% Must be used for a well formed letter:
% 
% \name{<value>}
% 
% Should be used (default is empty unless otherwise stated):
%
% \phone{<value>}    Default is 790 60 00
% \email{<value>}
% \address{<value>}
% \fax{<value>}
% \division{<value>} Set to level below school or equivalent
% 
% May be used:
%
% \town{<value>}     Default is Stockholm
% \zip{<value>}      Default is 100 44
% \homepage{<value>} Default is www.kth.se
% \bankgiro{<value>} Default is 895-9223
% \plusgiro{<value>} Default is 1 56 53-9
% \dnr{<value>}      Diarienummer, empty if omitted
% \dossnr{<value>}   Dossiernummer, empty if omitted
% 
% Also all other commands from the standard letter class can
% be used.
%
% If you are not using AFS you need to get the logos you will
% use. They are available at
% http://www.sys.kth.se/graphics/kthlogo/schools/
% See the instructions there for more information.
%
% Beginning of sample letter
%
% \documentclass[swedish,SCI]{kthletter}
%
% \name{Anders Forsgren}
% \phone{790 71 27}         % 790 60 00 if omitted
% \fax{22 53 20}            % Empty if omitted
% \email{andersf@math.kth.se}
% \division{                % Empty if omitted
%   \ifthenelse{\boolean{english}}
%   {Optimization and Systems Theory}
%   {Optimeringslära och systemteori}}
% \address{Lindstedtsvägen 25}
% %   \extrainitspace 2cm   % Will give extra space above the main letter.
% %   \extrapsspace 0cm     % Will give extra space after the signature.
% %   \makelabels           % Gives a sheet of adress labels
%
% \begin{document}
%
% \begin{letter}{Addressee \\
% Address}
% \date{May 8, 2003}  % Today if omitted
%
% \dnr{1}          % Diarienummer, empty if omitted
% \dossnr{2}       % Dossiernummer, empty if omitted
%
% \opening{Dear Addressee:}
%
% This is the body of the letter.
%
% \closing{Yours sincerely,}            
%
% %\encl{Enclosure}
% %\cc{Copy}
% %\ps PS
%
% \end{letter}
%
% \end{document}
%
% End of sample letter
%
% To avoid having the specification of personal data in every letter it can
% be put in a file called kthletter.cfg. This is searched for in the
% LaTeX search path. In teTeX 2 and newer this is for example in
% $HOME/texmf/tex/latex/local. Or it can simply be put in the same
% directory as your letter.
%
% Local site configurations
% -------------------------
% This section is mainly aimed at system administrators.
% 
% There is support for loading local site configurations. These files are
% loaded earlier than the personal configurations of kthletter.cfg
% because they should be able to set class options. This makes it
% necessary to use the \AtEndOfClass command for issuing commands.
% 
% The file kthletter-base.cfg is always searched for and can be used to
% make configurations for everybody using a system. If an otherwise
% unknown option (not mentioned above) is given to the class the file
% kthletter-<option>.cfg is searched for (if it's not found the option
% will be passed to letter). These files can for example be used to
% specify configurations for different divisions. 
% 
% An example configuration file from the math department:
% 
% \ExecuteOptions{SCI}
% \AtEndOfClass{%
% \homepage{www.math.kth.se}
% \fax{723~1788}
% \division{%
%   \ifthenelse{\boolean{english}}
%   {Department of Mathematics}
%   {Institutionen för matematik}}
% \address{Lindstedtsvägen 25}
% }
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NeedsTeXFormat{LaTeX2e} \ProvidesClass{kthletter}[2005/05/30 KTH
extension to the letter package]

\RequirePackage{ifthen}
\newboolean{english}
\newboolean{monochrome}
\newboolean{pms}
\newboolean{windowenv}

\newcommand{\phone}[1]{\def\myphone{#1}}
\newcommand{\fax}[1]{\def\myfax{#1}}
\newcommand{\email}[1]{\def\myemail{#1}}
\newcommand{\division}[1]{\def\mydivision{#1}}
\newcommand{\town}[1]{\def\mytown{#1}}
\newcommand{\zip}[1]{\def\myzip{#1}}
\newcommand{\homepage}[1]{\def\myhomepage{#1}}
\newcommand{\bankgiro}[1]{\def\mybankgiro{#1}}
\newcommand{\plusgiro}[1]{\def\myplusgiro{#1}}
\newcommand{\dnr}[1]{\def\diarienr{#1}}
\newcommand{\dossnr}[1]{\def\dossiernr{#1}}
\newcommand{\mylogo}[1]{\def\thelogo{#1}}

% User commands
%Must
%\name{}
%Should
%\address{}
\email{}
\phone{790 60 00}
\fax{}
\division{}
%May
\town{Stockholm}
\zip{100 44}
\homepage{www.kth.se}
\bankgiro{895-9223}
\plusgiro{1 56 53-9}
%Should not
\mylogo{KTH}


\DeclareOption{svenska}{%
  \def\langspec{sv}
  \setboolean{english}{false}}
\DeclareOption{swedish}{%
  \def\langspec{sv}
  \setboolean{english}{false}}
\DeclareOption{english}{%
  \def\langspec{en}
  \setboolean{english}{true}}
\DeclareOption{british}{%
  \def\langspec{en}
  \setboolean{english}{true}}
\DeclareOption{american}{%
  \def\langspec{en}
  \setboolean{english}{true}}

\DeclareOption{window}{\setboolean{windowenv}{true}}
\DeclareOption{monochrome}{\setboolean{monochrome}{true}}
\DeclareOption{bw}{\setboolean{monochrome}{true}}
\DeclareOption{svv}{\setboolean{monochrome}{true}}
\DeclareOption{color}{\setboolean{monochrome}{false}}
\DeclareOption{cmyk}{\setboolean{monochrome}{false}}
\DeclareOption{colour}{\setboolean{monochrome}{false}}
\DeclareOption{pms}{\setboolean{monochrome}{false} \setboolean{pms}{true}}

\DeclareOption{ABE}{\mylogo{ABE}}
\DeclareOption{BIO}{\mylogo{BIO}}
\DeclareOption{KOD}{\mylogo{KOD}}
\DeclareOption{EES}{\mylogo{EES}}
\DeclareOption{ITM}{\mylogo{ITM}}
\DeclareOption{ICT}{\mylogo{ICT}}
\DeclareOption{CHE}{\mylogo{CHE}}
\DeclareOption{STH}{\mylogo{STH}}
\DeclareOption{SCI}{\mylogo{SCI}}
\DeclareOption{KTHB}{\mylogo{KTHB}}
\DeclareOption{UF}{\mylogo{UF}}
\DeclareOption{KTH}{\mylogo{KTH}}

\DeclareOption*{%
  \InputIfFileExists{kthletter-\CurrentOption.cfg}{%
    \typeout{Loading configuration file kthletter-\CurrentOption.cfg}}{%
    \PassOptionsToClass{\CurrentOption}{letter}}
}

\InputIfFileExists{kthletter-base.cfg}{%
  \typeout{Loading configuration file kthletter-base.cfg}{}}

\ProcessOptions

\ifx\langspec\undefined
  \def\langspec{sv}
  \setboolean{english}{false} 
  \PassOptionsToPackage{swedish}{babel}
\fi

\LoadClass[11pt,a4paper]{letter}

\renewcommand{\address}[1]{\def\myaddress{#1}}

\address{}

\newcounter{letter}

\let\letterorig\letter
\let\endletterorig\endletter

\renewcommand*{\letter}{\addtocounter{letter}{1}\letterorig}
\renewcommand*{\endletter}{\message{\theletter}\vfill\label{lastpage\theletter}\endletterorig}

\newdimen\extrainitspace
\extrainitspace=0mm

\newdimen\psspace
\psspace=10mm

\newdimen\extrapsspace
\extrapsspace=0mm

\RequirePackage{fancyhdr}
\RequirePackage[T1]{fontenc}
\RequirePackage{extramarks}
\RequirePackage[utf8]{inputenc}
\pagestyle{fancy}
\RequirePackage{float}

\IfFileExists{verdana.sty}{%
  \IfFileExists{garamond.sty}{%
    \RequirePackage{verdana,garamond}
    \newcommand{\letterfootfamily}{jvn}
    \IfFileExists{eulervm.sty}{\RequirePackage{eulervm}}{}
  }{}}{}


\ifx\letterfootfamily\undefined
  \RequirePackage{helvet,times}
  \newcommand{\letterfootfamily}{pag}
  \IfFileExists{mathtime.sty}{\RequirePackage{mathtime}}{}
\fi

\RequirePackage{babel}

\topmargin = 20mm 
\textheight = 24.7cm 
\columnsep = 0pt
\hoffset = -1in
\voffset = -1in
\headsep = 0mm 
\headheight = 0mm 
\oddsidemargin = 30mm
\evensidemargin = 30mm
\textwidth = 15cm
\footskip = 5mm
\marginparsep = 0pt
\marginparwidth = 0pt
\renewcommand{\headrulewidth}{0pt}
\paperwidth = 20.8cm

% Behålla för bakåtkompabilitet?

\AtBeginDocument{%
  \ifx\mydata\undefined
  \else
  \mydata
  \fi
}

% \newif\ifpdf
% \ifx\pdfoutput\undefined
%    \pdffalse
% \else
%    \ifnum\pdfoutput>0
%       \pdftrue
%    \else
%       \pdffalse
%    \fi
% \fi

\RequirePackage{color} %%% black,white, red,green,blue, cyan,magenta,yellow
\RequirePackage{graphicx}   
\graphicspath{{/afs/kth.se/misc/graphics/kthlogo/schools/}{/afs/kth.se/misc/graphics/kthlogo/schools/}}

\ifthenelse{\boolean{monochrome}}
{\newcommand{\colorspec}{svv}}
{\ifthenelse{\boolean{pms}}
  {\newcommand{\colorspec}{pms}}
  {\newcommand{\colorspec}{cmyk}}
}

\newcommand{\logotype}[1]{%
  \begin{center}
    \includegraphics[scale=#1]{\thelogo_\langspec_\colorspec}
  \end{center}}


% \kthtoplogo given at first line on a page gives selected logo in the upper
%  center of the page.
%     #1 is the vertical distance from the top edge of the paper
%     #2 is either of the logos defined above
%     #3 is the width of the logo (preferrably 25 true mm or 32 true mm)
%  Example:
%     \kthtoplogo{12 true mm}{\matematik}{25 true mm}

\newcommand{\kthtoplogo}[3]{%
     \newdimen\xlogoskip
     \newdimen\ylogoskip
     \xlogoskip 0mm
     \advance\xlogoskip -\oddsidemargin
     \advance\xlogoskip -1 true in
     \advance\xlogoskip -0.5 true mm
     \advance\xlogoskip #1
     \ylogoskip 0mm
     \advance\ylogoskip -\topmargin
     \advance\ylogoskip -6 true mm
     \advance\ylogoskip #1
     \
     \vskip \ylogoskip
     \noindent #2{#3}}


\newcommand{\placelogo}{{\vbox to 20 mm{%
          \kthtoplogo{9 mm}{\logotype}{0.2}
   }}}

\newdimen\initspace
\initspace=10mm
\advance\initspace\extrainitspace
\renewcommand{\opening}[1]{%
  \placelogo
  \ifthenelse{\boolean{windowenv}}
  {\hspace{9cm}\vspace{-1cm}}{}
   \begin{minipage}[t]{70mm}
      \toname \\ \toaddress 
   \end{minipage}
  
\hspace{9cm} \begin{minipage}[t]{55mm}
  \ \\[16mm]
  \ifx\diarienr\@undefined\else\ifx\diarienr\@empty\else
  Dnr: \diarienr \\
  \fi\fi
  \ifx\dossiernr\@undefined\else\ifx\dossiernr\@empty\else
  Dossnr: \dossiernr \\ [0mm]
  \fi\fi
  \mytown, \@date
\end{minipage}
   \par\vspace{3mm}
   \parbox[t]{\textwidth}{#1}}

\let\closingorig\closing
\renewcommand*{\closing}[1]{\closingorig{#1}
 \advance\psspace \extrapsspace \vspace{\psspace}}

\renewcommand*{\startlabels}{\labelcount\z@
  \pagestyle{empty}%
  \let\@texttop\relax
  \topmargin 7mm
  \headsep \z@
  \oddsidemargin 5mm
  \evensidemargin 5mm
  \textheight 10in
  \@colht\textheight  \@colroom\textheight \vsize\textheight
  \textwidth 190mm
  \columnsep 10mm
  \ifcase \@ptsize\relax
    \normalsize
  \or
    \normalsize
  \or
    \footnotesize
  \fi
  \baselineskip \z@
  \lineskip \z@
  \boxmaxdepth \z@
  \parindent \z@
  \relax}
\let\@startlabels=\relax
\renewcommand*{\mlabel}[2]{%
\begin{minipage}[h]{68mm}
\vbox to 36 mm{#2\vfil}
\end{minipage}
  }

\lhead[]{}
\chead[]{}
\rhead[]{}
\lfoot[]{}
\rfoot[]{}
\ifthenelse{\boolean{english}}{
\cfoot[]{
\begin{tabular*}{\textwidth}{r c r}
\hspace{1.4cm} & \hspace{11cm} & \hspace{3cm}\\
 & \fontfamily{\letterfootfamily}\selectfont
\fontsize{6.5}{6}\selectfont{\hspace{0mm} Royal Institute of
  Technology \quad \emph{\mydivision}} &
{\hspace{7mm}\vspace{-8mm}\small \thepage(\pageref{lastpage\theletter})}\\[2ex]
\end{tabular*}  
\begin{center}\vspace{-5mm}
\vspace{0.7mm}\rule{\textwidth}{0.25pt}\\[0.6534679845ex]
\renewcommand{\arraystretch}{0.8}
\begin{tabular}{c}
\hspace{0mm} \fontfamily{\letterfootfamily}\selectfont{\hspace{9mm}
  {\fontsize{5.5}{5}\selectfont{\textbf{KTH}}} 
  {\fontsize{6.5}{5}\selectfont{\ifx\myaddress\@empty\else\myaddress, \fi SE-\fontsize{6}{5}\selectfont{\myzip~}\fontsize{6.5}{5}\selectfont{\mytown. Phone:}
  \fontsize{6}{5}\selectfont{+46 8 \myphone}
  \ifx\myfax\@empty\else
\fontsize{6.5}{5}\selectfont{. Fax:
  }\fontsize{6}{5}\selectfont{+46 8 \myfax}
  \fi
  \fontsize{6.5}{5}\selectfont{
\ifx\myemail\@empty\else.  E-mail: \myemail \fi}}}}\\
\vspace{-1mm}\fontfamily{\letterfootfamily}\selectfont{\hspace{11mm}{\fontsize{6.5}{5}\selectfont{PlusGiro
  No: \fontsize{6}{5}\selectfont{\myplusgiro}. 
  \fontsize{6.5}{5}\selectfont{Bankgiro No:
  }\fontsize{6}{5}\selectfont{\mybankgiro}\fontsize{6.5}{5}\selectfont{.
  VAT registration No:
  SE}\fontsize{6}{5}\selectfont{202100305401.}\fontsize{6.5}{5}\selectfont{
  \myhomepage}}}}
\end{tabular}
\end{center}
}}
{\cfoot[]{
\begin{tabular*}{\textwidth}{r c r}
\hspace{1.4cm} & \hspace{11cm} & \hspace{3cm}\\
 & \fontfamily{\letterfootfamily}\selectfont
\fontsize{6.5}{6}\selectfont{\hspace{0mm} Kungliga Tekniska högskolan \quad \emph{\mydivision}} &
{\hspace{7mm}\vspace{-8mm}\small \thepage(\pageref{lastpage\theletter})}\\[2ex]
\end{tabular*}  
\begin{center}\vspace{-5mm}
\vspace{0.7mm}\rule{\textwidth}{0.25pt}\\[0.6534679845ex]
\renewcommand{\arraystretch}{0.8}
\begin{tabular}{c}
\hspace{0mm} \fontfamily{\letterfootfamily}\selectfont{\hspace{9mm}
  {\fontsize{5.5}{5}\selectfont{\textbf{KTH}}} 
  {\fontsize{6.5}{5}\selectfont{\ifx\myaddress\@empty\else\myaddress, \fi
  SE-%
\fontsize{6}{5}\selectfont{\myzip~}
\fontsize{6.5}{5}\selectfont{\mytown. Tel: }%
  \fontsize{6}{5}\selectfont{08-\myphone}
  \ifx\myfax\@empty\else
  \fontsize{6.5}{5}\selectfont{. Fax:
  }\fontsize{6}{5}\selectfont{08-\myfax}
  \fi
  \fontsize{6.5}{5}\selectfont{
  \ifx\myemail\@empty\else.  E-mail: \myemail \fi}}}}\\
\vspace{-1mm}\fontfamily{\letterfootfamily}\selectfont{\hspace{11mm}{\fontsize{6.5}{5}\selectfont{Pg:\fontsize{6}{5}\selectfont{
  \myplusgiro}. \fontsize{6.5}{5}\selectfont{Bg:
  }\fontsize{6}{5}\selectfont{\mybankgiro}\fontsize{6.5}{5}\selectfont{.
  Momsreg.nr/VAT: SE}\fontsize{6}{5}\selectfont{202100305401.}\fontsize{6.5}{5}\selectfont{
  \myhomepage}}}}
\end{tabular}
\end{center}
}}

\InputIfFileExists{kthletter.cfg}{%
  \typeout{Loading configuration file kthletter.cfg}}{%
  \typeout{Configuration file kthletter.cfg is not found}}
