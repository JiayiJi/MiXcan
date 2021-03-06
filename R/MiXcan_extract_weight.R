#' Extract the gene expression prediction weights matrix

#' Extract the gene expression prediction weights matrix (elastic net regression coefficients) from MiXcan() function.
#' The output can be directly applied to GWAS data for cell-type specific TWAS.
#'
#' @param MiXcan_model A direct output from MiXcan() function, which includes the
#' prediction weights as well as other summaries of the prediction models.
#'
#' @return A data frame with weight for cell 1 and 2, including the potential meta data for the SNP
#' @export
#'
#' @examples
MiXcan_extract_weight <- function(MiXcan_model) {
  result_weight_gene_once <-
    MiXcan_model$beta.SNP.cell1[c("nameMatrix", "weight")] %>%
    rename(weight_cell_1 = weight) %>%
    inner_join(MiXcan_model$beta.SNP.cell2[c("nameMatrix", "weight")] %>%
                 rename(weight_cell_2 = weight)) %>%
    mutate(type = MiXcan_model$type) %>%
    filter(!(weight_cell_1 == 0 & weight_cell_1 == 0))

  return(result_weight_gene_once)
}

