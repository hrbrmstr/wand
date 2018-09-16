seq_in <- function(source_vector, pattern_vector) {

  which(
    Reduce(
      '+',
      lapply(
        seq_along(y <- lapply(pattern_vector, '==', source_vector)),
        function(x) {
          y[[x]][x:(length(source_vector) - length(pattern_vector) + x)]
        }
      )
    ) == length(pattern_vector)
  )

}
