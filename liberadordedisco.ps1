# liberadordedisco.ps1 - Modulo de Liberador de Disco

function Show-CleaningMenu {
    <#
    .DESCRIPTION
    Muestra el menu de limpieza y mantenimiento del sistema
    #>
    
    # Crear formulario del submenu de limpieza
    $cleaningForm = New-Object System.Windows.Forms.Form
    $cleaningForm.Text = "Limpieza y Mantenimiento"
    $cleaningForm.Size = New-Object System.Drawing.Size(700, 500)
    $cleaningForm.StartPosition = "CenterScreen"
    $cleaningForm.MaximizeBox = $false
    $cleaningForm.FormBorderStyle = "FixedDialog"
    $cleaningForm.BackColor = [System.Drawing.Color]::White

    # Titulo del submenu
    $labelTitle = New-Object System.Windows.Forms.Label
    $labelTitle.Text = "HERRAMIENTAS DE LIMPIEZA"
    $labelTitle.Font = New-Object System.Drawing.Font("Arial", 12, [System.Drawing.FontStyle]::Bold)
    $labelTitle.ForeColor = [System.Drawing.Color]::DarkBlue
    $labelTitle.Size = New-Object System.Drawing.Size(250, 25)
    $labelTitle.Location = New-Object System.Drawing.Point(225, 20)
    $cleaningForm.Controls.Add($labelTitle)

    # Boton 1: Liberador de Disco
    $btnDiskCleaner = New-Object System.Windows.Forms.Button
    $btnDiskCleaner.Text = "Liberador de Disco (Automatico)"
    $btnDiskCleaner.Font = New-Object System.Drawing.Font("Arial", 10, [System.Drawing.FontStyle]::Regular)
    $btnDiskCleaner.ForeColor = [System.Drawing.Color]::White
    $btnDiskCleaner.Size = New-Object System.Drawing.Size(250, 45)
    $btnDiskCleaner.Location = New-Object System.Drawing.Point(50, 70)
    $btnDiskCleaner.BackColor = [System.Drawing.Color]::DarkOrchid
    $cleaningForm.Controls.Add($btnDiskCleaner)

    # Boton 2: Limpiar Archivos Temporales
    $btnTempFiles = New-Object System.Windows.Forms.Button
    $btnTempFiles.Text = "Limpiar Archivos Temporales"
    $btnTempFiles.Font = New-Object System.Drawing.Font("Arial", 10, [System.Drawing.FontStyle]::Regular)
    $btnTempFiles.ForeColor = [System.Drawing.Color]::White
    $btnTempFiles.Size = New-Object System.Drawing.Size(250, 45)
    $btnTempFiles.Location = New-Object System.Drawing.Point(50, 130)
    $btnTempFiles.BackColor = [System.Drawing.Color]::SteelBlue
    $cleaningForm.Controls.Add($btnTempFiles)

    # Boton 3: Vaciar Papelera
    $btnRecycleBin = New-Object System.Windows.Forms.Button
    $btnRecycleBin.Text = "Vaciar Papelera de Reciclaje"
    $btnRecycleBin.Font = New-Object System.Drawing.Font("Arial", 10, [System.Drawing.FontStyle]::Regular)
    $btnRecycleBin.ForeColor = [System.Drawing.Color]::White
    $btnRecycleBin.Size = New-Object System.Drawing.Size(250, 45)
    $btnRecycleBin.Location = New-Object System.Drawing.Point(50, 190)
    $btnRecycleBin.BackColor = [System.Drawing.Color]::ForestGreen
    $cleaningForm.Controls.Add($btnRecycleBin)

    # Boton Volver
    $btnBack = New-Object System.Windows.Forms.Button
    $btnBack.Text = "Volver al Menu Principal"
    $btnBack.Font = New-Object System.Drawing.Font("Arial", 9, [System.Drawing.FontStyle]::Regular)
    $btnBack.ForeColor = [System.Drawing.Color]::White
    $btnBack.Size = New-Object System.Drawing.Size(150, 35)
    $btnBack.Location = New-Object System.Drawing.Point(275, 400)
    $btnBack.BackColor = [System.Drawing.Color]::DarkOrange
    $btnBack.Add_Click({$cleaningForm.Close()})
    $cleaningForm.Controls.Add($btnBack)

    # TextBox para mostrar el progreso
    $textBoxProgress = New-Object System.Windows.Forms.TextBox
    $textBoxProgress.Location = New-Object System.Drawing.Point(320, 70)
    $textBoxProgress.Size = New-Object System.Drawing.Size(350, 300)
    $textBoxProgress.Multiline = $true
    $textBoxProgress.ScrollBars = "Vertical"
    $textBoxProgress.Font = New-Object System.Drawing.Font("Consolas", 9, [System.Drawing.FontStyle]::Regular)
    $textBoxProgress.BackColor = [System.Drawing.Color]::Black
    $textBoxProgress.ForeColor = [System.Drawing.Color]::LightGreen
    $textBoxProgress.ReadOnly = $true
    $cleaningForm.Controls.Add($textBoxProgress)

    # Funcion para ejecutar Liberador de Disco automaticamente
   function Invoke-DiskCleaner {
    $textBoxProgress.Text = "Preparando Liberador de Disco...`r`n`r`n"
    $textBoxProgress.AppendText("Seleccionando todas las opciones de limpieza...`r`n")
    
    try {
        # Mostrar mensaje de confirmacion
        $confirmResult = [System.Windows.Forms.MessageBox]::Show(
            "¿Desea ejecutar el Liberador de Disco automaticamente?`r`n`r`nSe seleccionaran TODAS las opciones de limpieza disponibles.`r`nEsta accion puede tomar varios minutos.",
            "Confirmar Liberador de Disco",
            [System.Windows.Forms.MessageBoxButtons]::YesNo,
            [System.Windows.Forms.MessageBoxIcon]::Warning
        )
        
        if ($confirmResult -eq "Yes") {
            $textBoxProgress.AppendText("Usuario confirmo la ejecucion.`r`n")
            $textBoxProgress.AppendText("Iniciando Liberador de Disco...`r`n")
            
            # Calcular espacio libre ANTES de la limpieza
            $spaceBeforeGB = 0
            $totalSpaceBeforeGB = 0
            
            Get-WmiObject -Class Win32_LogicalDisk | Where-Object { $_.DriveType -eq 3 } | ForEach-Object {
                $driveLetter = $_.DeviceID
                $freeSpace = [math]::Round($_.FreeSpace / 1GB, 2)
                $totalSpace = [math]::Round($_.Size / 1GB, 2)
                $spaceBeforeGB += $freeSpace
                $totalSpaceBeforeGB += $totalSpace
                
                $textBoxProgress.AppendText("Unidad ${driveLetter}: $freeSpace GB libres de $totalSpace GB`r`n")
            }
            
            $textBoxProgress.AppendText("`r`nEspacio total libre antes: $spaceBeforeGB GB`r`n")
            
            # Opciones especificas que se seleccionaran automaticamente:
            $textBoxProgress.AppendText("`r`nOPCIONES SELECCIONADAS:`r`n")
            $textBoxProgress.AppendText(" Archivos temporales de Internet`r`n")
            $textBoxProgress.AppendText(" Archivos de programa descargados`r`n")
            $textBoxProgress.AppendText(" Archivos temporales`r`n")
            $textBoxProgress.AppendText(" Papelera de reciclaje`r`n")
            $textBoxProgress.AppendText(" Archivos temporales de Windows`r`n")
            $textBoxProgress.AppendText(" Registros de errores de Windows`r`n")
            $textBoxProgress.AppendText(" Configuraciones de DirectX Shader Cache`r`n")
            $textBoxProgress.AppendText(" Miniaturas`r`n")
            $textBoxProgress.AppendText(" Archivos de informe de errores de Windows`r`n")
            $textBoxProgress.AppendText(" Archivos de volcado del sistema`r`n")
            
            $textBoxProgress.AppendText("`r`nEjecutando limpieza...`r`n")
            
            # Ejecutar cleanmgr con todas las opciones usando sagerun
            #$textBoxProgress.AppendText("Ejecutando: cleanmgr /sagerun:1`r`n")
            
            # Primero configurar las opciones
            Start-Process "cleanmgr.exe" -ArgumentList "/sageset:1" -Wait -NoNewWindow
            
            # Luego ejecutar la limpieza
            $process = Start-Process "cleanmgr.exe" -ArgumentList "/sagerun:1" -Wait -NoNewWindow -PassThru
            
            if ($process.ExitCode -eq 0) {
                $textBoxProgress.AppendText("Limpieza completada.`r`n")
                
                # Calcular espacio libre DESPUES de la limpieza
                $spaceAfterGB = 0
                
                Get-WmiObject -Class Win32_LogicalDisk | Where-Object { $_.DriveType -eq 3 } | ForEach-Object {
                    $driveLetter = $_.DeviceID
                    $freeSpace = [math]::Round($_.FreeSpace / 1GB, 2)
                    $spaceAfterGB += $freeSpace
                    
                    $textBoxProgress.AppendText("Unidad $driveLetter ahora: $freeSpace GB libres`r`n")
                }
                
                # Calcular espacio liberado
                $spaceFreedGB = [math]::Round(($spaceAfterGB - $spaceBeforeGB), 2)
                
                $textBoxProgress.AppendText("`r`nRESULTADOS:`r`n")
                $textBoxProgress.AppendText(" Espacio libre antes: $spaceBeforeGB GB`r`n")
                $textBoxProgress.AppendText(" Espacio libre despues: $spaceAfterGB GB`r`n")
                $textBoxProgress.AppendText(" Espacio liberado: $spaceFreedGB GB`r`n")
                
                $textBoxProgress.AppendText("`r`nLIBERADOR DE DISCO EJECUTADO CORRECTAMENTE`r`n")
                $textBoxProgress.AppendText("Fecha: $(Get-Date -Format 'dd/MM/yyyy HH:mm:ss')`r`n")
                
                # Mostrar mensaje de exito con espacio liberado
                [System.Windows.Forms.MessageBox]::Show(
                    "Liberador de Disco ejecutado correctamente.`r`n`r`n" +
                    "Espacio liberado: $spaceFreedGB GB`r`n" +
                    "Se han limpiado todos los archivos innecesarios del sistema.",
                    "Limpieza Completada",
                    [System.Windows.Forms.MessageBoxButtons]::OK,
                    [System.Windows.Forms.MessageBoxIcon]::Information
                )
            } else {
                $textBoxProgress.AppendText("Error en la ejecucion del Liberador de Disco.`r`n")
                throw "cleanmgr.exe fallo con codigo de salida: $($process.ExitCode)"
            }
            
        } else {
            $textBoxProgress.AppendText("Usuario cancelo la operacion.`r`n")
            [System.Windows.Forms.MessageBox]::Show(
                "Liberador de Disco cancelado por el usuario.",
                "Operacion Cancelada",
                [System.Windows.Forms.MessageBoxButtons]::OK,
                [System.Windows.Forms.MessageBoxIcon]::Information
            )
        }
    }
    catch {
        $textBoxProgress.AppendText("`r`n ERROR: $($_.Exception.Message)`r`n")
        [System.Windows.Forms.MessageBox]::Show(
            "Error al ejecutar el Liberador de Disco: $($_.Exception.Message)",
            "Error",
            [System.Windows.Forms.MessageBoxButtons]::OK,
            [System.Windows.Forms.MessageBoxIcon]::Error
        )
    }
}

    # Funcion para limpiar archivos temporales manualmente
    function Clear-TempFiles {
        $textBoxProgress.Text = "Limpiando archivos temporales...`r`n`r`n"
        
        $tempFolders = @(
            "$env:TEMP\*",
            "C:\Windows\Temp\*",
            "$env:LOCALAPPDATA\Temp\*",
            "$env:LOCALAPPDATA\Microsoft\Windows\INetCache\*",
            "$env:LOCALAPPDATA\Microsoft\Windows\INetCookies\*"
        )
        
        $totalDeleted = 0
        
        foreach ($folder in $tempFolders) {
            try {
                $textBoxProgress.AppendText("Procesando: $folder`r`n")
                $files = Get-ChildItem -Path $folder -Recurse -ErrorAction SilentlyContinue
                $fileCount = ($files | Measure-Object).Count
                
                Remove-Item -Path $folder -Force -Recurse -ErrorAction SilentlyContinue
                $totalDeleted += $fileCount
                
                $textBoxProgress.AppendText("Eliminados: $fileCount archivos`r`n")
            }
            catch {
                $textBoxProgress.AppendText("Error en carpeta: $($_.Exception.Message)`r`n")
            }
        }
        
        $textBoxProgress.AppendText("`r`n Total archivos eliminados: $totalDeleted`r`n")
    }

    # Funcion para vaciar papelera
    function Papeleradereciclaje {
    $textBoxProgress.Text = "Vaciando Papelera de Reciclaje...`r`n`r`n"
    $startTime = Get-Date
    
    try {
        # Verificar si existe el comando Clear-RecycleBin (PS 5.1+)
        if (Get-Command Clear-RecycleBin -ErrorAction SilentlyContinue) {
            $textBoxProgress.AppendText("Eliminando archivos de la papelera de reciclaje...`r`n")
            Clear-RecycleBin -Force -ErrorAction Stop
            $textBoxProgress.AppendText("Papelera vaciada`r`n")
        } 
        else {
            $textBoxProgress.AppendText("Usando método de limpieza...`r`n")
            
            # Limpiar todas las unidades
            $drives = Get-PSDrive -PSProvider FileSystem
            $totalCleaned = 0
            
            foreach ($drive in $drives) {
                $recyclePath = Join-Path $drive.Root "\`$Recycle.Bin"
                
                if (Test-Path $recyclePath) {
                    $textBoxProgress.AppendText("Limpiando $($drive.Name):\... ")
                    
                    # Obtener conteo antes
                    $items = Get-ChildItem -Path $recyclePath -Force -ErrorAction SilentlyContinue
                    $countBefore = $items.Count
                    
                    # Eliminar todo dentro de la carpeta de reciclaje
                    Get-ChildItem -Path $recyclePath -Force -ErrorAction SilentlyContinue | ForEach-Object {
                        Remove-Item -Path $_.FullName -Recurse -Force -ErrorAction SilentlyContinue
                    }
                    
                    # Verificar después
                    $itemsAfter = Get-ChildItem -Path $recyclePath -Force -ErrorAction SilentlyContinue
                    $countAfter = $itemsAfter.Count
                    
                    $textBoxProgress.AppendText("($countBefore → $countAfter elementos)`r`n")
                    $totalCleaned += ($countBefore - $countAfter)
                }
            }
            
            $textBoxProgress.AppendText("`r`nTotal limpiado: $totalCleaned elementos`r`n")
        }
        
        $endTime = Get-Date
        $duration = New-TimeSpan -Start $startTime -End $endTime
        
        $textBoxProgress.AppendText("`r`nPapelera vaciada completamente `r`n")
        $textBoxProgress.AppendText("Duración: $($duration.TotalSeconds.ToString('0.00')) segundos`r`n")
        $textBoxProgress.AppendText("Fecha: $(Get-Date -Format 'dd/MM/yyyy HH:mm:ss')`r`n")
    }
    catch {
        $textBoxProgress.AppendText(" Error: $($_.Exception.Message)`r`n")
    }
}

    # Eventos para los botones
    $btnDiskCleaner.Add_Click({
        $btnDiskCleaner.Enabled = $false
        $btnDiskCleaner.Text = "Ejecutando..."
        Invoke-DiskCleaner
        $btnDiskCleaner.Enabled = $true
        $btnDiskCleaner.Text = "Liberador de Disco (Automatico)"
    })

    $btnTempFiles.Add_Click({
        $btnTempFiles.Enabled = $false
        $btnTempFiles.Text = "Limpiando..."
        Clear-TempFiles
        $btnTempFiles.Enabled = $true
        $btnTempFiles.Text = "Limpiar Archivos Temporales"
    })

    $btnRecycleBin.Add_Click({
        $btnRecycleBin.Enabled = $false
        $btnRecycleBin.Text = "Vaciando..."
        Papeleradereciclaje
        $btnRecycleBin.Enabled = $true
        $btnRecycleBin.Text = "Vaciar Papelera de Reciclaje"
    })

    # Efectos hover para los botones
    $subMenuButtons = @($btnDiskCleaner, $btnTempFiles, $btnRecycleBin, $btnBack)
    
    foreach ($button in $subMenuButtons) {
        $button.Add_MouseEnter({
            $this.BackColor = [System.Drawing.Color]::LightBlue
        })
        $button.Add_MouseLeave({
            switch ($this.Text) {
                "Liberador de Disco (Automatico)" { $this.BackColor = [System.Drawing.Color]::DarkOrchid }
                "Limpiar Archivos Temporales" { $this.BackColor = [System.Drawing.Color]::SteelBlue }
                "Vaciar Papelera de Reciclaje" { $this.BackColor = [System.Drawing.Color]::ForestGreen }
                default { $this.BackColor = [System.Drawing.Color]::DarkOrange }
            }
        })
    }

    # Mostrar el submenu
    $cleaningForm.ShowDialog()
}

#Write-Host "Modulo liberadordedisco.ps1 cargado - Funcion Show-CleaningMenu disponible" -ForegroundColor Cyan