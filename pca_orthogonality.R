# Caculate whether two sets of data are orthogonal in the PCA space by caluclating the dot products
# of their loadings

# generate dummy data

library(dplyr)
library(tibble)

set_A <- c("biomarker_A",
           "biomarker_B",
           "biomarker_C",
           "biomarker_D")

set_B <- c("mediator_A",
           "mediator_B",
           "mediator_C",
           "mediator_D", 
           "mediator_E")

set.seed(123)
data <- matrix(rnorm(100 * 11), ncol=11)

colnames(data) <- c(set_A, set_B)

# create PCA object

combined_pca <- 
  prcomp(data)

# extract loadings
# the loadinga are the unit eigenvectors from the SVD

combined_loadings <- 
  combined_pca$rotation %>% 
  data.frame %>% 
  tibble::rownames_to_column("marker") %>% 
  mutate(bio_type = ifelse(marker %in% Set_A, 
                           "biomarker", "mediator"))

biomarker_loadings <- 
  combined_loadings %>% 
  dplyr::filter(bio_type== "biomarker") %>% 
  dplyr::select(-marker,-bio_type)

  
mediator_loadings <- 
  combined_loadings %>% 
  dplyr::filter(bio_type == "mediator") %>% 
  dplyr::select(-marker,-bio_type) 

# scale each loading by the explainable variance and calculate the means for each 
# marker type

explained_variance <- 
  (combined_pca$sdev^2) / sum(combined_pca$sdev^2)

biomarker_mean_loading <- 
  as.vector(colMeans(biomarker_loadings * explained_variance))
  
mediator_mean_loading <- 
  as.vector(colMeans(mediator_loadings * explained_variance))

dot_product <- sum(biomarker_loadings * mediator_loadings)

# a dot product of zero implies orthogonality

# calcuate the angle ($/theta$) between the two mean vectors

cos_theta <- 
  sum(biomarker_mean_loading * mediator_mean_loading) / 
  (sqrt( sum(biomarker_loadings^2)) * 
     sqrt( sum(mediator_loadings^2)) )

theta_radians <- acos(cos_theta)

theta_radians 

# if theta radians ~ pi/2 then we can say that Set A and Set B are orthogonal






