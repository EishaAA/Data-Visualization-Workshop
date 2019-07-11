library(circlize)

rm(list=ls())


# Generating a chord diagram ================================
# Full Documentation: https://jokergoo.github.io/circlize_book/book/the-chorddiagram-function.html

# Make a random adjacency matrix
set.seed(999)
mat = matrix(sample(18, 18), 3, 6) 
rownames(mat) = paste0("S", 1:3)
colnames(mat) = paste0("E", 1:6)

# then generate the corresponding adjacency list in a data frame
df = data.frame(from = rep(rownames(mat), times = ncol(mat)),
                to = rep(colnames(mat), each = nrow(mat)),
                value = as.vector(mat),
                stringsAsFactors = FALSE)

# now to make the actual chord diagram
chordDiagram(mat) # can be done with mat or df
circos.clear() # clear for the next circos plot (so it doesn't layer)

