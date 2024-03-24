setwd("E:/Dropbox/abce")

# to access NCBI databases, the personal NCBI API key is needed. https://support.nlm.nih.gov/knowledgebase/article/KA-05317/en-us
Sys.setenv(ENTREZ_KEY="YOURKEYHERE") # replace the string between quotation marks with your API key
# load packages

library(tidyverse)
library(patchwork)
library(nlme)
library(taxize)
library(ape)
library(ggeffects)


# read in data
ABCE.data <- read.table("ABCE_infosheet.tsv", sep = "\t", header = T)

# make species names rownames for the model
rownames(ABCE.data) <- ABCE.data$ncbi.name

# get the relationships of species in the table, based on taxonomy IDs in it and the NCBI taxonomy
taxize_class <- classification(ABCE.data$TaxID, db = "ncbi")

# create and visualize a tree
taxize_tree <- class2tree(taxize_class, check = TRUE)
plot(taxize_tree)

# extract the tree structure to be used in models
phylotree <- taxize_tree$phylo


# create simple linear models and check their summaries
lm(copies ~ assembly_size, data = ABCE.data) %>% summary # R squared 0.2191, adjusted R squared 0.2086
lm(copies ~ wgd, data = ABCE.data) %>% summary # R squared 0.02648, adjusted R squared 0.01332
lm(copies ~ ploidy, data = ABCE.data) %>% summary # R squared 0.3568, adjusted R squared 0.3482

# create models with phylogenetic information included as a random effect and check their summaries
M_size <- gls(copies ~ assembly_size, data = ABCE.data, correlation = corPagel(0, phylotree, ~ncbi.name), method = 'ML')
M_wgd <- gls(copies ~ wgd, data = ABCE.data, correlation = corPagel(0, phylotree, ~ncbi.name), method = 'ML')
M_ploidy <- gls(copies ~ ploidy, data = ABCE.data, correlation = corPagel(0, phylotree, ~ncbi.name), method = 'ML')

summary(M_size)
summary(M_wgd)
summary(M_ploidy)

# the function fails for the assembly size model, will try fixing lambda at the likeliest value beforehand instead of letting it be estimated
# to do this, need to calculate maximum lambda for the  model and double-check it from a likelihood plot

lambda <- seq(0, 1, 0.0001)
pagel <- function(lambda){
  gls(copies ~ assembly_size, data = ABCE.data,
      correlation = corPagel(lambda, phylotree, ~ncbi.name, fixed = TRUE), method = "ML")
}
lik <- sapply(lambda, function(lambda) logLik(pagel(lambda)))
lambdalik <- data.frame(cbind(lik,lambda))
ggplot(lambdalik, aes(x = lambda, y = lik)) + geom_line() +
  geom_vline(xintercept = lambdalik[lambdalik$lik == max(lambdalik$lik),"lambda"], color = "red") +
  theme_bw() + ggtitle(paste0("lambda value for maximum likelihood is: ", lambdalik[lambdalik$lik == max(lambdalik$lik),"lambda"]))

# the optimal lambda value for when using the ML method appears to be 0.3278, fixing it at this value and comparing models with anova
M_size <- gls(copies ~ assembly_size, data = ABCE.data, correlation = corPagel(0.3278, phylotree, ~ncbi.name, fixed = TRUE), method = 'ML')
summary(M_size)
anova(M_size, M_wgd, M_ploidy)
# Model df      AIC      BIC    logLik   Test  L.Ratio p-value
# M_size       1  3 247.6549 254.6471 -120.8274                        
# M_wgd        2  4 266.9682 276.2911 -129.4841 1 vs 2 17.31333  <.0001
# M_ploidy     3  4 241.4795 250.8024 -116.7397 1 vs 3 8.175409  0.0042




# to create a  plot showing the confidence intervals for all effect sizes, we'll have to scale the predictors first to make effect sizes comparable.
M_size.scaled <- gls(copies ~ scale(assembly_size), data = ABCE.data, correlation = corPagel(0.3278, phylotree, ~ncbi.name, fixed = TRUE), method = 'ML')
M_wgd.scaled <- gls(copies ~ scale(wgd), data = ABCE.data, correlation = corPagel(0, phylotree, ~ncbi.name), method = 'ML')
M_ploidy.scaled <- gls(copies ~ scale(ploidy), data = ABCE.data, correlation = corPagel(0, phylotree, ~ncbi.name), method = 'ML')

# from model summaries, the effect sizes are
# 0.1536387 +/- 0.1780889 for wgd
# 0.7257182 +/- 0.1276678 for ploidy
# 0.6246957 +/- 0.1406414 for assembly size

dat <- data.frame(
  Index = c(1, 2, 3),
  label = c("Ancient WGD events", "ploidy", "Assembly size"),
  Slope = c(0.1536387, 0.7257182, 0.6246957),
  LowerLimit = c(-0.0244502, 0.5980504, 0.4840543),
  UpperLimit = c(0.3317276, 0.853386, 0.7653371),
  CI = c("-0.0244502, 0.3317276", "0.5980504, 0.853386", "0.4840543, 0.7653371")
)


copy_classes <- ABCE.data$copies %>% unique() %>% sort() %>% as.factor()
copy_data <- ABCE.data$copies %>% table() %>% as.data.frame()
colnames(copy_data) <- c("copies", "counts")
copy_data$copies <- factor(copy_data$copies, level = c("8", "5", "4", "3", "2", "1"))


# create a pie chart for copy number classes, add labels later manually

plot0 <- ggplot(copy_data, aes(x="", y = counts, fill = copies)) +
  geom_bar(width = 1, stat = "identity", color = "white") +
  coord_polar("y", start = 0) +
  scale_fill_manual(values = c("#70ad47", "#5b9bd5", "#ffc000", "#a5a5a5", "#a9d18e", "#ffe699")) +
  theme_void() + theme(legend.position = "none")

# create a forest plot for effect sizes with 95% confidence intervals

plot1 <- ggplot(dat, aes(x = Slope, y = Index)) +
  geom_point(shape = 18, size = 5) +  
  geom_errorbarh(aes(xmin = LowerLimit, xmax = UpperLimit), height = 0.25) +
  geom_vline(xintercept = 0, color = "tomato", linetype = "dashed", cex = 1) +
  scale_y_continuous(name = "", breaks=1:3, labels = dat$label, trans = "reverse") +
  xlab("Scaled effect size (95% CI)") + 
  ylab("") + 
  theme_bw() +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), 
        axis.line = element_line(color = "black"),
        axis.text.y = element_text(size = 11, color = "black"),
        axis.text.x.bottom = element_text(size = 11, color = "black"),
        axis.title.x = element_text(size = 11, color = "black"),
        axis.title.y = element_blank(),
        panel.border = element_blank(),
        panel.background=element_rect(colour="black")
        )


# next, plotting the original data points with both regular linear regression and the results from mixed model with phylogeny
# using blue for gls and black/gray for lm
# adding 95% confidence intervals to both


plotdata.gensize <- ggpredict(M_size, "assembly_size", type = 'random')
plot2  <- ggplot(data = ABCE.data, aes(assembly_size, copies)) +
  geom_point() +
  geom_ribbon(data = plotdata.gensize, aes(x, predicted, ymin = conf.low, ymax = conf.high), alpha = 0.1, fill = 'blue') +
  geom_smooth(method = 'lm', colour = 'black', linewidth = 0.5) +
  geom_line(data = plotdata.gensize, aes(x, predicted), size = 0.8, color = 'blue') +
  theme_bw() + xlab("Assembly size") + ylab("ABCE copy number") +
  theme(axis.title.x = element_text(color = "black"),
        axis.title.y = element_text(color = "black"),
        axis.text.x = element_text(color = "black"),
        axis.text.y = element_text(color = "black"),
        panel.border = element_blank(),
        panel.background=element_rect(colour="black")) +
  ylim(-2,12)

plotdata.wgd <- ggpredict(M_wgd, "wgd", type = 'random')
plot3 <- ggplot(data = ABCE.data, aes(wgd, copies)) +
  geom_point() +
  geom_ribbon(data = plotdata.wgd, aes(x, predicted, ymin = conf.low, ymax = conf.high), alpha = 0.1, fill = 'blue') +
  geom_smooth(method = 'lm', colour = 'black', linewidth = 0.5) +
  geom_line(data = plotdata.wgd, aes(x, predicted), size = 0.8, color = 'blue') +
  theme_bw() + xlab("Ancient WGD events") + ylab("ABCE copy number") +
  theme(axis.title.x = element_text(color = "black"),
        axis.title.y = element_text(color = "black"),
        axis.text.x = element_text(color = "black"),
        axis.text.y = element_text(color = "black"),
        panel.border = element_blank(),
        panel.background=element_rect(colour="black")) +
  ylim(-2,12)

plotdata.ploidy <- ggpredict(M_ploidy, "ploidy", type = 'random')
plot4 <- ggplot(data = ABCE.data, aes(ploidy, copies)) +
  geom_point() +
  geom_ribbon(data = plotdata.ploidy, aes(x, predicted, ymin = conf.low, ymax = conf.high), alpha = 0.1, fill = 'blue') +
  geom_smooth(method = 'lm', colour = 'black', linewidth = 0.5) +
  geom_line(data = plotdata.ploidy, aes(x, predicted), size = 0.8, color = 'blue') +
  theme_bw() + xlab("ploidy") + ylab("ABCE copy number") +
  theme(axis.title.x = element_text(color = "black"),
        axis.title.y = element_text(color = "black"),
        axis.text.x = element_text(color = "black"),
        axis.text.y = element_text(color = "black"),
        panel.border = element_blank(),
        panel.background=element_rect(colour="black")) +
  ylim(-2,12)




pdf("abce_regression_v3.pdf", width = 8, height = 6)
  (plot0 + plot1) / (plot2 + plot3 + plot4) + plot_layout(heights = c(2, 1))
dev.off()
