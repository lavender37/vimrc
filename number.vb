Option Explicit

Sub NumbertingCell()
    Dim select_cell As Range
    Dim cell_string_hex As String
    Dim string_array() As String
    Dim i As Integer
    Dim string_return As String
    Dim string_note As String
    
    Application.SendKeys "^g ^a {DEL}"
    
    'string_note = "&H1,&H30"  '\
    string_note = "&H2E,&H0" '.
    
    For Each select_cell In Application.Selection.Cells
        Debug.Print select_cell.Value
        'transform string to bitearray
        cell_string_hex = UnicodeToByteArray(select_cell.Value)
        'split string by chr(10)
        string_array = Split(cell_string_hex, ",&HA,&H0,")
        
        ' add numbering
        For i = 0 To UBound(string_array)
            Dim string_tmp As String
             string_tmp = UnicodeToByteArray(CStr(i + 1)) & "," & string_note & string_return & "," & string_array(i) & "," & "&HA,&H0"
             Debug.Print "line" & i + 1 & ": "; ByteArray(string_tmp)
             string_array(i) = string_tmp
        Next i
        
        'get the string
        For i = 0 To UBound(string_array) - 1
             string_return = string_return & string_array(i) & ","
        Next i
        string_return = string_return & string_array(UBound(string_array))
        
        Debug.Print string_return
        'transform bitearray to string
        Cells(5, 5).Value = ByteArray(string_return)
        
    Next select_cell
End Sub

Sub test()
    Dim select_cell As Range
    
    Application.SendKeys "^g ^a {DEL}"
    
    For Each select_cell In Application.Selection.Cells
        Debug.Print UnicodeToByteArray(select_cell.Value)
    Next select_cell
    Dim y As String
    y = ByteArray("&H31, &H0, &H2E, &H0, &H20, &H0, &HA6, &H53, &HE8, &H95, &H3, &H8C, &H74, &H65, &HE8, &H90, &H72, &H7F, &H55, &H53, &HF, &H5C, &H3A, &H53, &H86, &H89, &HD6, &H76, &H55, &H53, &HD9, &H7A, &H86, &H89, &HD6, &H76, &HA, &H0, &H32, &H0, &H2E, &H0, &H20, &H0, &HA6, &H53, &HE8, &H95, &H53, &H90, &HEF, &H8D, &HFB, &H6D, &HA0, &H52, &H55, &H0, &H52, &H0, &H53, &H0, &H49, &H0, &H4E, &H0, &H52, &H0, &HFE, &H56, &H42, &H5C, &HA, &H0, &H33, &H0, &H2E, &H0, &H20, &H0, &HA6, &H53, &HE8, &H95, &HFB, &H6D, &HA0, &H52, &H3A, &H53, &HBF, &H53, &H9A, &H5B, &H4D, &H4F, &HA, &H0, &H34, &H0, &H2E, &H0, &H20, &H0, &H8F, &H79, &HDE, &H5D, &H38, &H0, &H30, &H0, &H30, &H0, &H4D, &H0, &H86, &H89, &HD6, &H76, &H50, &H67, &H99, &H65, &HEE, &H4F, &H39, &H65, &HA, &H0, &H35, &H0, &H2E, &H0, &H20, &H0, &H66, &H0, &H61, &H0, &H73, &H0, &H74, &H0, &HE5, &H65, &H38, &H5E, &H18, &H4F, &H16, &H53")
    Debug.Print y
    'Cells(5, 5).Value = y
End Sub

Public Function ByteArray(str As String) As Byte()
    Dim output() As Byte
    Dim bytes() As String
    bytes = Split(str, ",")
    ReDim output(LBound(bytes) To UBound(bytes))
    Dim l As Long
    For l = LBound(bytes) To UBound(bytes)
        output(l) = bytes(l)
    Next
    ByteArray = output
End Function

Public Function UnicodeToByteArray(str As String) As String
    If Len(str) = 0 Then Exit Function
    Dim bytes() As Byte
    bytes = str
    Dim l As Long
    For l = 0 To UBound(bytes) - 1
        UnicodeToByteArray = UnicodeToByteArray & "&H" & Hex(bytes(l)) & ","
    Next
    UnicodeToByteArray = UnicodeToByteArray & "&H" & Hex(bytes(UBound(bytes)))
End Function

'&HA,&H0 chr(10)

