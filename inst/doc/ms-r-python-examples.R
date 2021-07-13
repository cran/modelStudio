## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = FALSE,
  comment = "#>",
  warning = FALSE,
  message = FALSE,
  eval = FALSE
)

## ----eval = FALSE-------------------------------------------------------------
#  # packages for the explainer objects
#  install.packages("DALEX")
#  install.packages("DALEXtra")

## ----eval = FALSE-------------------------------------------------------------
#  # load packages and data
#  library(mlr)
#  library(DALEXtra)
#  library(modelStudio)
#  
#  data <- DALEX::apartments
#  
#  # split the data
#  index <- sample(1:nrow(data), 0.7*nrow(data))
#  train <- data[index,]
#  test <- data[-index,]
#  
#  # fit a model
#  task <- makeRegrTask(id = "apartments", data = train, target = "m2.price")
#  learner <- makeLearner("regr.ranger", predict.type = "response")
#  model <- train(learner, task)
#  
#  # create an explainer for the model
#  explainer <- explain_mlr(model,
#                           data = test,
#                           y = test$m2.price,
#                           label = "mlr")
#  
#  # pick observations
#  new_observation <- test[1:2,]
#  rownames(new_observation) <- c("id1", "id2")
#  
#  # make a studio for the model
#  modelStudio(explainer, new_observation)

## ----eval = FALSE-------------------------------------------------------------
#  # load packages and data
#  library(mlr3)
#  library(mlr3learners)
#  library(DALEXtra)
#  library(modelStudio)
#  
#  data <- DALEX::titanic_imputed
#  
#  # split the data
#  index <- sample(1:nrow(data), 0.7*nrow(data))
#  train <- data[index,]
#  test <- data[-index,]
#  
#  # mlr3 TaskClassif takes target as factor
#  train$survived <- as.factor(train$survived)
#  
#  # fit a model
#  task <- TaskClassif$new(id = "titanic", backend = train, target = "survived")
#  learner <- lrn("classif.ranger", predict_type = "prob")
#  learner$train(task)
#  
#  # create an explainer for the model
#  explainer <- explain_mlr3(learner,
#                            data = test,
#                            y = test$survived,
#                            label = "mlr3")
#  
#  # pick observations
#  new_observation <- test[1:2,]
#  rownames(new_observation) <- c("id1", "id2")
#  
#  # make a studio for the model
#  modelStudio(explainer, new_observation)

## ----eval = FALSE-------------------------------------------------------------
#  # load packages and data
#  library(xgboost)
#  library(DALEX)
#  library(modelStudio)
#  
#  data <- DALEX::titanic_imputed
#  
#  # split the data
#  index <- sample(1:nrow(data), 0.7*nrow(data))
#  train <- data[index,]
#  test <- data[-index,]
#  
#  train_matrix <- model.matrix(survived ~.-1, train)
#  test_matrix <- model.matrix(survived ~.-1, test)
#  
#  # fit a model
#  xgb_matrix <- xgb.DMatrix(train_matrix, label = train$survived)
#  params <- list(max_depth = 3, objective = "binary:logistic", eval_metric = "auc")
#  model <- xgb.train(params, xgb_matrix, nrounds = 500)
#  
#  # create an explainer for the model
#  explainer <- explain(model,
#                       data = test_matrix,
#                       y = test$survived,
#                       type = "classification",
#                       label = "xgboost")
#  
#  # pick observations
#  new_observation <- test_matrix[1:2, , drop=FALSE]
#  rownames(new_observation) <- c("id1", "id2")
#  
#  # make a studio for the model
#  modelStudio(explainer, new_observation)

## ----eval = FALSE-------------------------------------------------------------
#  # load packages and data
#  library(caret)
#  library(DALEX)
#  library(modelStudio)
#  
#  data <- DALEX::titanic_imputed
#  
#  # split the data
#  index <- sample(1:nrow(data), 0.7*nrow(data))
#  train <- data[index,]
#  test <- data[-index,]
#  
#  # caret train takes target as factor
#  train$survived <- as.factor(train$survived)
#  
#  # fit a model
#  cv <- trainControl(method = "repeatedcv", number = 3, repeats = 3)
#  model <- train(survived ~ ., data = train, method = "gbm", trControl = cv, verbose = FALSE)
#  
#  # create an explainer for the model
#  explainer <- explain(model,
#                       data = test,
#                       y = test$survived,
#                       label = "caret")
#  
#  # pick observations
#  new_observation <- test[1:2,]
#  rownames(new_observation) <- c("id1", "id2")
#  
#  # make a studio for the model
#  modelStudio(explainer, new_observation)

## ----eval = FALSE-------------------------------------------------------------
#  # load packages and data
#  library(h2o)
#  library(DALEXtra)
#  library(modelStudio)
#  
#  data <- DALEX::titanic_imputed
#  
#  # init h2o
#  h2o.init()
#  h2o.no_progress()
#  
#  # split the data
#  h2o_split <- h2o.splitFrame(as.h2o(data))
#  train <- h2o_split[[1]]
#  test <- as.data.frame(h2o_split[[2]])
#  
#  # h2o automl takes target as factor
#  train$survived <- as.factor(train$survived)
#  
#  # fit a model
#  automl <- h2o.automl(y = "survived", training_frame = train, max_runtime_secs = 30)
#  model <- automl@leader
#  
#  # create an explainer for the model
#  explainer <- explain_h2o(model,
#                           data = test,
#                           y = test$survived,
#                           label = "h2o")
#  
#  # pick observations
#  new_observation <- test[1:2,]
#  rownames(new_observation) <- c("id1", "id2")
#  
#  # make a studio for the model
#  modelStudio(explainer, new_observation,
#              B = 5)
#  
#  # shutdown h2o
#  h2o.shutdown(prompt = FALSE)

## ----eval=FALSE---------------------------------------------------------------
#  # load packages and data
#  library(parsnip)
#  library(DALEX)
#  library(modelStudio)
#  
#  data <- DALEX::apartments
#  
#  # split the data
#  index <- sample(1:nrow(data), 0.7*nrow(data))
#  train <- data[index,]
#  test <- data[-index,]
#  
#  # fit a model
#  model <- rand_forest() %>%
#           set_engine("ranger", importance = "impurity") %>%
#           set_mode("regression") %>%
#           fit(m2.price ~ ., data = train)
#  
#  # create an explainer for the model
#  explainer <- explain(model,
#                       data = test,
#                       y = test$m2.price,
#                       label = "parsnip")
#  
#  # make a studio for the model
#  modelStudio(explainer)

## ----eval=FALSE---------------------------------------------------------------
#  # load packages and data
#  library(tidymodels)
#  library(DALEXtra)
#  library(modelStudio)
#  
#  data <- DALEX::titanic_imputed
#  
#  # split the data
#  index <- sample(1:nrow(data), 0.7*nrow(data))
#  train <- data[index,]
#  test <- data[-index,]
#  
#  # tidymodels fit takes target as factor
#  train$survived <- as.factor(train$survived)
#  
#  # fit a model
#  rec <- recipe(survived ~ ., data = train) %>%
#         step_normalize(fare)
#  
#  clf <- rand_forest(mtry = 2) %>%
#         set_engine("ranger") %>%
#         set_mode("classification")
#  
#  wflow <- workflow() %>%
#           add_recipe(rec) %>%
#           add_model(clf)
#  
#  model <- wflow %>% fit(data = train)
#  
#  # create an explainer for the model
#  explainer <- explain_tidymodels(model,
#                                  data = test,
#                                  y = test$survived,
#                                  label = "tidymodels")
#  
#  # pick observations
#  new_observation <- test[1:2,]
#  rownames(new_observation) <- c("id1", "id2")
#  
#  # make a studio for the model
#  modelStudio(explainer, new_observation)

## ----eval = FALSE-------------------------------------------------------------
#  # package for pickle load
#  install.packages("reticulate")

## ----eval = FALSE-------------------------------------------------------------
#  # load the explainer from the pickle file
#  library(reticulate)
#  explainer <- py_load_object("explainer_scikitlearn.pickle", pickle = "pickle")
#  
#  # make a studio for the model
#  library(modelStudio)
#  modelStudio(explainer, B = 5)

## ----eval = FALSE-------------------------------------------------------------
#  # load the explainer from the pickle file
#  library(reticulate)
#  explainer <- py_load_object("explainer_lightgbm.pickle", pickle = "pickle")
#  
#  # make a studio for the model
#  library(modelStudio)
#  modelStudio(explainer)

## ----eval = FALSE-------------------------------------------------------------
#  # load the explainer from the pickle file
#  library(reticulate)
#  
#  #! add blank create_architecture function before load !
#  py_run_string('
#  def create_architecture():
#      return True
#  ')
#  
#  explainer <- py_load_object("explainer_keras.pickle", pickle = "pickle")
#  
#  # make a studio for the model
#  library(modelStudio)
#  modelStudio(explainer)

