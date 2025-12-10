# ReparacionDiscoSistema.ps1
# Modulo de reparacion de disco y sistema

function Show-ReparacionMenu {
    # Crear formulario principal
    $formReparacion = New-Object System.Windows.Forms.Form
    $formReparacion.Text = "Reparacion de Disco y Sistema"
    $formReparacion.Size = New-Object System.Drawing.Size(650, 700)
    $formReparacion.StartPosition = "CenterScreen"
    $formReparacion.BackColor = [System.Drawing.Color]::White
    $formReparacion.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedDialog
    $formReparacion.MaximizeBox = $false
    $formReparacion.MinimizeBox = $false

    # Panel principal
    $panelMain = New-Object System.Windows.Forms.Panel
    $panelMain.Location = New-Object System.Drawing.Point(10, 10)
    $panelMain.Size = New-Object System.Drawing.Size(610, 640)
    $panelMain.BackColor = [System.Drawing.Color]::White
    $formReparacion.Controls.Add($panelMain)

    # Titulo
    $labelTitulo = New-Object System.Windows.Forms.Label
    $labelTitulo.Text = "REPARACION DE DISCO Y SISTEMA"
    $labelTitulo.Font = New-Object System.Drawing.Font("Arial", 14, [System.Drawing.FontStyle]::Bold)
    $labelTitulo.ForeColor = [System.Drawing.Color]::DarkBlue
    $labelTitulo.Size = New-Object System.Drawing.Size(600, 30)
    $labelTitulo.Location = New-Object System.Drawing.Point(10, 10)
    $labelTitulo.TextAlign = [System.Drawing.ContentAlignment]::MiddleCenter
    $panelMain.Controls.Add($labelTitulo)

    # Descripcion
    $labelDesc = New-Object System.Windows.Forms.Label
    $labelDesc.Text = "Seleccione una operacion de reparacion:"
    $labelDesc.Font = New-Object System.Drawing.Font("Arial", 10, [System.Drawing.FontStyle]::Regular)
    $labelDesc.ForeColor = [System.Drawing.Color]::Black
    $labelDesc.Size = New-Object System.Drawing.Size(400, 25)
    $labelDesc.Location = New-Object System.Drawing.Point(20, 50)
    $panelMain.Controls.Add($labelDesc)

    # Area de texto para resultados
    $textBoxResultados = New-Object System.Windows.Forms.TextBox
    $textBoxResultados.Multiline = $true
    $textBoxResultados.ScrollBars = "Vertical"
    $textBoxResultados.Font = New-Object System.Drawing.Font("Consolas", 9, [System.Drawing.FontStyle]::Regular)
    $textBoxResultados.Size = New-Object System.Drawing.Size(570, 350)
    $textBoxResultados.Location = New-Object System.Drawing.Point(20, 280)
    $textBoxResultados.BackColor = [System.Drawing.Color]::Black
    $textBoxResultados.ForeColor = [System.Drawing.Color]::Lime
    $textBoxResultados.ReadOnly = $true
    $panelMain.Controls.Add($textBoxResultados)

    # Barra de progreso
    $progressBar = New-Object System.Windows.Forms.ProgressBar
    $progressBar.Size = New-Object System.Drawing.Size(570, 20)
    $progressBar.Location = New-Object System.Drawing.Point(20, 640)
    $progressBar.Style = [System.Windows.Forms.ProgressBarStyle]::Continuous
    $progressBar.Visible = $false
    $panelMain.Controls.Add($progressBar)

    # Etiqueta de estado
    $labelEstado = New-Object System.Windows.Forms.Label
    $labelEstado.Text = "Listo"
    $labelEstado.Font = New-Object System.Drawing.Font("Arial", 9, [System.Drawing.FontStyle]::Regular)
    $labelEstado.ForeColor = [System.Drawing.Color]::DarkGreen
    $labelEstado.Size = New-Object System.Drawing.Size(570, 20)
    $labelEstado.Location = New-Object System.Drawing.Point(20, 665)
    $labelEstado.TextAlign = [System.Drawing.ContentAlignment]::MiddleLeft
    $panelMain.Controls.Add($labelEstado)

    # ============ BOTONES DE REPARACION ============

    # Boton 1: Escanear errores de disco (solo lectura)
    $btnEscanearDisco = New-Object System.Windows.Forms.Button
    $btnEscanearDisco.Text = "1. ESCANEAR ERRORES DE DISCO (Solo lectura)"
    $btnEscanearDisco.Font = New-Object System.Drawing.Font("Arial", 10, [System.Drawing.FontStyle]::Regular)
    $btnEscanearDisco.ForeColor = [System.Drawing.Color]::DarkBlue
    $btnEscanearDisco.Size = New-Object System.Drawing.Size(570, 40)
    $btnEscanearDisco.Location = New-Object System.Drawing.Point(20, 90)
    $btnEscanearDisco.BackColor = [System.Drawing.Color]::LightGray
    $btnEscanearDisco.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
    $panelMain.Controls.Add($btnEscanearDisco)

    # Boton 2: Reparar errores de disco (requiere reinicio)
    $btnRepararDisco = New-Object System.Windows.Forms.Button
    $btnRepararDisco.Text = "2. REPARAR ERRORES DE DISCO (Requiere reinicio)"
    $btnRepararDisco.Font = New-Object System.Drawing.Font("Arial", 10, [System.Drawing.FontStyle]::Regular)
    $btnRepararDisco.ForeColor = [System.Drawing.Color]::DarkRed
    $btnRepararDisco.Size = New-Object System.Drawing.Size(570, 40)
    $btnRepararDisco.Location = New-Object System.Drawing.Point(20, 140)
    $btnRepararDisco.BackColor = [System.Drawing.Color]::LightGray
    $btnRepararDisco.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
    $panelMain.Controls.Add($btnRepararDisco)

    # Boton 3: Reparar archivos del sistema (SFC)
    $btnRepararSFC = New-Object System.Windows.Forms.Button
    $btnRepararSFC.Text = "3. REPARAR ARCHIVOS DEL SISTEMA (SFC /scannow)"
    $btnRepararSFC.Font = New-Object System.Drawing.Font("Arial", 10, [System.Drawing.FontStyle]::Regular)
    $btnRepararSFC.ForeColor = [System.Drawing.Color]::DarkGreen
    $btnRepararSFC.Size = New-Object System.Drawing.Size(570, 40)
    $btnRepararSFC.Location = New-Object System.Drawing.Point(20, 190)
    $btnRepararSFC.BackColor = [System.Drawing.Color]::LightGray
    $btnRepararSFC.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
    $panelMain.Controls.Add($btnRepararSFC)

    # Boton 4: Reparar imagen de Windows (DISM)
    $btnRepararDISM = New-Object System.Windows.Forms.Button
    $btnRepararDISM.Text = "4. REPARAR IMAGEN DE WINDOWS (DISM)"
    $btnRepararDISM.Font = New-Object System.Drawing.Font("Arial", 10, [System.Drawing.FontStyle]::Regular)
    $btnRepararDISM.ForeColor = [System.Drawing.Color]::Purple
    $btnRepararDISM.Size = New-Object System.Drawing.Size(570, 40)
    $btnRepararDISM.Location = New-Object System.Drawing.Point(20, 240)
    $btnRepararDISM.BackColor = [System.Drawing.Color]::LightGray
    $btnRepararDISM.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
    $panelMain.Controls.Add($btnRepararDISM)

    # Boton Cerrar
    $btnCerrar = New-Object System.Windows.Forms.Button
    $btnCerrar.Text = "Cerrar"
    $btnCerrar.Font = New-Object System.Drawing.Font("Arial", 10, [System.Drawing.FontStyle]::Regular)
    $btnCerrar.ForeColor = [System.Drawing.Color]::White
    $btnCerrar.Size = New-Object System.Drawing.Size(150, 35)
    $btnCerrar.Location = New-Object System.Drawing.Point(440, 690)
    $btnCerrar.BackColor = [System.Drawing.Color]::DarkRed
    $btnCerrar.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
    $formReparacion.Controls.Add($btnCerrar)
	


    # ============ FUNCIONES DE REPARACION ============

    # Funcion para mostrar progreso
    function Update-Progress {
        param([string]$mensaje, [int]$porcentaje = -1)
        
        if ($porcentaje -ge 0) {
            $progressBar.Value = $porcentaje
            $progressBar.Visible = $true
        }
        
        $labelEstado.Text = $mensaje
        $textBoxResultados.AppendText("$(Get-Date -Format 'HH:mm:ss') - $mensaje`r`n")
        $textBoxResultados.ScrollToCaret()
        $formReparacion.Refresh()
    }

    # Funcion 1: Escanear errores de disco
    function Start-DiskScan {
        Update-Progress "Iniciando escaneo de disco (solo lectura)..."
        
        try {
            Update-Progress "Ejecutando: chkdsk C: /scan"
            $textBoxResultados.AppendText("`r`n" + ("="*70) + "`r`n")
            $textBoxResultados.AppendText("RESULTADOS DE CHKDSK /SCAN`r`n")
            $textBoxResultados.AppendText(("="*70) + "`r`n`r`n")
            
            # Ejecutar chkdsk en modo solo lectura
            $output = cmd /c "chkdsk C: /scan" 2>&1
            
            foreach ($line in $output) {
                $textBoxResultados.AppendText("$line`r`n")
            }
            
            Update-Progress "Escaneo completado. Revise resultados arriba."
            $progressBar.Visible = $false
            
            # Mostrar resumen
            $textBoxResultados.AppendText("`r`n" + ("="*70) + "`r`n")
            $textBoxResultados.AppendText("RECOMENDACIONES:`r`n")
            $textBoxResultados.AppendText("- Si hay errores, use 'Reparar errores de disco'`r`n")
            $textBoxResultados.AppendText("- Si no hay errores, el disco esta sano`r`n")
            $textBoxResultados.AppendText(("="*70) + "`r`n")
            
        } catch {
            Update-Progress "Error en escaneo: $($_.Exception.Message)"
        }
    }

    # Funcion 2: Reparar errores de disco
    function Start-DiskRepair {
        # Mostrar advertencia sobre reinicio
        $confirm = [System.Windows.Forms.MessageBox]::Show(
    "¿REPARAR ERRORES DE DISCO?`r`n`r`n" +
    "ADVERTENCIA:`r`n" +
    "• Requiere REINICIAR el equipo ahora`r`n" +
    "• CHKDSK se ejecutara durante el inicio`r`n" +
    "• El proximo arranque sera mas lento`r`n" +
    "• Duracion depende del tamaño del disco`r`n" +
    "• GUARDE todo su trabajo antes de continuar`r`n`r`n" +
    "¿Desea programar la reparacion?",
    "Confirmar Reparacion de Disco",
    [System.Windows.Forms.MessageBoxButtons]::YesNo,
    [System.Windows.Forms.MessageBoxIcon]::Warning
)
        
        if ($confirm -eq "Yes") {
            Update-Progress "Programando reparacion de disco para el proximo reinicio..."
            
            try {
                # Programar chkdsk para ejecutarse en el proximo reinicio
                $output = cmd /c "chkdsk C: /f" 2>&1
                
                $textBoxResultados.AppendText("`r`n" + ("="*70) + "`r`n")
                $textBoxResultados.AppendText("CHKDSK PROGRAMADO`r`n")
                $textBoxResultados.AppendText(("="*70) + "`r`n`r`n")
                
                foreach ($line in $output) {
                    $textBoxResultados.AppendText("$line`r`n")
                }
                
                # Preguntar si reiniciar ahora
                $reiniciar = [System.Windows.Forms.MessageBox]::Show(
                    "La reparacion esta programada para el proximo reinicio.`r`n`r`n" +
                    "¿Desea reiniciar el equipo ahora para ejecutar la reparacion?",
                    "Reiniciar Equipo",
                    [System.Windows.Forms.MessageBoxButtons]::YesNo,
                    [System.Windows.Forms.MessageBoxIcon]::Question
                )
                
                if ($reiniciar -eq "Yes") {
                    Update-Progress "Reiniciando equipo en 10 segundos..."
                    Start-Sleep -Seconds 2
                    Restart-Computer -Force
                } else {
                    Update-Progress "Reparacion programada. Se ejecutara en el proximo reinicio."
                }
                
            } catch {
                Update-Progress "Error: $($_.Exception.Message)"
            }
        } else {
            Update-Progress "Reparacion cancelada por el usuario."
        }
        
        $progressBar.Visible = $false
    }

    # Funcion 3: Reparar archivos del sistema (SFC)
    function Start-SFCRepair {
        # Mostrar informacion
        $confirm = [System.Windows.Forms.MessageBox]::Show(
    "¿EJECUTAR SFC /SCANNOW?`r`n`r`n" +
    "Esta operacion:`r`n" +
    "1. Verificara archivos protegidos del sistema`r`n" +
    "2. Reparara archivos corruptos si es necesario`r`n" +
    "3. Tiempo aproximado: 2-8 minutos`r`n" +
    "4. Requiere ejecucion como administrador`r`n`r`n" +
    "¿Desea continuar?",
    "SFC /scannow",
    [System.Windows.Forms.MessageBoxButtons]::YesNo,
    [System.Windows.Forms.MessageBoxIcon]::Information
)
        
        if ($confirm -eq "Yes") {
            Update-Progress "Iniciando SFC /scannow..."
            $progressBar.Style = [System.Windows.Forms.ProgressBarStyle]::Marquee
            $progressBar.Visible = $true
            
            try {
                $textBoxResultados.AppendText("`r`n" + ("="*70) + "`r`n")
                $textBoxResultados.AppendText("SFC /SCANNOW - EN EJECUCION`r`n")
                $textBoxResultados.AppendText(("="*70) + "`r`n`r`n")
                
                # Ejecutar SFC y capturar salida
                $process = Start-Process -FilePath "sfc.exe" -ArgumentList "/scannow" `
                                         -NoNewWindow -Wait -PassThru -RedirectStandardOutput "sfc_output.txt"
                
                # Leer resultados
                if (Test-Path "sfc_output.txt") {
                    $sfcResult = Get-Content "sfc_output.txt" -Raw
                    $textBoxResultados.AppendText($sfcResult)
                    Remove-Item "sfc_output.txt" -Force
                }
                
                # Interpretar codigo de salida
                if ($process.ExitCode -eq 0) {
                    Update-Progress "SFC completado: No se encontraron violaciones de integridad"
                    [System.Windows.Forms.MessageBox]::Show(
                        "SFC completado exitosamente.`r`nNo se encontraron archivos del sistema corruptos.",
                        "SFC Completado",
                        [System.Windows.Forms.MessageBoxButtons]::OK,
                        [System.Windows.Forms.MessageBoxIcon]::Information
                    )
                } elseif ($process.ExitCode -eq 3010) {
                    Update-Progress "SFC completado: Reparaciones realizadas, reinicio recomendado"
                    [System.Windows.Forms.MessageBox]::Show(
                        "SFC encontro y reparo archivos corruptos.`r`nSe recomienda reiniciar el equipo.",
                        "Reparaciones Realizadas",
                        [System.Windows.Forms.MessageBoxButtons]::OK,
                        [System.Windows.Forms.MessageBoxIcon]::Information
                    )
                } else {
                    Update-Progress "SFC completado con codigo de salida: $($process.ExitCode)"
                    [System.Windows.Forms.MessageBox]::Show(
                        "SFC completado con codigo $($process.ExitCode).`r`nConsulte los detalles en el area de resultados.",
                        "SFC Completado",
                        [System.Windows.Forms.MessageBoxButtons]::OK,
                        [System.Windows.Forms.MessageBoxIcon]::Information
                    )
                }
                
            } catch {
                Update-Progress "Error en SFC: $($_.Exception.Message)"
                [System.Windows.Forms.MessageBox]::Show(
                    "Error ejecutando SFC: $($_.Exception.Message)",
                    "Error",
                    [System.Windows.Forms.MessageBoxButtons]::OK,
                    [System.Windows.Forms.MessageBoxIcon]::Error
                )
            }
            
            $progressBar.Visible = $false
            $progressBar.Style = [System.Windows.Forms.ProgressBarStyle]::Continuous
        } else {
            Update-Progress "SFC cancelado por el usuario."
        }
    }

    # Funcion 4: Reparar imagen de Windows (DISM)
    function Start-DISMRepair {
        # Mostrar informacion
        $confirm = [System.Windows.Forms.MessageBox]::Show(
    "¿EJECUTAR DISM?`r`n`r`n" +
    "Esta operacion:`r`n" +
    "1. Reparara la imagen de Windows desde Internet`r`n" +
    "2. Complementa la reparacion de SFC`r`n" +
    "3. Necesita conexion a Internet activa`r`n" +
    "4. Tiempo aproximado: 5-15 minutos`r`n`r`n" +
    "¿Desea continuar?",
    "DISM /Cleanup-Image /RestoreHealth",
    [System.Windows.Forms.MessageBoxButtons]::YesNo,
    [System.Windows.Forms.MessageBoxIcon]::Information
)
        
        if ($confirm -eq "Yes") {
            Update-Progress "Iniciando DISM /Cleanup-Image /RestoreHealth..."
            $progressBar.Style = [System.Windows.Forms.ProgressBarStyle]::Marquee
            $progressBar.Visible = $true
            
            try {
                $textBoxResultados.AppendText("`r`n" + ("="*70) + "`r`n")
                $textBoxResultados.AppendText("DISM EN EJECUCION`r`n")
                $textBoxResultados.AppendText(("="*70) + "`r`n`r`n")
                
                # Paso 1: Comprobar salud de la imagen
                Update-Progress "Paso 1/3: Comprobando salud de la imagen..."
                $output1 = dism /online /cleanup-image /checkhealth
                foreach ($line in $output1) {
                    $textBoxResultados.AppendText("$line`r`n")
                }
                
                # Paso 2: Escanear imagen
                Update-Progress "Paso 2/3: Escaneando imagen..."
                $output2 = dism /online /cleanup-image /scanhealth
                foreach ($line in $output2) {
                    $textBoxResultados.AppendText("$line`r`n")
                }
                
                # Paso 3: Restaurar salud
                Update-Progress "Paso 3/3: Restaurando salud de la imagen..."
                $output3 = dism /online /cleanup-image /restorehealth
                foreach ($line in $output3) {
                    $textBoxResultados.AppendText("$line`r`n")
                }
                
                Update-Progress "DISM completado exitosamente."
                [System.Windows.Forms.MessageBox]::Show(
                    "DISM completado exitosamente.`r`nLa imagen de Windows ha sido reparada.",
                    "DISM Completado",
                    [System.Windows.Forms.MessageBoxButtons]::OK,
                    [System.Windows.Forms.MessageBoxIcon]::Information
                )
                
            } catch {
                Update-Progress "Error en DISM: $($_.Exception.Message)"
                [System.Windows.Forms.MessageBox]::Show(
                    "Error ejecutando DISM: $($_.Exception.Message)`r`n`r`n" +
                    "Solucion: Ejecute DISM desde un simbolo del sistema como administrador.",
                    "Error DISM",
                    [System.Windows.Forms.MessageBoxButtons]::OK,
                    [System.Windows.Forms.MessageBoxIcon]::Error
                )
            }
            
            $progressBar.Visible = $false
            $progressBar.Style = [System.Windows.Forms.ProgressBarStyle]::Continuous
        } else {
            Update-Progress "DISM cancelado por el usuario."
        }
    }

    # ============ EVENTOS DE BOTONES ============

    # Eventos hover para botones
    $buttons = @($btnEscanearDisco, $btnRepararDisco, $btnRepararSFC, $btnRepararDISM)
    
    foreach ($button in $buttons) {
        $button.Add_MouseEnter({
            $this.BackColor = [System.Drawing.Color]::LightBlue
            $this.Cursor = [System.Windows.Forms.Cursors]::Hand
        })
        $button.Add_MouseLeave({
            $this.BackColor = [System.Drawing.Color]::LightGray
            $this.Cursor = [System.Windows.Forms.Cursors]::Default
        })
    }

    # Evento boton Escanear Disco
    $btnEscanearDisco.Add_Click({
        Start-DiskScan
    })

    # Evento boton Reparar Disco
    $btnRepararDisco.Add_Click({
        Start-DiskRepair
    })

    # Evento boton Reparar SFC
    $btnRepararSFC.Add_Click({
        Start-SFCRepair
    })

    # Evento boton Reparar DISM
    $btnRepararDISM.Add_Click({
        Start-DISMRepair
    })

    # Evento boton Cerrar
    $btnCerrar.Add_Click({
        $formReparacion.Close()
    })

    # Mostrar formulario
    $formReparacion.Add_Shown({$formReparacion.Activate()})
    [void]$formReparacion.ShowDialog()
}


