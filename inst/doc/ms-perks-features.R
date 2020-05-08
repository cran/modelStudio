## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = FALSE,
  comment = "#>",
  warning = FALSE,
  message = FALSE
)

## ----results="hide"-----------------------------------------------------------
train <- DALEX::HR
train$fired <- as.factor(ifelse(train$status == "fired", 1, 0))
train$status <- NULL

head(train)

## ----echo = FALSE, fig.align='center'-----------------------------------------
knitr::kable(head(train), digits = 2, caption = "DALEX::HR dataset")

## ----results="hide", eval = FALSE---------------------------------------------
#  # fit a ranger model
#  library("ranger")
#  model <- ranger(fired ~., data = train, probability = TRUE)
#  
#  # prepare validation dataset
#  test <- DALEX::HR_test[1:1000,]
#  test$fired <- ifelse(test$status == "fired", 1, 0)
#  test$status <- NULL
#  
#  # create an explainer for the model
#  explainer <- DALEX::explain(model,
#                              data = test,
#                              y = test$fired)
#  
#  # start modelStudio
#  library("modelStudio")

## ----eval = FALSE-------------------------------------------------------------
#  new_observation <- test[1:3,]
#  rownames(new_observation) <- c("John Snow", "Arya Stark", "Samwell Tarly")
#  true_labels <- test[1:3,]$fired
#  
#  modelStudio(explainer,
#              new_observation = new_observation,
#              new_observation_y  = true_labels)

## ----eval = FALSE-------------------------------------------------------------
#  # small dashboard with 2 panels
#  modelStudio(explainer,
#              facet_dim = c(1,2))
#  
#  # large dashboard with 9 panels
#  modelStudio(explainer,
#              facet_dim = c(3,3))

## ----eval = FALSE-------------------------------------------------------------
#  # slow down animations
#  modelStudio(explainer,
#              time = 1000)
#  
#  # turn off animations
#  modelStudio(explainer,
#              time = 0)

## ----eval = FALSE-------------------------------------------------------------
#  # faster, less precise
#  modelStudio(explainer,
#              N = 200, B = 5)
#  
#  # slower, more precise
#  modelStudio(explainer,
#              N = 500, B = 15)

## ----eval = FALSE-------------------------------------------------------------
#  modelStudio(explainer,
#              eda = FALSE)

## ----eval = FALSE-------------------------------------------------------------
#  modelStudio(explainer,
#              show_info = FALSE)

## ----eval = FALSE-------------------------------------------------------------
#  modelStudio(explainer,
#              viewer = "browser")

## ----eval = FALSE-------------------------------------------------------------
#  # set up the cluster
#  options(
#    parallelMap.default.mode        = "socket",
#    parallelMap.default.cpus        = 4,
#    parallelMap.default.show.info   = FALSE
#  )
#  
#  # calculations of local explanations will be distributed into 4 cores
#  modelStudio(explainer,
#              new_observation = test[1:16,],
#              parallel = TRUE)

## ----eval = FALSE-------------------------------------------------------------
#  # set additional graphical parameters
#  new_options <- ms_options(
#    show_subtitle = TRUE,
#    bd_subtitle = "Hello World",
#    line_size = 5,
#    point_size = 9,
#    line_color = "pink",
#    point_color = "purple",
#    bd_positive_color = "yellow",
#    bd_negative_color = "orange"
#  )
#  
#  modelStudio(explainer,
#              options = new_options)

## ----eval = FALSE-------------------------------------------------------------
#  old_ms <- modelStudio(explainer)
#  old_ms
#  
#  # update the options
#  new_ms <- ms_update_options(old_ms,
#                              time = 0,
#                              facet_dim = c(1,2),
#                              margin_left = 150)
#  new_ms

## ----eval = FALSE-------------------------------------------------------------
#  old_ms <- modelStudio(explainer)
#  old_ms
#  
#  # add new observations
#  plus_ms <- ms_update_observations(old_ms,
#                                    explainer,
#                                    new_observation = test[101:102,])
#  plus_ms
#  
#  # overwrite old observations
#  new_ms <- ms_update_observations(old_ms,
#                                   explainer,
#                                   new_observation = test[103:104,],
#                                   overwrite = TRUE)
#  new_ms

## ----eval = FALSE-------------------------------------------------------------
#  library(DALEXtra)
#  library(mlr)
#  
#  # fit a model
#  task <- makeClassifTask(id = "task", data = train, target = "fired")
#  learner <- makeLearner("classif.ranger", predict.type = "prob")
#  model <- train(learner, task)
#  
#  # create an explainer for the model
#  explainer_mlr <- explain_mlr(model,
#                               data = test,
#                               y = test$fired,
#                               label = "mlr")
#  
#  # make a studio for the model
#  modelStudio(explainer_mlr)

