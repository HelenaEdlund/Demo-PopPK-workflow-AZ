
render_model_eval <- function(runno, keep_png=TRUE) {
  
  rmarkdown::render(
    "Scripts/Functions/model_evaluation.Rmd", 
    params = list(model_to_eval = runno, 
                  keep_png = keep_png),
    output_file = 
      file.path(find_root(has_file("OpenProject.Rproj")), 
                "Results",
                "Models",
                paste0("model_evaluation_run", runno, ".html")
      )
  )
}

render_model_vpc <- function(runno, keep_png=TRUE) {
  
  rmarkdown::render(
    "Scripts/Functions/vpc.Rmd", 
    params = list(model_to_eval = runno, 
                  keep_png = keep_png),
    output_file = 
      file.path(find_root(has_file("OpenProject.Rproj")), 
                "Results",
                "Models",
                paste0("vpcs_run", runno, ".html")
      )
  )
}
