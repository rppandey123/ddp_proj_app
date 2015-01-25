

shinyServer(
    function(input, output) {
        
        # forming dataframe fo radar plot
        radar.data <- reactive({
            rbind(r.data,
                  nriData.wide[nriData.wide$Country==input$country1, dims],
                  nriData.wide[nriData.wide$Country==input$country2, dims]
            )
            })
        
        # preparing radarplot
        output$radarPlot <- renderPlot({
            
            radarchart(radar.data()[,-1], axistype=1, seg=7, centerzero=T, 
                       vlabels=dims.lab, caxislabels=0:7, axislabcol=1, calcex=0.8,
                       vlcex=0.9, plty=1, pcol=c(2,4), cglcol="darkgrey")
            legend("topright", lty="solid", col = c(2,4), pch=16, cex=1,
                   legend = radar.data()[3:4,1], bty="n")
        })
        
        # table with values
        # this is because I don't know how to diplay values on the plot
        output$table <- renderTable({radar.data()[3:4,]})
        
        # function preparing data to download
        output$download <- downloadHandler(
            filename = function() { 'NRIsimpleData.csv' },
            content = function(file) {
                write.csv(nriData.wide[,dims.download], file, row.names = FALSE)
            }
        )
    }
)

