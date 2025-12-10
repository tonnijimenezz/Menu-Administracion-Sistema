function Export-SystemInfoToExcel {
    try {
        # Crear objeto Excel
        $excel = New-Object -ComObject Excel.Application
        $excel.Visible = $false
        $excel.DisplayAlerts = $false
        
        # Crear workbook
        $workbook = $excel.Workbooks.Add()
        $worksheet = $workbook.Worksheets.Item(1)
        $worksheet.Name = "Informacion del Sistema"
        
        # Titulo
        $worksheet.Cells.Item(1, 1) = "INFORMACION DEL SISTEMA"
        $worksheet.Cells.Item(1, 1).Font.Size = 16
        $worksheet.Cells.Item(1, 1).Font.Bold = $true
        $worksheet.Range("A1:C1").Merge() | Out-Null
        
        # Fecha
        $worksheet.Cells.Item(2, 1) = "Reporte generado el: $(Get-Date -Format 'dd/MM/yyyy HH:mm:ss')"
        $worksheet.Range("A2:C2").Merge() | Out-Null
        
        # Encabezados
        $worksheet.Cells.Item(4, 1) = "Categoria"
        $worksheet.Cells.Item(4, 2) = "Propiedad"
        $worksheet.Cells.Item(4, 3) = "Valor"
        
        # Obtener datos del sistema
        $systemData = Get-DetailedSystemInfo
        
        # Llenar datos
        $row = 5
        foreach ($item in $systemData) {
            $worksheet.Cells.Item($row, 1) = $item.Categoria
            $worksheet.Cells.Item($row, 2) = $item.Propiedad
            $worksheet.Cells.Item($row, 3) = $item.Valor
            $row++
        }
        
        # Autoajustar columnas
        $worksheet.Columns.AutoFit() | Out-Null
        
        # Guardar archivo
        $desktopPath = [Environment]::GetFolderPath("Desktop")
        $fileName = "Informacion_Sistema_$(Get-Date -Format 'yyyyMMdd_HHmmss').xlsx"
        $filePath = Join-Path $desktopPath $fileName
        
        $workbook.SaveAs($filePath)
        $workbook.Close()
        $excel.Quit()
        
        # Liberar objetos COM
        [System.Runtime.Interopservices.Marshal]::ReleaseComObject($worksheet) | Out-Null
        [System.Runtime.Interopservices.Marshal]::ReleaseComObject($workbook) | Out-Null
        [System.Runtime.Interopservices.Marshal]::ReleaseComObject($excel) | Out-Null
        
        return $true, $filePath
    }
    catch {
        # Limpiar en caso de error
        try {
            if ($workbook) { $workbook.Close() }
            if ($excel) { $excel.Quit() }
        }
        catch {}
        
        return $false, $_.Exception.Message
    }
}

function Get-DetailedSystemInfo {
    $systemData = @()
    
    # Sistema Operativo
    $os = Get-CimInstance -ClassName Win32_OperatingSystem
    $systemData += [PSCustomObject]@{
        Categoria = "Sistema Operativo"
        Propiedad = "Nombre"
        Valor = $os.Caption
    }
    $systemData += [PSCustomObject]@{
        Categoria = "Sistema Operativo"
        Propiedad = "Version"
        Valor = $os.Version
    }
    $systemData += [PSCustomObject]@{
        Categoria = "Sistema Operativo"
        Propiedad = "Arquitectura"
        Valor = $os.OSArchitecture
    }
    
    # Procesador
    $cpu = Get-CimInstance -ClassName Win32_Processor | Select-Object -First 1
    $systemData += [PSCustomObject]@{
        Categoria = "Procesador"
        Propiedad = "Modelo"
        Valor = $cpu.Name
    }
    
    # Memoria
    $memory = Get-CimInstance -ClassName Win32_ComputerSystem
    $systemData += [PSCustomObject]@{
        Categoria = "Memoria"
        Propiedad = "RAM Total (GB)"
        Valor = [math]::Round($memory.TotalPhysicalMemory/1GB, 2)
    }
    
    # Discos
    $disks = Get-CimInstance -ClassName Win32_LogicalDisk | Where-Object { $_.Size -gt 0 }
    foreach ($disk in $disks) {
        $systemData += [PSCustomObject]@{
            Categoria = "Almacenamiento"
            Propiedad = "Disco $($disk.DeviceID)"
            Valor = "$([math]::Round($disk.Size/1GB, 2)) GB total, $([math]::Round($disk.FreeSpace/1GB, 2)) GB libre"
        }
    }
    
    return $systemData
}


function Get-SpecificSystemInfo {
    <#
    .DESCRIPTION
    Obtiene informacion especifica y detallada del sistema
    #>
    
    $specificInfo = @()
    
    # Informacion detallada del hardware
    $specificInfo += "=== INFORMACION ESPECIFICA DEL HARDWARE ==="
    $specificInfo += ""
    
    # Procesador detallado
    $cpu = Get-CimInstance -ClassName Win32_Processor | Select-Object -First 1
    $specificInfo += "PROCESADOR:"
    $specificInfo += "  Modelo: $($cpu.Name)"
    $specificInfo += "  Fabricante: $($cpu.Manufacturer)"
    $specificInfo += "  Nucleos: $($cpu.NumberOfCores)"
    $specificInfo += "  Procesadores logicos: $($cpu.NumberOfLogicalProcessors)"
    $specificInfo += "  Velocidad: $([math]::Round($cpu.MaxClockSpeed/1000, 2)) GHz"
    $specificInfo += "  Arquitectura: $($cpu.AddressWidth) bits"
    $specificInfo += ""
    
    # Memoria detallada
    $memory = Get-CimInstance -ClassName Win32_ComputerSystem
    $physicalMemory = Get-CimInstance -ClassName Win32_PhysicalMemory | Measure-Object -Property Capacity -Sum
    $specificInfo += "MEMORIA RAM:"
    $specificInfo += "  Total: $([math]::Round($memory.TotalPhysicalMemory/1GB, 2)) GB"
    $specificInfo += "  Modulos instalados: $([math]::Round($physicalMemory.Sum/1GB, 2)) GB"
    $specificInfo += ""
    
    # Discos detallados
    $disks = Get-CimInstance -ClassName Win32_LogicalDisk | Where-Object { $_.Size -gt 0 }
    $specificInfo += "ALMACENAMIENTO:"
    foreach ($disk in $disks) {
        $usedSpace = $disk.Size - $disk.FreeSpace
        $percentUsed = [math]::Round(($usedSpace / $disk.Size) * 100, 2)
        $specificInfo += "  Disco $($disk.DeviceID):"
        $specificInfo += "    Sistema archivos: $($disk.FileSystem)"
        $specificInfo += "    Total: $([math]::Round($disk.Size/1GB, 2)) GB"
        $specificInfo += "    Libre: $([math]::Round($disk.FreeSpace/1GB, 2)) GB"
        $specificInfo += "    Usado: $([math]::Round($usedSpace/1GB, 2)) GB ($percentUsed%)"
    }
    $specificInfo += ""
    
    # Red detallada
    $networkAdapters = Get-CimInstance -ClassName Win32_NetworkAdapterConfiguration | Where-Object { $_.IPEnabled -eq $true }
    $specificInfo += "CONEXIONES DE RED:"
    foreach ($adapter in $networkAdapters) {
        $specificInfo += "  Adaptador: $($adapter.Description)"
        $specificInfo += "    MAC: $($adapter.MACAddress)"
        $specificInfo += "    IP: $($adapter.IPAddress -join ', ')"
        $specificInfo += "    DNS: $($adapter.DNSServerSearchOrder -join ', ')"
    }
    $specificInfo += ""
    
    # BIOS y Placa base
    $bios = Get-CimInstance -ClassName Win32_BIOS
    $motherboard = Get-CimInstance -ClassName Win32_BaseBoard
    $specificInfo += "BIOS Y PLACA BASE:"
    $specificInfo += "  BIOS: $($bios.Manufacturer) - $($bios.SMBIOSBIOSVersion)"
    $specificInfo += "  Placa base: $($motherboard.Manufacturer) - $($motherboard.Product)"
    $specificInfo += "  Serial BIOS: $($bios.SerialNumber)"
    $specificInfo += ""
    
    # Graficos
    $graphics = Get-CimInstance -ClassName Win32_VideoController | Where-Object { $_.Name -notlike "*Remote*" }
    $specificInfo += "TARJETAS GRAFICAS:"
    foreach ($gpu in $graphics) {
        $specificInfo += "  $($gpu.Name)"
        $specificInfo += "    RAM: $([math]::Round($gpu.AdapterRAM/1GB, 2)) GB"
        $specificInfo += "    Resolucion: $($gpu.CurrentHorizontalResolution) x $($gpu.CurrentVerticalResolution)"
        $specificInfo += "    Driver: $($gpu.DriverVersion)"
    }
    
    return $specificInfo -join "`r`n"
}



# Función para obtener información del sistema
function Get-BasicInformacionSistema {
    $InformacionSistema = @()
    
    $InformacionSistema += "=== INFORMACION DEL DISPOSITIVO ==="
	$InformacionSistema += ""
    $InformacionSistema += "Nombre del dispositivo: $env:COMPUTERNAME"
    
    $cpu = Get-CimInstance -ClassName Win32_Processor | Select-Object -First 1
    $InformacionSistema += "Procesador: $($cpu.Name)"
    
    $memory = Get-CimInstance -ClassName Win32_ComputerSystem
    $InformacionSistema += "RAM instalada: $([math]::Round($memory.TotalPhysicalMemory/1GB, 0)) GB"
    
    $os = Get-CimInstance -ClassName Win32_OperatingSystem
    $InformacionSistema += "Tipo de sistema: Sistema operativo $($os.OSArchitecture)"
    $InformacionSistema += ""

    $InformacionSistema += "=== ESPECIFICACIONES DE WINDOWS ==="
	$InformacionSistema += ""
    $InformacionSistema += "Edicion: $($os.Caption)"
    $InformacionSistema += "Version: $($os.Version)"
    $InformacionSistema += "Compilacion del SO: $($os.BuildNumber)"
    $InformacionSistema += ""

    $InformacionSistema += "=== INFORMACION ADICIONAL ==="
	$InformacionSistema += ""
    $InformacionSistema += "Nombre completo del equipo: $env:COMPUTERNAME"
    $InformacionSistema += "Grupo de trabajo: $($memory.Domain)"
    $InformacionSistema += ""

    return $InformacionSistema -join "`r`n"
}

function Show-InformacionSistemaMenu {
   # Write-Host "Ejecutando Show-InformacionSistemaMenu desde módulo externo" -ForegroundColor Green
    
    # Crear formulario del submenú
    $InformacionSistemaForm = New-Object System.Windows.Forms.Form
    $InformacionSistemaForm.Text = "Informacion del Sistema"
    $InformacionSistemaForm.Size = New-Object System.Drawing.Size(700, 500)
    $InformacionSistemaForm.StartPosition = "CenterScreen"
    $InformacionSistemaForm.MaximizeBox = $false
    $InformacionSistemaForm.FormBorderStyle = "FixedDialog"
    $InformacionSistemaForm.BackColor = [System.Drawing.Color]::White

    # Título del submenú
    $labelSubTitle = New-Object System.Windows.Forms.Label
    $labelSubTitle.Text = "INFORMACION DEL SISTEMA"
    $labelSubTitle.Font = New-Object System.Drawing.Font("Arial", 12, [System.Drawing.FontStyle]::Bold)
    $labelSubTitle.ForeColor = [System.Drawing.Color]::DarkBlue
    $labelSubTitle.Size = New-Object System.Drawing.Size(250, 25)
    $labelSubTitle.Location = New-Object System.Drawing.Point(225, 20)
    $InformacionSistemaForm.Controls.Add($labelSubTitle)

   # Botón 1: Mostrar Información General
    $btnShowInfo = New-Object System.Windows.Forms.Button
    $btnShowInfo.Text = "Mostrar Informacion General del Sistema"
    $btnShowInfo.Font = New-Object System.Drawing.Font("Arial", 10, [System.Drawing.FontStyle]::Regular)
    $btnShowInfo.ForeColor = [System.Drawing.Color]::White
    $btnShowInfo.Size = New-Object System.Drawing.Size(250, 40)
    $btnShowInfo.Location = New-Object System.Drawing.Point(50, 70)
    $btnShowInfo.BackColor = [System.Drawing.Color]::SteelBlue
    $InformacionSistemaForm.Controls.Add($btnShowInfo)  # ← CORREGIDO: $InformacionSistemaForm

    # Boton 2 Mostrar Información Específica
    $btnShowSpecific = New-Object System.Windows.Forms.Button
    $btnShowSpecific.Text = "Mostrar Informacion Especifica del Sistema"
    $btnShowSpecific.Font = New-Object System.Drawing.Font("Arial", 10, [System.Drawing.FontStyle]::Regular)
    $btnShowSpecific.ForeColor = [System.Drawing.Color]::White
    $btnShowSpecific.Size = New-Object System.Drawing.Size(250, 40)
    $btnShowSpecific.Location = New-Object System.Drawing.Point(50, 120)
    $btnShowSpecific.BackColor = [System.Drawing.Color]::DarkCyan
    $InformacionSistemaForm.Controls.Add($btnShowSpecific)  # ← CORREGIDO: $InformacionSistemaForm

    # Botón 3: Generar Reporte Excel
    $btnExportExcel = New-Object System.Windows.Forms.Button
    $btnExportExcel.Text = "Generar Reporte en Excel"
    $btnExportExcel.Font = New-Object System.Drawing.Font("Arial", 10, [System.Drawing.FontStyle]::Regular)
    $btnExportExcel.ForeColor = [System.Drawing.Color]::White
    $btnExportExcel.Size = New-Object System.Drawing.Size(250, 45)
    $btnExportExcel.Location = New-Object System.Drawing.Point(50, 170)
    $btnExportExcel.BackColor = [System.Drawing.Color]::ForestGreen
    $InformacionSistemaForm.Controls.Add($btnExportExcel)

    # Botón Volver
    $btnBack = New-Object System.Windows.Forms.Button
    $btnBack.Text = "Volver al Menu Principal"
    $btnBack.Font = New-Object System.Drawing.Font("Arial", 9, [System.Drawing.FontStyle]::Regular)
    $btnBack.ForeColor = [System.Drawing.Color]::White
    $btnBack.Size = New-Object System.Drawing.Size(150, 35)
    $btnBack.Location = New-Object System.Drawing.Point(275, 400)
    $btnBack.BackColor = [System.Drawing.Color]::DarkOrange
    $btnBack.Add_Click({$InformacionSistemaForm.Close()})
    $InformacionSistemaForm.Controls.Add($btnBack)

    # TextBox para mostrar la información del sistema
    $textBoxInfo = New-Object System.Windows.Forms.TextBox
    $textBoxInfo.Location = New-Object System.Drawing.Point(320, 70)
    $textBoxInfo.Size = New-Object System.Drawing.Size(350, 300)
    $textBoxInfo.Multiline = $true
    $textBoxInfo.ScrollBars = "Vertical"
    $textBoxInfo.Font = New-Object System.Drawing.Font("Arial", 9, [System.Drawing.FontStyle]::Regular)
    $textBoxInfo.BackColor = [System.Drawing.Color]::White
    $textBoxInfo.ForeColor = [System.Drawing.Color]::Black
    $textBoxInfo.ReadOnly = $true
    $InformacionSistemaForm.Controls.Add($textBoxInfo)

    # Evento para el botón Mostrar Información
    $btnShowInfo.Add_Click({
        $textBoxInfo.Text = "Recopilando informacion del sistema...`r`nPor favor espere..."
        $textBoxInfo.Refresh()
        
        # Obtener la información
        $result = Get-BasicInformacionSistema
        $textBoxInfo.Text = $result
    })
	
	# Evento para el NUEVO botón Mostrar Información Específica
    $btnShowSpecific.Add_Click({
        $btnShowSpecific.Enabled = $false
        $btnShowSpecific.Text = "Obteniendo info especifica..."
        
        $textBoxInfo.Text = "Recopilando informacion ESPECIFICA del sistema...`r`nEsto puede tomar unos segundos..."
        $textBoxInfo.Refresh()
        
        # Obtener la información específica
        $result = Get-SpecificSystemInfo
        $textBoxInfo.Text = $result
        
        $btnShowSpecific.Enabled = $true
        $btnShowSpecific.Text = "Mostrar Informacion Especifica del Sistema"
    })

      # Evento para el boton Generar Reporte Excel
    $btnExportExcel.Add_Click({
        $btnExportExcel.Enabled = $false
        $btnExportExcel.Text = "Generando Excel..."
        
        $textBoxInfo.Text = "Generando reporte de Excel... Por favor espere."
        $textBoxInfo.Refresh()
        
        # Generar Excel
        $result = Export-SystemInfoToExcel
        
        if ($result[0] -eq $true) {
            $textBoxInfo.Text = "¡Excel generado!`r`nArchivo: $($result[1])"
            
            # Preguntar si abrir
            $openResult = [System.Windows.Forms.MessageBox]::Show(
				"¿Abrir el archivo Excel?",
                "Excel Generado",
                [System.Windows.Forms.MessageBoxButtons]::YesNo
            )
            
            if ($openResult -eq "Yes") {
                Start-Process $result[1]
            }
        } else {
            $textBoxInfo.Text = "Error: $($result[1])"
        }
        
        $btnExportExcel.Enabled = $true
        $btnExportExcel.Text = "Generar Reporte en Excel"
    })

    # Efectos hover para los botones - ACTUALIZADO para incluir el nuevo botón
    $subMenuButtons = @($btnShowInfo, $btnShowSpecific, $btnExportExcel, $btnBack)
    
    foreach ($button in $subMenuButtons) {
        $button.Add_MouseEnter({
            $this.BackColor = [System.Drawing.Color]::LightBlue
        })
        $button.Add_MouseLeave({
            switch ($this.Text) {
                "Mostrar Informacion General del Sistema" { $this.BackColor = [System.Drawing.Color]::SteelBlue }
                "Mostrar Informacion Especifica del Sistema" { $this.BackColor = [System.Drawing.Color]::DarkCyan }
                "Generar Reporte en Excel" { $this.BackColor = [System.Drawing.Color]::ForestGreen }
                default { $this.BackColor = [System.Drawing.Color]::DarkOrange }
            }
        })
    }

    # Mostrar el submenú
    $InformacionSistemaForm.ShowDialog()
}