# SoftwareCompleto.ps1
# Gestor de Software Completo

function Mostrar-GestorSoftware {
    # Ventana principal
    $form = New-Object System.Windows.Forms.Form
    $form.Text = "Gestor de Software Completo"
    $form.Size = New-Object System.Drawing.Size(900, 700)
    $form.StartPosition = "CenterScreen"
    $form.BackColor = [System.Drawing.Color]::White
    $form.FormBorderStyle = "FixedDialog"
    $form.MaximizeBox = $false
    
    $toolTip = New-Object System.Windows.Forms.ToolTip
    $toolTip.AutoPopDelay = 5000
    $toolTip.InitialDelay = 1000
    $toolTip.ReshowDelay = 500
    $toolTip.ShowAlways = $true
    
    # Panel de navegación izquierda
    $panelNav = New-Object System.Windows.Forms.Panel
    $panelNav.Location = New-Object System.Drawing.Point(10, 10)
    $panelNav.Size = New-Object System.Drawing.Size(200, 650)
    $panelNav.BackColor = [System.Drawing.Color]::LightGray
    $form.Controls.Add($panelNav)
    
    # Panel de contenido derecha
    $panelContent = New-Object System.Windows.Forms.Panel
    $panelContent.Location = New-Object System.Drawing.Point(220, 10)
    $panelContent.Size = New-Object System.Drawing.Size(670, 650)
    $panelContent.BackColor = [System.Drawing.Color]::WhiteSmoke
    $form.Controls.Add($panelContent)
    
    # ============ BOTONES DE NAVEGACIÓN ============
    $yPos = 20
    
    # 1. Botón Software Instalado
    $btnSoftware = New-Object System.Windows.Forms.Button
    $btnSoftware.Text = "SOFTWARE INSTALADO"
    $btnSoftware.Location = New-Object System.Drawing.Point(10, $yPos)
    $btnSoftware.Size = New-Object System.Drawing.Size(180, 40)
    $btnSoftware.Font = New-Object System.Drawing.Font("Arial", 10, [System.Drawing.FontStyle]::Bold)
    $btnSoftware.BackColor = [System.Drawing.Color]::RoyalBlue
    $btnSoftware.ForeColor = [System.Drawing.Color]::White
    $btnSoftware.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
    $btnSoftware.Add_Click({
        Mostrar-SoftwareInstalado -Panel $panelContent
    })
    $toolTip.SetToolTip($btnSoftware, "Muestra todo el software instalado en el sistema")
    $panelNav.Controls.Add($btnSoftware)
    $yPos += 50
    
    # 2. Botón Updates Windows
    $btnUpdates = New-Object System.Windows.Forms.Button
    $btnUpdates.Text = "UPDATES WINDOWS"
    $btnUpdates.Location = New-Object System.Drawing.Point(10, $yPos)
    $btnUpdates.Size = New-Object System.Drawing.Size(180, 40)
    $btnUpdates.Font = New-Object System.Drawing.Font("Arial", 10, [System.Drawing.FontStyle]::Bold)
    $btnUpdates.BackColor = [System.Drawing.Color]::DarkOrange
    $btnUpdates.ForeColor = [System.Drawing.Color]::White
    $btnUpdates.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
    $btnUpdates.Add_Click({
        Mostrar-UpdatesWindows -Panel $panelContent
    })
    $toolTip.SetToolTip($btnUpdates, "Historial de actualizaciones de Windows instaladas")
    $panelNav.Controls.Add($btnUpdates)
    $yPos += 50
    
    # 3. Botón Actualizar Todo
    $btnActualizarTodo = New-Object System.Windows.Forms.Button
    $btnActualizarTodo.Text = "ACTUALIZAR TODO"
    $btnActualizarTodo.Location = New-Object System.Drawing.Point(10, $yPos)
    $btnActualizarTodo.Size = New-Object System.Drawing.Size(180, 40)
    $btnActualizarTodo.Font = New-Object System.Drawing.Font("Arial", 10, [System.Drawing.FontStyle]::Bold)
    $btnActualizarTodo.BackColor = [System.Drawing.Color]::Green
    $btnActualizarTodo.ForeColor = [System.Drawing.Color]::White
    $btnActualizarTodo.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
    $btnActualizarTodo.Add_Click({
        Actualizar-TodoConWinget -Panel $panelContent
    })
    $toolTip.SetToolTip($btnActualizarTodo, "Actualiza TODAS las aplicaciones usando Winget")
    $panelNav.Controls.Add($btnActualizarTodo)
    $yPos += 50
    
    # 4. Botón Desinstalar Apps
    $btnDesinstalar = New-Object System.Windows.Forms.Button
    $btnDesinstalar.Text = "DESINSTALAR APPS"
    $btnDesinstalar.Location = New-Object System.Drawing.Point(10, $yPos)
    $btnDesinstalar.Size = New-Object System.Drawing.Size(180, 40)
    $btnDesinstalar.Font = New-Object System.Drawing.Font("Arial", 10, [System.Drawing.FontStyle]::Bold)
    $btnDesinstalar.BackColor = [System.Drawing.Color]::DarkRed
    $btnDesinstalar.ForeColor = [System.Drawing.Color]::White
    $btnDesinstalar.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
    $btnDesinstalar.Add_Click({
        Mostrar-Desinstalador -Panel $panelContent
    })
    $toolTip.SetToolTip($btnDesinstalar, "Desinstala aplicaciones seleccionadas fácilmente")
    $panelNav.Controls.Add($btnDesinstalar)
    
    # Mostrar primera vista por defecto
    Mostrar-SoftwareInstalado -Panel $panelContent
    
    [void]$form.ShowDialog()
}

# ============ FUNCIONES PARA CADA SECCIÓN ============

function Mostrar-SoftwareInstalado {
    param($Panel)
    
    $Panel.Controls.Clear()
    
    # Título
    $labelTitulo = New-Object System.Windows.Forms.Label
    $labelTitulo.Text = "TODO EL SOFTWARE INSTALADO"
    $labelTitulo.Font = New-Object System.Drawing.Font("Arial", 14, [System.Drawing.FontStyle]::Bold)
    $labelTitulo.ForeColor = [System.Drawing.Color]::DarkBlue
    $labelTitulo.Location = New-Object System.Drawing.Point(20, 20)
    $labelTitulo.Size = New-Object System.Drawing.Size(600, 30)
    $Panel.Controls.Add($labelTitulo)
    
    # Nota informativa
    $labelInfo = New-Object System.Windows.Forms.Label
    $labelInfo.Text = "Lista completa de software instalado en el sistema"
    $labelInfo.Font = New-Object System.Drawing.Font("Arial", 9, [System.Drawing.FontStyle]::Italic)
    $labelInfo.ForeColor = [System.Drawing.Color]::Gray
    $labelInfo.Location = New-Object System.Drawing.Point(20, 55)
    $labelInfo.Size = New-Object System.Drawing.Size(600, 20)
    $Panel.Controls.Add($labelInfo)
    
    # ListView para mostrar software
    $listView = New-Object System.Windows.Forms.ListView
    $listView.Name = "listViewSoftware"
    $listView.Location = New-Object System.Drawing.Point(20, 80)
    $listView.Size = New-Object System.Drawing.Size(620, 530)
    $listView.View = [System.Windows.Forms.View]::Details
    $listView.FullRowSelect = $true
    $listView.GridLines = $true
    
    # Columnas
    $listView.Columns.Add("Nombre", 250)
    $listView.Columns.Add("Versión", 100)
    $listView.Columns.Add("Fabricante", 150)
    $listView.Columns.Add("Fecha", 100)
    $listView.Columns.Add("Tamaño", 80)
    
    $Panel.Controls.Add($listView)
    
    # Cargar datos automáticamente
    Cargar-Software -ListView $listView
    
   
}

function Cargar-Software {
    param($ListView)
    
    # Verificar que $ListView no sea nulo
    if (-not $ListView) {
        Write-Host "Error: ListView es nulo" -ForegroundColor Red
        return
    }
    
    # Limpiar lista
    $ListView.Items.Clear()
    
    # Mostrar mensaje de "Cargando..."
    $loadingItem = New-Object System.Windows.Forms.ListViewItem("Cargando aplicaciones...")
    for ($i = 0; $i -lt 4; $i++) {
        $loadingItem.SubItems.Add("")
    }
    $ListView.Items.Add($loadingItem)
    
    # Actualizar UI inmediatamente
    $ListView.Refresh()
    
    # Obtener software usando MÚLTIPLES MÉTODOS para capturar más apps
    
    $allApps = @()
    
    # MÉTODO 1: Win32_Product (MSI tradicional)
    try {
        #Write-Host "Buscando aplicaciones MSI..." -ForegroundColor Yellow
        $msiApps = Get-WmiObject Win32_Product -ErrorAction Stop | 
                   Select-Object @{Name="Nombre"; Expression={$_.Name}},
                                @{Name="Version"; Expression={$_.Version}},
                                @{Name="Fabricante"; Expression={$_.Vendor}},
                                @{Name="Fecha"; Expression={
                                    if ($_.InstallDate) { 
                                        $_.InstallDate.Substring(0,8).Insert(6,'-').Insert(4,'-') 
                                    } else { 
                                        "N/A" 
                                    }
                                }},
                                @{Name="Tamaño"; Expression={
                                    if ($_.EstimatedSize) {
                                        "$([math]::Round($_.EstimatedSize / 1024, 2)) MB"
                                    } else {
                                        "N/A"
                                    }
                                }},
                                @{Name="Tipo"; Expression="MSI"}
        $allApps += $msiApps
       # Write-Host "Encontradas $($msiApps.Count) apps MSI" -ForegroundColor Green
    } catch {
        Write-Host "Error Win32_Product: $_" -ForegroundColor Red
    }
    
    # MÉTODO 2: Registro de Windows (32-bit)
    try {
        #Write-Host "Buscando en registro 32-bit..." -ForegroundColor Yellow
        $reg32Path = "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*"
        $reg32Apps = Get-ItemProperty $reg32Path -ErrorAction SilentlyContinue | 
                    Where-Object { $_.DisplayName -and $_.DisplayName -notmatch '^Update for|^Security Update|^Hotfix'} |
                    Select-Object @{Name="Nombre"; Expression={$_.DisplayName}},
                                 @{Name="Version"; Expression={$_.DisplayVersion}},
                                 @{Name="Fabricante"; Expression={$_.Publisher}},
                                 @{Name="Fecha"; Expression={
                                     if ($_.InstallDate) {
                                         try {
                                             $dateStr = $_.InstallDate.ToString()
                                             if ($dateStr.Length -ge 8) {
                                                 $dateStr.Substring(0,8).Insert(6,'-').Insert(4,'-')
                                             } else { "N/A" }
                                         } catch { "N/A" }
                                     } else { "N/A" }
                                 }},
                                 @{Name="Tamaño"; Expression={
                                     if ($_.EstimatedSize) {
                                         "$([math]::Round($_.EstimatedSize / 1024, 2)) MB"
                                     } else {
                                         "N/A"
                                     }
                                 }},
                                 @{Name="Tipo"; Expression="Registro 32-bit"}
        $allApps += $reg32Apps
        #Write-Host "Encontradas $($reg32Apps.Count) apps en registro 32-bit" -ForegroundColor Green
    } catch {
        Write-Host "Error registro 32-bit: $_" -ForegroundColor Red
    }
    
    # MÉTODO 3: Registro de Windows (64-bit)
    try {
        #Write-Host "Buscando en registro 64-bit..." -ForegroundColor Yellow
        $reg64Path = "HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*"
        $reg64Apps = Get-ItemProperty $reg64Path -ErrorAction SilentlyContinue | 
                    Where-Object { $_.DisplayName -and $_.DisplayName -notmatch '^Update for|^Security Update|^Hotfix'} |
                    Select-Object @{Name="Nombre"; Expression={$_.DisplayName}},
                                 @{Name="Version"; Expression={$_.DisplayVersion}},
                                 @{Name="Fabricante"; Expression={$_.Publisher}},
                                 @{Name="Fecha"; Expression="N/A"},
                                 @{Name="Tamaño"; Expression="N/A"},
                                 @{Name="Tipo"; Expression="Registro 64-bit"}
        $allApps += $reg64Apps
       # Write-Host "Encontradas $($reg64Apps.Count) apps en registro 64-bit" -ForegroundColor Green
    } catch {
        Write-Host "Error registro 64-bit: $_" -ForegroundColor Red
    }
    
    # MÉTODO 4: Usuarios actuales
    try {
     #   Write-Host "Buscando apps de usuario..." -ForegroundColor Yellow
        $userPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*"
        $userApps = Get-ItemProperty $userPath -ErrorAction SilentlyContinue | 
                   Where-Object { $_.DisplayName } |
                   Select-Object @{Name="Nombre"; Expression={$_.DisplayName}},
                                @{Name="Version"; Expression={$_.DisplayVersion}},
                                @{Name="Fabricante"; Expression={$_.Publisher}},
                                @{Name="Fecha"; Expression="N/A"},
                                @{Name="Tamaño"; Expression="N/A"},
                                @{Name="Tipo"; Expression="Usuario"}
        $allApps += $userApps
       # Write-Host "Encontradas $($userApps.Count) apps de usuario" -ForegroundColor Green
    } catch {
        Write-Host "Error apps usuario: $_" -ForegroundColor Red
    }
    
    # Limpiar lista de "Cargando..."
    $ListView.Items.Clear()
    
    if ($allApps.Count -eq 0) {
        $errorItem = New-Object System.Windows.Forms.ListViewItem("No se encontraron aplicaciones")
        for ($i = 0; $i -lt 4; $i++) {
            $errorItem.SubItems.Add("")
        }
        $ListView.Items.Add($errorItem)
        return
    }
    
    # Eliminar duplicados y ordenar
    $uniqueApps = $allApps | Where-Object { $_.Nombre } | 
                  Sort-Object Nombre -Unique | 
                  Sort-Object Nombre
    
   # Write-Host "Total de aplicaciones únicas: $($uniqueApps.Count)" -ForegroundColor Cyan
    
    # Agregar a la ListView
    foreach ($app in $uniqueApps) {
        try {
            $item = New-Object System.Windows.Forms.ListViewItem($app.Nombre)
            
            # Manejar valores nulos
            $version = if ($app.Version) { $app.Version.ToString() } else { "N/A" }
            $fabricante = if ($app.Fabricante) { $app.Fabricante.ToString() } else { "N/A" }
            $fecha = if ($app.Fecha) { $app.Fecha.ToString() } else { "N/A" }
            $tamaño = if ($app.Tamaño) { $app.Tamaño.ToString() } else { "N/A" }
            
            $item.SubItems.Add($version)
            $item.SubItems.Add($fabricante)
            $item.SubItems.Add($fecha)
            $item.SubItems.Add($tamaño)
            
            # Colorear por tipo (opcional)
            if ($app.Tipo -eq "MSI") {
                $item.BackColor = [System.Drawing.Color]::LightCyan
            } elseif ($app.Tipo -eq "Usuario") {
                $item.BackColor = [System.Drawing.Color]::LightYellow
            }
            
            $ListView.Items.Add($item)
        } catch {
            Write-Host "Error agregando app '$($app.Nombre)': $_" -ForegroundColor Red
        }
    }
    
    # Mostrar contador
   # $ListView.Tag = "Total: $($uniqueApps.Count) aplicaciones"
}

function Desinstalar-Aplicacion {
    param([string]$Nombre)
    
  #  Write-Host "=== INTENTANDO DESINSTALAR: '$Nombre' ===" -ForegroundColor Cyan
    
    try {
        # Buscar en TODAS las ubicaciones del registro
       # Write-Host "Buscando '$Nombre' en registro..." -ForegroundColor Yellow
        
        $paths = @(
            "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall",
            "HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall", 
            "HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall"
        )
        
        $appEncontrada = $null
        $uninstallCmd = $null
        
        foreach ($path in $paths) {
            if (Test-Path $path) {
                Write-Host "Buscando en: $path" -ForegroundColor Gray
                
                # Obtener todas las claves
                $keys = Get-ChildItem $path -ErrorAction SilentlyContinue
                
                foreach ($key in $keys) {
                    $props = Get-ItemProperty $key.PSPath -ErrorAction SilentlyContinue
                    
                    if ($props -and $props.DisplayName -eq $Nombre) {
                      #  Write-Host "✓ ENCONTRADA en: $($key.Name)" -ForegroundColor Green
                       # Write-Host "  UninstallString: $($props.UninstallString)" -ForegroundColor Gray
                        
                        $appEncontrada = $props
                        $uninstallCmd = $props.UninstallString
                        break
                    }
                }
                
                if ($appEncontrada) { break }
            }
        }
        
        if (-not $uninstallCmd) {
          #  Write-Host "✗ NO ENCONTRADA en el registro" -ForegroundColor Red
            return $false
        }
        
        # PROCESAR EL COMANDO DE DESINSTALACIÓN
      #  Write-Host "Procesando comando de desinstalación..." -ForegroundColor Yellow
        
        # 1. Si es MSI
        if ($uninstallCmd -match "^msiexec") {
      #      Write-Host "Es un MSI" -ForegroundColor Green
            
            # Extraer el ProductCode (GUID)
            if ($uninstallCmd -match '\{([A-F0-9\-]+)\}') {
                $productCode = $matches[1]
              #  Write-Host "ProductCode: $productCode" -ForegroundColor Gray
                
                # Comando MSI silencioso
                $msiCmd = "msiexec.exe /x `{$productCode`} /quiet /norestart"
               # Write-Host "Ejecutando: $msiCmd" -ForegroundColor Yellow
                
                # Ejecutar como administrador
                Start-Process "msiexec.exe" "/x `{$productCode`} /quiet /norestart" -Verb RunAs -Wait
               # Write-Host "✓ MSI desinstalado" -ForegroundColor Green
                return $true
            }
        }
        
        # 2. Si es un .exe
        elseif ($uninstallCmd -match "\.exe") {
          #  Write-Host "Es un ejecutable .exe" -ForegroundColor Green
            
            # Extraer ruta del ejecutable
            if ($uninstallCmd -match '"([^"]+\.exe)"') {
                $exePath = $matches[1]
            } else {
                $exePath = $uninstallCmd -split "\.exe" | Select-Object -First 1
                $exePath += ".exe"
            }
            
          #  Write-Host "Ejecutable: $exePath" -ForegroundColor Gray
            
            # Comando con parámetros silenciosos
            $exeCmd = "`"$exePath`""
            
            # Añadir parámetros comunes de desinstalación silenciosa
            if ($uninstallCmd -notmatch "/S" -and $uninstallCmd -notmatch "/silent" -and $uninstallCmd -notmatch "/quiet") {
                $exeCmd += " /S"  # Parámetro silencioso común
            }
            
            # Añadir parámetros adicionales del comando original
            if ($uninstallCmd -match "\.exe (.+)") {
                $params = $matches[1]
                if ($params -notmatch "/S" -and $params -notmatch "/silent") {
                    $exeCmd += " $params"
                }
            }
            
         #   Write-Host "Ejecutando: $exeCmd" -ForegroundColor Yellow
            
            # Ejecutar
            Start-Process "cmd.exe" "/c $exeCmd" -Wait -NoNewWindow
      #      Write-Host "✓ Ejecutable desinstalado" -ForegroundColor Green
            return $true
        }
        
        # 3. Otros formatos - ejecutar tal cual
        else {
      #      Write-Host "Otro formato, ejecutando tal cual..." -ForegroundColor Yellow
      #      Write-Host "Comando: $uninstallCmd" -ForegroundColor Gray
            
            Start-Process "cmd.exe" "/c `"$uninstallCmd`"" -Wait -NoNewWindow
     #       Write-Host "✓ Comando ejecutado" -ForegroundColor Green
            return $true
        }
        
        return $false
        
    } catch {
        Write-Host "✗ ERROR: $_" -ForegroundColor Red
        return $false
    }
}


function Mostrar-UpdatesWindows {
    param($Panel)
    
    $Panel.Controls.Clear()
    
    $labelTitulo = New-Object System.Windows.Forms.Label
    $labelTitulo.Text = "HISTORIAL DE ACTUALIZACIONES WINDOWS"
    $labelTitulo.Font = New-Object System.Drawing.Font("Arial", 14, [System.Drawing.FontStyle]::Bold)
    $labelTitulo.ForeColor = [System.Drawing.Color]::DarkOrange
    $labelTitulo.Location = New-Object System.Drawing.Point(20, 20)
    $labelTitulo.Size = New-Object System.Drawing.Size(600, 30)
    $Panel.Controls.Add($labelTitulo)
    
    # TextBox para mostrar updates
    $textBox = New-Object System.Windows.Forms.TextBox
    $textBox.Multiline = $true
    $textBox.ScrollBars = "Vertical"
    $textBox.Location = New-Object System.Drawing.Point(20, 60)
    $textBox.Size = New-Object System.Drawing.Size(620, 550)
    $textBox.ReadOnly = $true
    $textBox.Font = New-Object System.Drawing.Font("Consolas", 9)
    
    # Obtener updates
    $updates = Get-HotFix | Sort-Object InstalledOn -Descending | Select-Object HotFixID, Description, InstalledOn, @{
        Name="Tipo";
        Expression={if($_.Description -like "*Security*"){"Security"}elseif($_.Description -like "*Update*"){"Update"}else{"Otro"}}
    }
    
    $textBox.Text = "TOTAL de updates: $($updates.Count)`n`n"
    $textBox.AppendText("ID".PadRight(15) + "TIPO".PadRight(15) + "FECHA".PadRight(20) + "DESCRIPCIÓN`n")
    $textBox.AppendText("-" * 70 + "`n")
    
    foreach ($update in $updates) {
        $fecha = if ($update.InstalledOn) { $update.InstalledOn.ToString("dd/MM/yyyy") } else { "N/A" }
        $linea = "$($update.HotFixID)".PadRight(15) + 
                 "$($update.Tipo)".PadRight(15) + 
                 $fecha.PadRight(20) + 
                 $update.Description
        $textBox.AppendText("$linea`n")
    }
    
    $Panel.Controls.Add($textBox)
}

function Actualizar-TodoConWinget {
    param($Panel)
    
    $Panel.Controls.Clear()
    
    $labelTitulo = New-Object System.Windows.Forms.Label
    $labelTitulo.Text = "ACTUALIZAR TODO CON WINGET"
    $labelTitulo.Font = New-Object System.Drawing.Font("Arial", 14, [System.Drawing.FontStyle]::Bold)
    $labelTitulo.ForeColor = [System.Drawing.Color]::Green
    $labelTitulo.Location = New-Object System.Drawing.Point(20, 20)
    $labelTitulo.Size = New-Object System.Drawing.Size(600, 30)
    $Panel.Controls.Add($labelTitulo)
    
    $labelInfo = New-Object System.Windows.Forms.Label
    $labelInfo.Text = "Esta acción actualizará TODAS las aplicaciones usando Winget."
    $labelInfo.Location = New-Object System.Drawing.Point(20, 60)
    $labelInfo.Size = New-Object System.Drawing.Size(600, 40)
    $Panel.Controls.Add($labelInfo)
    
    # Checkbox para confirmar
    $checkConfirm = New-Object System.Windows.Forms.CheckBox
    $checkConfirm.Text = "Sí, quiero actualizar todas mis aplicaciones"
    $checkConfirm.Location = New-Object System.Drawing.Point(20, 110)
    $checkConfirm.Size = New-Object System.Drawing.Size(300, 25)
    $Panel.Controls.Add($checkConfirm)
    
    # Botón ejecutar
    $btnEjecutar = New-Object System.Windows.Forms.Button
    $btnEjecutar.Text = "EJECUTAR ACTUALIZACIÓN MASIVA"
    $btnEjecutar.Location = New-Object System.Drawing.Point(20, 150)
    $btnEjecutar.Size = New-Object System.Drawing.Size(300, 50)
    $btnEjecutar.BackColor = [System.Drawing.Color]::Green
    $btnEjecutar.ForeColor = [System.Drawing.Color]::White
    $btnEjecutar.Font = New-Object System.Drawing.Font("Arial", 11, [System.Drawing.FontStyle]::Bold)
    $btnEjecutar.Enabled = $false
   $btnEjecutar.Add_Click({
    # Ejecutar winget upgrade --all
    try {
        # Mostrar mensaje en la MISMA ventana
        $Panel.Controls.Clear()
        $label = New-Object System.Windows.Forms.Label
        $label.Text = "Actualizando aplicaciones... por favor espera"
        $label.Font = New-Object System.Drawing.Font("Arial", 12, [System.Drawing.FontStyle]::Bold)
        $label.Location = New-Object System.Drawing.Point(100, 200)
        $label.Size = New-Object System.Drawing.Size(400, 30)
        $Panel.Controls.Add($label)
        $Panel.Refresh()
        
        $output = winget upgrade --all --accept-package-agreements --accept-source-agreements --silent
        
        [System.Windows.Forms.MessageBox]::Show("Actualización completada con éxito", "Éxito", "OK", "Information")
        Actualizar-TodoConWinget -Panel $Panel  # Recargar
    } catch {
        [System.Windows.Forms.MessageBox]::Show("Error: $($_.Exception.Message)", "Error", "OK", "Error")
    }
})
    $Panel.Controls.Add($btnEjecutar)
    
    # Habilitar botón cuando se marque el checkbox
    $checkConfirm.Add_CheckedChanged({
        $btnEjecutar.Enabled = $checkConfirm.Checked
    })
    
    # Área de resultados
    $textBox = New-Object System.Windows.Forms.TextBox
    $textBox.Multiline = $true
    $textBox.ScrollBars = "Vertical"
    $textBox.Location = New-Object System.Drawing.Point(20, 220)
    $textBox.Size = New-Object System.Drawing.Size(620, 390)
    $textBox.ReadOnly = $true
    $Panel.Controls.Add($textBox)
    
    # Botón para ver qué se actualizaría
    $btnVer = New-Object System.Windows.Forms.Button
    $btnVer.Text = "Ver qué se actualizaría"
    $btnVer.Location = New-Object System.Drawing.Point(340, 150)
    $btnVer.Size = New-Object System.Drawing.Size(150, 50)
    $btnVer.Add_Click({
        $textBox.Text = "Consultando actualizaciones disponibles...`n`n"
        $textBox.AppendText("Ejecutando: winget upgrade --all --include-unknown`n`n")
        
        try {
            $updates = winget upgrade --all --include-unknown --accept-source-agreements
            $textBox.AppendText($updates)
        } catch {
            $textBox.AppendText("Error: $($_.Exception.Message)`n`n")
            $textBox.AppendText("Asegúrate de tener Winget instalado.`n")
            $textBox.AppendText("Puedes instalarlo desde Microsoft Store.")
        }
    })
    $Panel.Controls.Add($btnVer)
}

function Mostrar-Desinstalador {
    param($Panel)
    
    $Panel.Controls.Clear()
    
    # Título
    $labelTitulo = New-Object System.Windows.Forms.Label
    $labelTitulo.Text = "DESINSTALAR APLICACIONES"
    $labelTitulo.Font = New-Object System.Drawing.Font("Arial", 14, [System.Drawing.FontStyle]::Bold)
    $labelTitulo.ForeColor = [System.Drawing.Color]::DarkRed
    $labelTitulo.Location = New-Object System.Drawing.Point(20, 20)
    $labelTitulo.Size = New-Object System.Drawing.Size(600, 30)
    $Panel.Controls.Add($labelTitulo)
    
    # Etiqueta
    $labelInfo = New-Object System.Windows.Forms.Label
    $labelInfo.Text = "Selecciona aplicaciones para desinstalar"
    $labelInfo.Font = New-Object System.Drawing.Font("Arial", 9, [System.Drawing.FontStyle]::Italic)
    $labelInfo.ForeColor = [System.Drawing.Color]::Gray
    $labelInfo.Location = New-Object System.Drawing.Point(20, 55)
    $labelInfo.Size = New-Object System.Drawing.Size(600, 20)
    $Panel.Controls.Add($labelInfo)
    
    # Panel con scroll
    $scrollPanel = New-Object System.Windows.Forms.Panel
    $scrollPanel.Location = New-Object System.Drawing.Point(20, 80)
    $scrollPanel.Size = New-Object System.Drawing.Size(620, 440)
    $scrollPanel.AutoScroll = $true
    $scrollPanel.BorderStyle = [System.Windows.Forms.BorderStyle]::FixedSingle
    $Panel.Controls.Add($scrollPanel)
    
    $allApps = @()

# MÉTODO 1: Win32_Product (MSI)
try {
    $msiApps = Get-WmiObject Win32_Product -ErrorAction SilentlyContinue | 
               Select-Object @{Name="Nombre"; Expression={$_.Name}},
                            @{Name="Version"; Expression={$_.Version}},
                            @{Name="Fabricante"; Expression={$_.Vendor}},
                            @{Name="TamañoMB"; Expression={
                                if ($_.EstimatedSize) {
                                    [math]::Round($_.EstimatedSize / 1024, 2)
                                } else { 0 }
                            }}
    $allApps += $msiApps
  #  Write-Host "Encontradas $($msiApps.Count) apps MSI" -ForegroundColor Green
} catch {
    Write-Host "Error Win32_Product: $_" -ForegroundColor Red
}

# MÉTODO 2: Registro 32-bit
try {
    $reg32Path = "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*"
    $reg32Apps = Get-ItemProperty $reg32Path -ErrorAction SilentlyContinue | 
                Where-Object { $_.DisplayName -and $_.DisplayName -notmatch '^Update for|^Security Update|^Hotfix'} |
                Select-Object @{Name="Nombre"; Expression={$_.DisplayName}},
                             @{Name="Version"; Expression={$_.DisplayVersion}},
                             @{Name="Fabricante"; Expression={$_.Publisher}},
                             @{Name="TamañoMB"; Expression={0}}
    $allApps += $reg32Apps
  #  Write-Host "Encontradas $($reg32Apps.Count) apps registro 32-bit" -ForegroundColor Green
} catch {
    Write-Host "Error registro 32-bit: $_" -ForegroundColor Red
}

# MÉTODO 3: Registro 64-bit
try {
    $reg64Path = "HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*"
    $reg64Apps = Get-ItemProperty $reg64Path -ErrorAction SilentlyContinue | 
                Where-Object { $_.DisplayName -and $_.DisplayName -notmatch '^Update for|^Security Update|^Hotfix'} |
                Select-Object @{Name="Nombre"; Expression={$_.DisplayName}},
                             @{Name="Version"; Expression={$_.DisplayVersion}},
                             @{Name="Fabricante"; Expression={$_.Publisher}},
                             @{Name="TamañoMB"; Expression={0}}
    $allApps += $reg64Apps
   # Write-Host "Encontradas $($reg64Apps.Count) apps registro 64-bit" -ForegroundColor Green
} catch {
    Write-Host "Error registro 64-bit: $_" -ForegroundColor Red
}

# Eliminar duplicados y ordenar
$uniqueApps = $allApps | Where-Object { $_.Nombre } | 
              Sort-Object Nombre -Unique | 
              Sort-Object Nombre

#Write-Host "Total aplicaciones únicas: $($uniqueApps.Count)" -ForegroundColor Cyan



# Crear checkboxes para cada app
$global:checkboxesDesinstalar = @()
$yPos = 10

foreach ($app in $uniqueApps) {
    $check = New-Object System.Windows.Forms.CheckBox
    
    # Mostrar nombre y tamaño si está disponible
    $sizeText = if ($app.TamañoMB -gt 0) { " ($($app.TamañoMB) MB)" } else { "" }
    $check.Text = "$($app.Nombre)$sizeText"
    
    $check.Location = New-Object System.Drawing.Point(10, $yPos)
    $check.Size = New-Object System.Drawing.Size(580, 25)
    $check.AutoSize = $true
    
    
    
    $scrollPanel.Controls.Add($check)
    $global:checkboxesDesinstalar += $check
    $yPos += 30
}
    
    
    
    # Botón Desinstalar
    $btnDesinstalar = New-Object System.Windows.Forms.Button
    $btnDesinstalar.Text = "DESINSTALAR SELECCIONADAS"
    $btnDesinstalar.Location = New-Object System.Drawing.Point(150, 530)
    $btnDesinstalar.Size = New-Object System.Drawing.Size(350, 50)
    $btnDesinstalar.BackColor = [System.Drawing.Color]::DarkRed
    $btnDesinstalar.ForeColor = [System.Drawing.Color]::White
    $btnDesinstalar.Font = New-Object System.Drawing.Font("Arial", 11, [System.Drawing.FontStyle]::Bold)
    
$btnDesinstalar.Add_Click({
    $selected = @()
    foreach ($check in $global:checkboxesDesinstalar) {
        if ($check.Checked) {
            $selected += $check.Text
        }
    }
    
    if ($selected.Count -gt 0) {
        $result = [System.Windows.Forms.MessageBox]::Show(
            "¿Desinstalar $($selected.Count) apps?", 
            "Confirmar", 
            "YesNo",
            "Question"
        )
        
        if ($result -eq "Yes") {
            foreach ($appName in $selected) {
                Desinstalar-Aplicacion -Nombre $appName
            }
            
            [System.Windows.Forms.MessageBox]::Show(
                "Desinstalación completada.`n`nHaz clic en 'DESINSTALAR APPS' del menú izquierdo para ver la lista actualizada.",
                "Listo",
                "OK",
                "Information"
            )
        }
    }
})
    
    $Panel.Controls.Add($btnDesinstalar)

}