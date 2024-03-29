% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ms_options.R
\name{ms_options}
\alias{ms_options}
\title{Modify default options and pass them to modelStudio}
\usage{
ms_options(...)
}
\arguments{
\item{...}{Options to change in the form \code{option_name = value}.}
}
\value{
\code{list} of options for \code{modelStudio}.
}
\description{
This function returns default options for \code{\link{modelStudio}}.
It is possible to modify values of this list and pass it to the \code{options}
parameter in the main function. \strong{WARNING: Editing default options may cause
unintended behavior.}
}
\section{Options}{

\subsection{Main options:}{
\describe{
\item{scale_plot}{\code{TRUE} Makes every plot the same height, ignores \code{bar_width}.}
\item{show_boxplot}{\code{TRUE} Display boxplots in Feature Importance and Shapley Values plots.}
\item{show_subtitle}{\code{TRUE} Should the subtitle be displayed?}
\item{subtitle}{\code{label} parameter from \code{explainer}.}
\item{ms_title}{Title of the dashboard.}
\item{ms_subtitle}{Subtitle of the dashboard (makes space between the title and line).}
\item{ms_margin_*}{Dashboard margins. Change \code{margin_top} for more \code{ms_subtitle} space.}
\item{margin_*}{Plot margins. Change \code{margin_left} for longer/shorter axis labels.}
\item{w}{\code{420} in px. Inner plot width.}
\item{h}{\code{280} in px. Inner plot height.}
\item{bar_width}{\code{16} in px. Default width of bars for all plots,
ignored when \code{scale_plot = TRUE}.}
\item{line_size}{\code{2} in px. Default width of lines for all plots.}
\item{point_size}{\code{3} in px. Default point radius for all plots.}
\item{[bar,line,point]_color}{\code{[#46bac2,#46bac2,#371ea3]}}
\item{positive_color}{\code{#8bdcbe} for Break Down and Shapley Values bars.}
\item{negative_color}{\code{#f05a71} for Break Down and Shapley Values bars.}
\item{default_color}{\code{#371ea3} for Break Down bar and highlighted line.}
}
}
\subsection{Plot-specific options:}{
\code{**} is a two letter code unique to each plot, might be
one of \code{[bd,sv,cp,fi,pd,ad,rv,fd,tv,at]}.\cr

\describe{
\item{**_title}{Plot-specific title. Default varies.}
\item{**_subtitle}{Plot-specific subtitle. Default is \code{subtitle}.}
\item{**_axis_title}{Plot-specific axis title. Default varies.}
\item{**_bar_width}{Plot-specific width of bars. Default is \code{bar_width},
ignored when \code{scale_plot = TRUE}.}
\item{**_line_size}{Plot-specific width of lines. Default is \code{line_size}.}
\item{**_point_size}{Plot-specific point radius. Default is \code{point_size}.}
\item{**_*_color}{Plot-specific \code{[bar,line,point]} color. Default is \code{[bar,line,point]_color}.}
}
}
}

\examples{
library("DALEX")
library("modelStudio")

# fit a model
model_apartments <- glm(m2.price ~. , data = apartments)

# create an explainer for the model
explainer_apartments <- explain(model_apartments,
                                data = apartments,
                                y = apartments$m2.price)

# pick observations
new_observation <- apartments[1:2,]
rownames(new_observation) <- c("ap1","ap2")

# modify default options
new_options <- ms_options(
  show_subtitle = TRUE,
  bd_subtitle = "Hello World",
  line_size = 5,
  point_size = 9,
  line_color = "pink",
  point_color = "purple",
  bd_positive_color = "yellow",
  bd_negative_color = "orange"
)

# make a studio for the model
modelStudio(explainer_apartments,
            new_observation,
            options = new_options,
            N = 200,  B = 5) # faster example

}
\references{
\itemize{
  \item The input object is implemented in \href{https://modeloriented.github.io/DALEX/}{\bold{DALEX}}
  \item Feature Importance, Ceteris Paribus, Partial Dependence and Accumulated Dependence explanations
   are implemented in \href{https://modeloriented.github.io/ingredients/}{\bold{ingredients}}
  \item Break Down and Shapley Values explanations are implemented in
   \href{https://modeloriented.github.io/iBreakDown/}{\bold{iBreakDown}}
}
}
\seealso{
Vignettes: \href{https://modelstudio.drwhy.ai/articles/ms-r-python-examples.html}{\bold{modelStudio - R & Python examples}}
and \href{https://modelstudio.drwhy.ai/articles/ms-perks-features.html}{\bold{modelStudio - perks and features}}
}
