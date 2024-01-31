# Bulk RNA-Sequencing
# There are several ways of identifying a gene symbol from Ensembl transcript codes (ENST...) in R
# Unfortunately the Ensembl servers have become unreliable recently which precludes the `biomaRt` 
# methods. 

# This is a simple workaround that does not rely on connection to a remote server
# beyond the package installation process. 

library(dplyr)
BiocManager::install("EnsDb.Hsapiens.v86")
BiocManager::install("AnnotationDbi")

# transcripts from count data frame
transcript_list <- row.names(counts_df)

# Transcripts may have a suffix depending on the aligment tools used to identify them. 
# Remove these.

transcript_list_clean <- stringr::str_replace(transcript_list,
                        pattern = ".[0-9]+$",
                        replacement = "")

library(EnsDb.Hsapiens.v86)
# this is a database object for the human genome that can be accessed using 
# AnnotationDbi functions 
 
db <- EnsDb.Hsapiens.v86

annotated_transcript_list <- AnnotationDbi::select(db, 
                                                   keys = transcript_list_clean,
                                                   columns = c("ENTREZID", "SYMBOL", "GENEID", "GENENAME"),
                                                   keytype = "TXID") %>% 
                            tibble::as_tibble()



