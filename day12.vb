' I can't solve part two with this S*it vba lang :)
Module Day12
    Sub Main(args As String())
        If args.Length < 1 Then 
            Console.Error.WriteLine("ERROR: Invalid file Path")
            Environment.Exit(1)
        End If 
        Dim filePath As String = args(0)
        Console.WriteLine(filePath)
        Dim lines = Io.File.ReadAllLines(filePath)
        
        For i AS Integer = 0 To lines.Length - 1
            SolveLine(lines(0))
        Next

    End Sub

    Sub SolveLine(line As String) 
        Dim splitedLine = line.Split(" ")
        Dim spring = splitedLine(0)

        Dim lensString = splitedLine(1).Split(",") 
        Dim lens As List(of Integer) = New List(of Integer)()

        For i = 0 to lensString.Length - 1
            lens.add(Integer.Parse(lensString(i)))
        Next

        Console.WriteLine(FindPostions(spring, lens))
    End Sub

    Function FindPostions(row As String, lens As List(of Integer))
        If row = "" Then 
            If lens.Count = 0 
                Return 1
            Else  
                Return 0
            End If
        End If

        If lens.Count = 0
            If row.Contains("#") 
                Return 0
            Else  
                Return 1
            End If
        End If

        dim result = 0

        If ".?".Contains(row(0))
            result += FindPostions(row.Substring(1), lens)
        End If

        If "#?".Contains(row(0))
            If lens(0) <= row.Length
            If  not row.Substring(0, lens(0)).Contains(".") 
            If (lens(0) = row.Length)
            If row.Length > lens(0)
                result += FindPostions(row.Substring(lens(0) + 1), lens.slice(1, lens.Count - 1))
            else
            Return ""
            End If
            End If
            If row.Length > lens(0)
            If not row(lens(0)) = "." 
                result += FindPostions(row.Substring(lens(0) + 1), lens.slice(1, lens.Count - 1))
            End If
            End If
            End If 
            End If 
        End If 
        Return result
    End Function

End Module