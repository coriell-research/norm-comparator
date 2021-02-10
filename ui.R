library(shiny)


ui <- fluidPage(
  titlePanel("Explore Normalization Methods"),
  sidebarLayout(
    sidebarPanel(
      width = 2,
      h3("Step 1. Import and Load Data"),
      p("The SummarizedExperiment object must contain an assay with raw 
              counts named 'counts' and colData with a column named 'group' 
              specifying the grouping factor for the samples. Other metadata 
              columns can be present but 'group' is necessary."),
      fileInput("se",
        label = "Import SummarizedExperiment",
        accept = c(".rds")
      ),
      actionButton("load",
        label = "Load Dataset",
        width = "100%"
      ),
      h3("Step 2. Filtering Parameters"),
      numericInput("min_count",
        label = "Min Count per Group",
        value = 10
      ),
      numericInput("min_total_count",
        label = "Minimum Total Count per Feature",
        value = 15
      ),
      numericInput("min_prop",
        label = "Minimum Proportion per Group",
        value = 0.7
      ),
      h3("Step 3. Normalization Parameters"),
      numericInput("percentile",
        label = "Percentile for UQ Normalization",
        value = 0.7
      ),
      numericInput("pseudocount",
        label = "Pseudocount for logCPM calculations",
        value = 2
      ),
      selectInput("reference_col",
        label = "Enter reference column for TMM normalization (optional)",
        choices = NULL
      ),
      fileInput("control_genes",
        label = "Upload a list of control genes for RUVg",
        accept = c(".rds")
      ),
      numericInput("K",
        label = "Enter Number Factors (k) for RUVg",
        value = 2
      ),
      h3("Step 4. Run"),
      actionButton("run",
        label = "Run filtering and normalization",
        width = "100%"
      )
    ),

    mainPanel(
      tabsetPanel(
        tabPanel(
          "Filtering",
          selectInput("hist_sample",
            label = "Select Sample To View Distribution",
            choices = NULL
          ),
          numericInput("hist_pseudocount",
            label = "Pseudocount after filtering",
            value = 0
          ),
          sliderInput("hist_bins",
            label = "Enter number of bins",
            value = 30, min = 5, max = 100
          ),
          h3("Raw Data"),
          plotOutput("raw_hist"),
          h3("Filtered Data"),
          plotOutput("filt_hist")
        ),
        tabPanel(
          "RLE",
          selectInput("rle_norm_method",
            label = "Select normalization Method",
            choices = c(list("TMM" = "logTMM", "RLE" = "logRLE", "UQ" = "logUQ", "RUVg" = "logRUVg", "QS" = "logQS", "LibrarySize" = "logLibrarySize")),
            selected = "TMM"
          ),
          selectInput("rle_fill_by",
            label = "Fill by",
            choices = NULL
          ),
          numericInput("rle_outlier_shape",
            label = "Outlier shape",
            value = NA
          ),
          numericInput("rle_outlier_alpha",
            label = "Outlier alpha",
            value = 0.5
          ),
          plotOutput("rle")
        ),
        tabPanel(
          "MA",
          selectInput("ma_norm_method",
            label = "Select normalization method",
            choices = c("TMM", "RLE", "UQ", "RUVg", "QS", "LibrarySize"),
            selected = "TMM"
          ),
          selectInput("ma_sample1",
            label = "Sample 1",
            choices = NULL
          ),
          selectInput("ma_sample2",
            label = "Sample 2",
            choices = NULL
          ),
          checkboxInput("ma_smooth",
            label = "Smooth scatter",
            value = FALSE
          ),
          checkboxInput("ma_loess",
            label = "Plot lowess line",
            value = FALSE
          ),
          plotOutput("ma")
        ),
        tabPanel(
          "Scatter",
          selectInput("scatter_norm_method",
            label = "Select normalization method",
            choices = c("TMM", "RLE", "UQ", "RUVg", "QS", "LibrarySize"),
            selected = "TMM"
          ),
          selectInput("scatter_sample1",
            label = "Sample 1",
            choices = NULL
          ),
          selectInput("scatter_sample2",
            label = "Sample 2",
            choices = NULL
          ),
          numericInput("scatter_pt_alpha",
            label = "Point Alpha",
            value = 0.5
          ),
          checkboxInput("scatter_log",
            label = "Log scale axis",
            value = TRUE
          ),
          plotOutput("scatter")
        ),
        tabPanel(
          "PCA",
          selectInput("pca_norm_method",
            label = "Select normalization Method",
            choices = c(list("TMM" = "logTMM", "RLE" = "logRLE", "UQ" = "logUQ", "RUVg" = "logRUVg", "QS" = "logQS", "LibrarySize" = "logLibrarySize")),
            selected = "TMM"
          ),
          checkboxInput("pca_scale",
            label = "Scale data",
            value = TRUE
          ),
          checkboxInput("pca_center",
            label = "Center data",
            value = TRUE
          ),
          selectInput("pca_component1",
            label = "X-axis",
            choices = c("PC1", "PC2", "PC3", "PC4", "PC5"),
            selected = "PC1"
          ),
          selectInput("pca_component2",
            label = "Y-axis",
            choices = c("PC1", "PC2", "PC3", "PC4", "PC5"),
            selected = "PC1"
          ),
          selectInput("pca_color_by",
            label = "Color by",
            choices = NULL
          ),
          selectInput("pca_shape_by",
            label = "Shape by",
            choices = NULL
          ),
          plotOutput("pca")
        )
      )
    )
  )
)
