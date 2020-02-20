## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  warning = FALSE,
  message = FALSE
)

## ----results="hide"------------------------------------------------------
train <- DALEX::HR[1:100,]
train$fired <- ifelse(train$status == "fired", 1, 0)
train <- train[,-6]

head(train)

## ----echo = FALSE, fig.align='center'------------------------------------
knitr::kable(head(train), digits = 2, caption = "DALEX::HR dataset")

## ----results="hide", eval = FALSE----------------------------------------
#  # create a random forest model
#  library("randomForest")
#  model <- randomForest(fired ~., data = train)
#  
#  # prepare validation dataset
#  test <- DALEX::HR_test[1:100,]
#  test$fired <- ifelse(test$status == "fired", 1, 0)
#  test <- test[,-6]
#  
#  # create an explainer
#  explainer <- DALEX::explain(model = model,
#                              data = test[,-6],
#                              y = test[,6],
#                              verbose = FALSE)
#  
#  # start modelStudio
#  library("modelStudio")

## ----eval = FALSE--------------------------------------------------------
#  new_observation <- test[1:3,]
#  rownames(new_observation) <- c("John Snow", "Arya Stark", "Samwell Tarly")
#  true_labels <- test[1:3,6]
#  
#  modelStudio(explainer, new_observation = new_observation,
#                         new_observation_y  = true_labels)

## ----eval = FALSE--------------------------------------------------------
#  # small dashboard with 2 panels
#  modelStudio(explainer, new_observation, facet_dim = c(1,2))
#  
#  # large dashboard with 9 panels
#  modelStudio(explainer, new_observation, facet_dim = c(3,3))

## ----eval = FALSE--------------------------------------------------------
#  # slow down animations
#  modelStudio(explainer, new_observation, time = 1000)
#  
#  # turn off animations
#  modelStudio(explainer, new_observation, time = 0)

## ----eval = FALSE--------------------------------------------------------
#  modelStudio(explainer, new_observation, N = 100, B = 10)
#  
#  modelStudio(explainer, new_observation, N = 1000, B = 50)

## ----eval = FALSE--------------------------------------------------------
#  modelStudio(explainer, new_observation, eda = FALSE)

## ----eval = FALSE--------------------------------------------------------
#  modelStudio(explainer, new_observation, show_info = FALSE)

## ----eval = FALSE--------------------------------------------------------
#  modelStudio(explainer, new_observation, viewer = "browser")

## ----eval = FALSE--------------------------------------------------------
#  #set up the cluster
#  options(
#    parallelMap.default.mode        = "socket",
#    parallelMap.default.cpus        = 4,
#    parallelMap.default.show.info   = FALSE
#  )
#  
#  # calculations will be distributed into 4 cores
#  modelStudio(explainer, new_observation = test[1:16,], parallel = TRUE)

## ----eval = FALSE--------------------------------------------------------
#  # set additional graphical parameters
#  new_options <- modelStudioOptions(
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
#  modelStudio(explainer, new_observation, options = new_options)

## ----eval = FALSE--------------------------------------------------------
#  library(DALEXtra)
#  library(mlr)
#  
#  # prepare mlr model
#  task <- mlr::makeRegrTask(id = "task",
#                            data = train,
#                            target = "fired")
#  
#  learner <- mlr::makeLearner("regr.randomForest",
#                              par.vals = list(ntree = 300),
#                              predict.type = "response")
#  
#  model <- mlr::train(learner, task)
#  
#  # create an explainer for mlr model
#  explainer_mlr <- explain_mlr(model, data = test[,-6], y = test[,6], label = "mlr")
#  
#  # call model studio for mlr model
#  modelStudio(explainer_mlr,
#              new_observation,
#              N = 100, B = 10)

## ----eval = FALSE--------------------------------------------------------
#  library(DALEXtra)
#  
#  titanic_test <- read.csv(system.file("extdata", "titanic_test.csv", package = "DALEXtra"))
#  titanic_train <- read.csv(system.file("extdata", "titanic_train.csv", package = "DALEXtra"))
#  
#  # read scikitlearn model
#  yml <- system.file("extdata", "scikitlearn.yml", package = "DALEXtra")
#  pkl_gbm <- system.file("extdata", "scikitlearn.pkl", package = "DALEXtra")
#  pkl_SGDC <- "SGDC.pkl"
#  
#  # prepare an explainer for scikitlearn model
#  explainer_scikit <- explain_scikitlearn(pkl_gbm,
#                                          yml = yml,
#                                          data = titanic_test[,1:17],
#                                          y = titanic_test[,18],
#                                          label = "python-gbm")
#  
#  # start model studio
#  modelStudio(explainer_scikit,
#              new_observation = titanic_test[1:4,1:17],
#              N = 100, B = 10, options = modelStudioOptions(margin_left = 160))

