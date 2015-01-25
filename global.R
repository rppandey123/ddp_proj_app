library(reshape2) #for dcast
library(fmsb) # for radarchart

# reading original data
nriData <- read.table("../data/GITR_2014_data_platform.csv", header=TRUE, sep="\t",
                      dec = ",", stringsAsFactors=FALSE, fill = TRUE, quote = "\"")

names(nriData)[1] <- "Edition" # strange characters at the beginning (encoding problems?)

# transforimng into wide form
nriData.wide <- dcast(nriData, Edition + Entity.code + Entity ~ GLOBAL.ID, value.var="Value")

# joining information about country and year
country <- paste0(nriData.wide$Entity, ", ", nriData.wide$Edition)
nriData.wide$Country <- country # new column 'Country' added, this will be 'key column'

# sorting data
nriData.wide <- nriData.wide[order(nriData.wide$Country),]

# labels for radar plot
nri.labels <- c("NRI",
                "Environment", "Political and regulatory environment (A)", 
                "Business and innovation environment (A)",
                "Readiness", "Infrastructure and digital content (B)", "Affordability (B)", 
                "Skills (B)",
                "Usage", "Individual usage (C)", "Business usage (C)", "Government usage (C)",
                "Impact", "Economic impacts (D)", "Social impacts (D)")
dims.lab <- nri.labels[c(3:4, 6:8, 10:12, 14:15)]

# these labels will help to chose proper columns from data
dims <- c("Country",
          "NRI.A.01", "NRI.A.02", "NRI.B.03", "NRI.B.04", "NRI.B.05", 
          "NRI.C.06", "NRI.C.07", "NRI.C.08", "NRI.D.09", "NRI.D.10")

# basic data frame with minimum and maximum values fo radar plot
# (see ?radarchart for explanation)
r.data <- as.data.frame(rbind(c(NA,rep(7,10)), 
                              c(NA,rep(0,10))
                              )
)
names(r.data) <- dims

# these columns will be downloaded 
dims.download <- c("Country", "NRI.A", "NRI.B", "NRI.C", "NRI.D",
          "NRI.A.01", "NRI.A.02", "NRI.B.03", "NRI.B.04", "NRI.B.05", 
          "NRI.C.06", "NRI.C.07", "NRI.C.08", "NRI.D.09", "NRI.D.10")

