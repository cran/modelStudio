## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## ----warning = FALSE, message = FALSE-----------------------------------------
library("DALEX")
library("ranger")
library("modelStudio")

# fit a model
model <- ranger(score ~., data = happiness_train)

# create an explainer for the model    
explainer <- explain(model,
                     data = happiness_test,
                     y = happiness_test$score,
                     label = "Random Forest",
                     verbose = FALSE)

# make a studio for the model
modelStudio(explainer)

