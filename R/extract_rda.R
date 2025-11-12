extract_rda <- function(
  res_rda,
  scaling = 1,
  select_spe = NULL,
  site_sc = "lc",
  mult_spe = 1,
  mult_arrow = 1,
  optimum = TRUE,
  plot_centr = TRUE,
  label_centr = TRUE
) {
  'stretch' <- function(sites, mat, ax1 = 1, ax2 = 2, n) {
    # Compute stretching factor for the species or environmental arrows
    # First, compute the longest distance to centroid for the sites
    tmp1 <- rbind(c(0, 0), sites[, c(ax1, ax2)])
    D <- dist(tmp1)
    target <- max(D[1:n])
    # Then, compute the longest distance to centroid for the species or
    # environmental arrows
    if (is.matrix(mat)) {
      p <- nrow(mat)
      tmp2 <- rbind(c(0, 0), mat[, c(ax1, ax2)])
      D <- dist(tmp2)
      longest <- max(D[1:p])
    } else {
      tmp2 <- rbind(c(0, 0), mat[, c(ax1, ax2)])
      longest <- dist(tmp2)
    }
    fact <- target / longest
  }
  
  centroids <- NULL
  n_sp <- length(res_rda$colsum)
  k <- length(res_rda$CCA$eig)

  if (is.null(select_spe)) {
    vec <- 1:n_sp
  } else {
    vec <- select_spe
  }

  Tot_var <- res_rda$tot.chi
  eig_val <- c(res_rda$CCA$eig, res_rda$CA$eig)
  Lambda <- diag(eig_val)
  eig_val_rel <- eig_val / Tot_var
  Diag <- diag(sqrt(eig_val_rel))
  U_sc1 <- cbind(res_rda$CCA$v, res_rda$CA$v)
  U_sc2 <- U_sc1 %*% sqrt(Lambda)
  colnames(U_sc2) <- colnames(U_sc1)
  n <- nrow(res_rda$CCA$u)
  Z_sc2 <- cbind(res_rda$CCA$u, res_rda$CA$u) * sqrt(n - 1)
  Z_sc1 <- Z_sc2 %*% sqrt(Lambda)
  colnames(Z_sc1) <- colnames(Z_sc2)
  F_sc2 <- cbind(res_rda$CCA$wa, res_rda$CA$u) * sqrt(n - 1)
  F_sc1 <- F_sc2 %*% sqrt(Lambda)
  colnames(F_sc1) <- colnames(F_sc2)
  BP_sc2 <- res_rda$CCA$biplot
  BP_sc2 <- cbind(
    BP_sc2,
    matrix(0, nrow = nrow(BP_sc2), ncol = length(eig_val) - k)
  )
  colnames(BP_sc2) <- colnames(F_sc2)
  BP_sc1 <- BP_sc2 %*% Diag
  colnames(BP_sc1) <- colnames(BP_sc2)

  if (!is.null(res_rda$CCA$centroids)) {
    centroids_sc2 <- res_rda$CCA$centroids * sqrt(n - 1) # Centroids, scaling=2
    centroids_sc2 <- cbind(
      centroids_sc2,
      matrix(
        0,
        nrow = nrow(centroids_sc2),
        ncol = length(eig_val) - k
      )
    )
    colnames(centroids_sc2) <- colnames(F_sc2)
    centroids_sc1 <- centroids_sc2 %*% sqrt(Lambda) # Centroids, scaling=1
    colnames(centroids_sc1) <- colnames(centroids_sc2)
  }
  centroids_present <- TRUE
  if (is.null(res_rda$CCA$centroids)) {
      centroids_present <- FALSE
      if (plot_centr | label_centr) {
        plot_centr  <- FALSE
        label_centr <- FALSE
      }
    }

  if (scaling == 1) {
    if (site_sc == "lc") {
      sit_sc <- Z_sc1
    } else {
      sit_sc <- F_sc1
    }
    spe_sc <- U_sc1[vec, ]
    BP_sc <- BP_sc1
    if (centroids_present) {
      centroids <- centroids_sc1
    }
  }

  fact_spe <- 1
  fact_env <- 1
  if (centroids_present & (plot_centr | label_centr)) {
    to_plot <- which(!(rownames(BP_sc) %in% rownames(centroids)))
  } else {
    to_plot <- 1:nrow(BP_sc)
  }

  if (optimum) {
    fact_spe <- stretch(sit_sc, spe_sc, n = n)
    if (length(to_plot > 0)) {
      fact_env <- stretch(
        sit_sc,
        BP_sc[to_plot, ],
        n = n
      )
    }
  }

  spe_sc <- spe_sc * fact_spe * mult_spe
  BP_sc <- BP_sc * fact_env * mult_arrow

  # Return coordinates of everything and additional info

  anov <- anova(res_rda)

  list(
    site_scores = sit_sc,
    species_scores = spe_sc,
    env_scores = BP_sc,
    centroids = centroids,
    F = round(anov[1, 3], 2),
    p_value = round(anov[1, 4], 3),
    r_sq_adj = round(RsquareAdj(res_rda)$adj.r.squared, 3),
    var_perc = round(summary(res_rda)$cont$importance[2, ] * 100, 2)
  )
}