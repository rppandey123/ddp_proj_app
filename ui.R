library(shiny)

shinyUI(pageWithSidebar(
    ### Title
    headerPanel("Developing Data Product - course project"),
    
    ### SidebarPanel
    sidebarPanel(
        p('The ',strong('Networked Readiness Index'), ' (NRI) presented in the annual report of the 
          World Economic Forum is (briefly speaking) an indicator of how well countries
          use and are prepared to use information and telecommunication technologies (ICT). 
          It is calculated as a mean of four subindexes, which measure ', strong('environment '), 
          'for ICTs (A), the ', strong('readiness '), 'of a society to to use ICTs (B), 
          the actual ', strong('usage '), 'of ICTs of all main stakeholders (i.e. individuals, 
          business and government) (C) and the ', strong('impact'), ' of
          ICTs for economy and society (D).'),
        p('These four measures can be further decomposite into 10 sub-subindexes. This simple application
          allows to compare two countries (as well as the same country in different years) in 
          terms of these 10 indicators.'),
        br(),
        selectInput('country1', 'Select first country:', choices=nriData.wide$Country,
                    selected="United States, 2014"),
        selectInput('country2', 'Select second country:', choices=nriData.wide$Country,
                    selected="United Kingdom, 2014"),
        br(),
        p('Read more:', a('The Global Information Technology Report 2014', 
                          href='http://www.weforum.org/reports/global-information-technology-report-2014')),
        p('The data used in this application come from ', 
        a('this', href='http://www.weforum.org/global-information-technology-report-2014-data-platform'), 
        ' site, but if you want to download simplified version of the data (e. g. for your own analysis) 
        just click the button below:'),
        downloadButton('download', 'Download')
    ),
    
    ### MainPanel
    mainPanel(
        plotOutput('radarPlot', height = "600px"),
        tableOutput('table')
    )
)
)


