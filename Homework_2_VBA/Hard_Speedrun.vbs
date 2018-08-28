Public CalcState As Long
Public EventState As Boolean
Public PageBreakState As Boolean

Sub OptimizeCode_Begin()

    Application.ScreenUpdating = False

    EventState = Application.EnableEvents
    Application.EnableEvents = False
    
    CalcState = Application.Calculation
    Application.Calculation = xlCalculationManual
    
    PageBreakState = ActiveSheet.DisplayPageBreaks
    ActiveSheet.DisplayPageBreaks = False

End Sub

Sub OptimizeCode_End()

    ActiveSheet.DisplayPageBreaks = PageBreakState
    Application.Calculation = CalcState
    Application.EnableEvents = EventState
    Application.ScreenUpdating = True

End Sub

Sub WallStreetVBA():
    For Each ws In Worksheets
        Dim Ticker_Name as string 
        Ticker_Name = ws.Cells(2, 1).Value
        Dim Yearly_Change As Double
        Dim Opening_Price as Double
        Dim Closing_Price as Double
        Opening_Price = ws.Cells(2,3).Value
        Dim Volume_Total as Double
        Volume_Total = 0
        Dim Greatest_Percent_Increase_Value as Double
        Dim Greatest_Percent_Increase_Row as Integer
        Dim Greatest_Percent_Decrease_Value as Double
        Dim Greatest_Percent_Decrease_Row as Integer
        Dim Greatest_Total_Volume_Value as Double
        Dim Greatest_Total_Volume_Row as Integer
        Dim Summary_Table_Row As Integer
        Summary_Table_Row = 2
        LastRow = ws.Cells(Rows.Count, 1).End(xlUp).Row + 1
        ws.Range("I1").Value = "Ticker Name"
        ws.Range("L1").Value = "Total Stock Volume"
        ws.Range("J1").Value = "Yearly Change"
        ws.Range("K1").Value = "Percent Change"
        ws.Range("O1").value = "Ticker"
        Ws.Range("P1").value = "Value"
        ws.Cells(2, 14).Value = "Greatest % Increase"
        ws.Cells(3, 14).Value = "Greatest % Decrease"
        ws.Cells(4, 14).Value = "Greatest Total Volume"

        For i = 2 To LastRow 
            If Ticker_Name = ws.Cells(i, 1).Value Then
                Volume_Total = Volume_Total + ws.Cells(i, 7).Value
                
                If Opening_Price = 0 and ws.Cells(i, 3).value <> 0 Then
                    Opening_Price = ws.Cells(i, 3).Value
                End If
            else
                ws.Range("I" & Summary_Table_Row).Value = Ticker_Name
                ws.Range("L" & Summary_Table_Row).Value = Volume_Total

                Closing_Price = ws.Cells(i-1, 6).value 
                Yearly_Change = Closing_Price - Opening_Price
                ws.Range("J" & Summary_Table_Row).Value = Yearly_Change
                ws.Range("K" & Summary_Table_Row).Value = Format ((Yearly_Change/ Opening_Price), "Percent")
                If Yearly_Change >= 0 Then
                    ws.Range("J" & Summary_Table_Row).Interior.Color = vbGreen
                else
                    ws.Range("J" & Summary_Table_Row).Interior.Color = vbRed
                End If
                Summary_Table_Row = Summary_Table_Row + 1
                Volume_Total = ws.Cells(i, 7).Value
                Ticker_Name = ws.Cells(i, 1).Value
                Opening_Price = ws.Cells(i, 3).value 
            End If 
        Next i 
        Greatest_Percent_Increase_Value = WorksheetFunction.Max(ws.Range("K2:K" & Summary_Table_Row))
        Greatest_Percent_Increase_Row = WorksheetFunction.Match(Greatest_Percent_Increase_Value, ws.Range("K2:K" & Summary_Table_Row), 0)
        Greatest_Percent_Decrease_Value = WorksheetFunction.Min(ws.Range("K2:K" & Summary_Table_Row))
        Greatest_Percent_Decrease_Row = WorksheetFunction.Match(Greatest_Percent_Decrease_Value, ws.Range("K2:K" & Summary_Table_Row), 0)
        Greatest_Total_Volume_Value = WorksheetFunction.Max(ws.Range("L2:L" & Summary_Table_Row))
        Greatest_Total_Volume_Row = WorksheetFunction.Match(Greatest_Total_Volume_Value, ws.Range("L2:L" & Summary_Table_Row), 0)

        ws.Cells(2, 15).Value = ws.Range("I" & Greatest_Percent_Increase_Row + 1)
        ws.Cells(2, 16).Value = Format (Greatest_Percent_Increase_Value, "Percent")
        ws.Cells(3, 15).Value = ws.Range("I" & Greatest_Percent_Decrease_Row + 1)
        ws.Cells(3, 16).Value = Format (Greatest_Percent_Decrease_Value, "Percent")
        ws.Cells(4, 15).Value = ws.Range("I" & Greatest_Total_Volume_Row + 1)
        ws.Cells(4, 16).Value = Greatest_Total_Volume_Value
        ws.Cells(4, 16).NumberFormat = "General"
    Next ws
    Call OptimizeCode_End
End Sub