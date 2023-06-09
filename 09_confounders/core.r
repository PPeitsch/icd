# Library imports
library(tidyverse)
library(modelr)

# Folder names
data_folder <- "data"
fig_folder <- "fig"

# Dataset copy
df_iris <- iris

# First model
modelo = lm(Sepal.Length ~ Sepal.Width, data=df_iris)
df_iris_mod <- add_predictions(data=df_iris, model=modelo) %>% add_residuals(model=modelo)
# Graph
p1 <- ggplot(data=df_iris) + 
        geom_point(aes(x=Sepal.Width, y=Sepal.Length, color=Species), size=3) +
        geom_line(data=df_iris_mod, aes(x=Sepal.Width, y=pred), color='Blue', size=1.5) +
        theme(axis.line = element_line(colour = "black", size = 1), text = element_text(size = 30),
              plot.title = element_text(color="Black", size=30, face="bold")) +
        labs(x="width", y="length", title="Sepal length and width")
fig1_name <- "fig1.jpeg"
# Residual graph
p2 <- ggplot(data=modelo, aes(y = .resid)) +
        geom_boxplot() +
        labs(title='Boxplot: Residuals', y='Residuals value') +
        theme(axis.line = element_line(colour = "black", size = 1), text = element_text(size = 40),
              plot.title = element_text(color="Black", size=40, face="bold"))
fig2_name <- "fig2.jpeg"


# Second model
modelo2 = lm(Sepal.Length ~ Sepal.Width + Species, data=df_iris)
df_iris_mod2 <- add_predictions(data=df_iris, model=modelo2) %>% add_residuals(model=modelo2)
# Graph
p3 <- ggplot(data=df_iris) + 
        geom_point(aes(x=Sepal.Width, y=Sepal.Length, color=Species), size=3) +
        geom_line(data=df_iris_mod2, aes(x=Sepal.Width, y=pred, color=Species), size=1.5) +
        theme(axis.line = element_line(colour = "black", size = 1), text = element_text(size = 30),
              plot.title = element_text(color="Black", size=30, face="bold"), legend.position=c(0.9, 0.2)) +
        labs(x="width", y="length", title="Sepal length and width, Species as counfounder variable") +
        facet_wrap(~Species, nrow=2)
fig3_name <- "fig3.jpeg"
# Residual graph
p4 <- ggplot(data=modelo2, aes(y = .resid)) +
        geom_boxplot() +
        labs(title='Boxplot: Residuals', y='Residuals value') +
        theme(axis.line = element_line(colour = "black", size = 1), text = element_text(size = 40),
              plot.title = element_text(color="Black", size=40, face="bold"))
fig4_name <- "fig4.jpeg"