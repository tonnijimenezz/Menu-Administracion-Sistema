# Cargar ensamblados necesarios para Windows Forms
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Obtener la ruta del script principal
$ScriptDirectory = $PSScriptRoot
if (-not $ScriptDirectory) {
    $ScriptDirectory = Split-Path -Parent $MyInvocation.MyCommand.Path
}

#Write-Host "=== INICIANDO CARGA DE MÓDULOS ===" -ForegroundColor Yellow

# CARGAR DIRECTAMENTE EL MÓDULO
$modulePath = Join-Path $ScriptDirectory "InformacionSistema.ps1"

if (Test-Path $modulePath) {
    #Write-Host " Archivo encontrado: InformacionSistema.ps1" -ForegroundColor Green
    try {
        # Cargar el módulo usando el operador punto
        . $modulePath
        #Write-Host " Módulo InformacionSistema CARGADO" -ForegroundColor Green
        
        # Verificar si la función se cargó
      #  if (Get-Command Show-InformacionSistemaMenu -ErrorAction SilentlyContinue) {
        #    Write-Host " Función Show-InformacionSistemaMenu DISPONIBLE" -ForegroundColor Green
        #} else {
      #      Write-Host " Función Show-InformacionSistemaMenu NO disponible" -ForegroundColor Red
       # }
    }
    catch {
        Write-Host " Error al cargar: $_" -ForegroundColor Red
    }
} else {
    Write-Host " Archivo InformacionSistema.ps1 no encontrado" -ForegroundColor Red
    Write-Host "Archivos en la carpeta:" -ForegroundColor Cyan
    Get-ChildItem $ScriptDirectory -Name *.ps1 | ForEach-Object { Write-Host "  - $_" -ForegroundColor White }
}

#Write-Host "=== CARGA COMPLETADA ===" -ForegroundColor Yellow

# Cargar módulo de limpieza 
$CleaningModule = Join-Path $ScriptDirectory "liberadordedisco.ps1"
if (Test-Path $CleaningModule) {
    try {
        . $CleaningModule
        #Write-Host "Liberador de disco cargado correctamente" -ForegroundColor Green
    }
    catch {
        Write-Host "Error cargando liberador de disco: $_" -ForegroundColor Red
    }
}

# Cargar módulo de reparación
$RepairModule = Join-Path $ScriptDirectory "ReparacionDiscoSistema.ps1"
if (Test-Path $RepairModule) {
    try {
        . $RepairModule
      #  Write-Host "Módulo de reparación cargado correctamente" -ForegroundColor Green
    }
    catch {
        Write-Host "Error cargando módulo de reparación: $_" -ForegroundColor Red
    }
}

# Cargar módulo de herramientas de red
$moduloRed = Join-Path $ScriptDirectory "Herramientasdered.ps1"
if (Test-Path $moduloRed) {
    try {
        . $moduloRed
       
    }
    catch {
        Write-Host "Error cargando herramientas de red: $_" -ForegroundColor Red
    }
}

# Cargar módulo de monitor de rendimiento
$MonitorModule = Join-Path $ScriptDirectory "MonitorRendimiento.ps1"
if (Test-Path $MonitorModule) {
    try {
        . $MonitorModule

    }
    catch {
        Write-Host "Error cargando monitor: $_" -ForegroundColor Red
    }
}

# Crear formulario principal
$form = New-Object System.Windows.Forms.Form
$form.Text = "Herramientas de Administracion del Sistema"
$form.Size = New-Object System.Drawing.Size(625, 535)
$form.StartPosition = "CenterScreen"
$form.MaximizeBox = $false
$form.FormBorderStyle = "FixedDialog"
$form.BackColor = [System.Drawing.Color]::White

# Titulo
$labelTitle = New-Object System.Windows.Forms.Label
$labelTitle.Text = "HERRAMIENTAS DE ADMINISTRACION"
$labelTitle.Font = New-Object System.Drawing.Font("Arial", 14, [System.Drawing.FontStyle]::Bold)
$labelTitle.ForeColor = [System.Drawing.Color]::DarkBlue
$labelTitle.Size = New-Object System.Drawing.Size(450, 50)
$labelTitle.Location = New-Object System.Drawing.Point(125, 20)
$form.Controls.Add($labelTitle)

# Panel para agrupar botones
$panel = New-Object System.Windows.Forms.Panel
$panel.Location = New-Object System.Drawing.Point(50, 70)
$panel.Size = New-Object System.Drawing.Size(500, 350)
$panel.BorderStyle = "FixedSingle"
$form.Controls.Add($panel)

# Boton 1: Informacion del Sistema
$btnInformacionSistema = New-Object System.Windows.Forms.Button
$btnInformacionSistema.Text = "1. Informacion del Sistema"
$btnInformacionSistema.Font = New-Object System.Drawing.Font("Arial", 10, [System.Drawing.FontStyle]::Regular)
$btnInformacionSistema.ForeColor = [System.Drawing.Color]::DarkGreen
$btnInformacionSistema.Size = New-Object System.Drawing.Size(200, 40)
$btnInformacionSistema.Location = New-Object System.Drawing.Point(150, 30)
$btnInformacionSistema.BackColor = [System.Drawing.Color]::LightGray
$panel.Controls.Add($btnInformacionSistema)

# Boton 2: Limpieza y Mantenimiento
$btnliberadordedisco = New-Object System.Windows.Forms.Button
$btnliberadordedisco.Text = "2. Liberador de espacio"
$btnliberadordedisco.Font = New-Object System.Drawing.Font("Arial", 10, [System.Drawing.FontStyle]::Regular)
$btnliberadordedisco.ForeColor = [System.Drawing.Color]::DarkGreen
$btnliberadordedisco.Size = New-Object System.Drawing.Size(200, 40)
$btnliberadordedisco.Location = New-Object System.Drawing.Point(150, 80)
$btnliberadordedisco.BackColor = [System.Drawing.Color]::LightGray
$panel.Controls.Add($btnliberadordedisco)

# Boton 3: Reparacion de Disco y Sistema
$btnRepair = New-Object System.Windows.Forms.Button
$btnRepair.Text = "3. Reparacion de Disco y Sistema"
$btnRepair.Font = New-Object System.Drawing.Font("Arial", 10, [System.Drawing.FontStyle]::Regular)
$btnRepair.ForeColor = [System.Drawing.Color]::DarkGreen
$btnRepair.Size = New-Object System.Drawing.Size(200, 40)
$btnRepair.Location = New-Object System.Drawing.Point(150, 130)
$btnRepair.BackColor = [System.Drawing.Color]::LightGray
$panel.Controls.Add($btnRepair)

# Boton 4: Herramientas de Red
$btnNetwork = New-Object System.Windows.Forms.Button
$btnNetwork.Text = "4. Herramientas de Red"
$btnNetwork.Font = New-Object System.Drawing.Font("Arial", 10, [System.Drawing.FontStyle]::Regular)
$btnNetwork.ForeColor = [System.Drawing.Color]::DarkGreen
$btnNetwork.Size = New-Object System.Drawing.Size(200, 40)
$btnNetwork.Location = New-Object System.Drawing.Point(150, 180)
$btnNetwork.BackColor = [System.Drawing.Color]::LightGray
$panel.Controls.Add($btnNetwork)

#Boton 5: Monitor Rendimiento
$btnMonitor = New-Object System.Windows.Forms.Button
$btnMonitor.Text = "5. Monitor de Rendimiento"
$btnMonitor.Font = New-Object System.Drawing.Font("Arial", 10, [System.Drawing.FontStyle]::Regular)
$btnMonitor.ForeColor = [System.Drawing.Color]::DarkGreen
$btnMonitor.Size = New-Object System.Drawing.Size(200, 40)
$btnMonitor.Location = New-Object System.Drawing.Point(150, 230)
$btnMonitor.BackColor = [System.Drawing.Color]::LightGray
$panel.Controls.Add($btnMonitor)



# Boton Salir
$btnExit = New-Object System.Windows.Forms.Button
$btnExit.Text = "Salir"
$btnExit.Font = New-Object System.Drawing.Font("Arial", 10, [System.Drawing.FontStyle]::Bold)
$btnExit.ForeColor = [System.Drawing.Color]::White
$btnExit.Size = New-Object System.Drawing.Size(100, 35)
$btnExit.Location = New-Object System.Drawing.Point(250, 430)
$btnExit.BackColor = [System.Drawing.Color]::DarkRed
$btnExit.Add_Click({$form.Close()})
$form.Controls.Add($btnExit)

# Etiqueta de estado
$labelStatus = New-Object System.Windows.Forms.Label
$labelStatus.Text = "Seleccione una opcion del menu"
$labelStatus.Font = New-Object System.Drawing.Font("Arial", 9, [System.Drawing.FontStyle]::Italic)
$labelStatus.ForeColor = [System.Drawing.Color]::Gray
$labelStatus.Size = New-Object System.Drawing.Size(300, 20)
$labelStatus.Location = New-Object System.Drawing.Point(150, 380)
$form.Controls.Add($labelStatus)

# Agregar eventos de hover para los botones
$buttons = @($btnInformacionSistema, $btnliberadordedisco, $btnRepair, $btnNetwork)

foreach ($button in $buttons) {
    $button.Add_MouseEnter({
        $this.BackColor = [System.Drawing.Color]::LightBlue
    })
    $button.Add_MouseLeave({
        $this.BackColor = [System.Drawing.Color]::LightGray
    })
    $button.Add_Click({
        $labelStatus.Text = "Seleccionado: " + $this.Text
    })
}

# Evento para el botón Informacion del Sistema 
$btnInformacionSistema.Add_Click({
    if (Get-Command Show-InformacionSistemaMenu -ErrorAction SilentlyContinue) {
        $labelStatus.Text = "Abriendo Informacion del Sistema..."
        Show-InformacionSistemaMenu
    } else {
        $labelStatus.Text = "ERROR: Función no disponible"
        # Mensaje más específico
        $availableFunctions = (Get-Command -CommandType Function).Name -join ", "
        [System.Windows.Forms.MessageBox]::Show(
            "La función 'Show-InformacionSistemaMenu' no está disponible.`r`n`r`nFunciones cargadas:`r`n$availableFunctions",
            "Error de Carga del Módulo",
            [System.Windows.Forms.MessageBoxButtons]::OK,
            [System.Windows.Forms.MessageBoxIcon]::Error
        )
    }
})

# Evento para el botón Liberador de Disco
$btnliberadordedisco.Add_Click({
    if (Get-Command Show-CleaningMenu -ErrorAction SilentlyContinue) {
        $labelStatus.Text = "Abriendo Liberador de Disco..."
        Show-CleaningMenu
    } else {
        $labelStatus.Text = "ERROR: Módulo no disponible"
        [System.Windows.Forms.MessageBox]::Show(
            "El módulo Liberador de Disco no está disponible.",
            "Error",
            [System.Windows.Forms.MessageBoxButtons]::OK,
            [System.Windows.Forms.MessageBoxIcon]::Error
        )
    }
})

# Evento para el botón Reparacion de Disco
$btnRepair.Add_Click({
    if (Get-Command Show-ReparacionMenu -ErrorAction SilentlyContinue) {
        $labelStatus.Text = "Abriendo Reparación de Disco y Sistema..."
        Show-ReparacionMenu
    } else {
        $labelStatus.Text = "ERROR: Módulo no disponible"
        [System.Windows.Forms.MessageBox]::Show(
            "El módulo de reparación no está disponible.",
            "Error",
            [System.Windows.Forms.MessageBoxButtons]::OK,
            [System.Windows.Forms.MessageBoxIcon]::Error
        )
    }
})

# Evento para el botón Herramientas de Red
$btnNetwork.Add_Click({
    if (Get-Command Mostrar-HerramientasRed -ErrorAction SilentlyContinue) {
        $labelStatus.Text = "Abriendo Herramientas de Red..."
        Mostrar-HerramientasRed
    } else {
        $labelStatus.Text = "ERROR: Módulo no disponible"
        [System.Windows.Forms.MessageBox]::Show(
            "El módulo de herramientas de red no está disponible.",
            "Error",
            [System.Windows.Forms.MessageBoxButtons]::OK,
            [System.Windows.Forms.MessageBoxIcon]::Error
        )
    }
})

#EventoMonitorRendimiento
$btnMonitor.Add_Click({
    if (Get-Command Mostrar-MonitorRendimiento -ErrorAction SilentlyContinue) {
        $labelStatus.Text = "Abriendo Monitor de Rendimiento..."
        Mostrar-MonitorRendimiento
    } else {
        $labelStatus.Text = "ERROR: Módulo no disponible"
        [System.Windows.Forms.MessageBox]::Show(
            "El módulo Monitor de Rendimiento no está disponible.",
            "Error",
            [System.Windows.Forms.MessageBoxButtons]::OK,
            [System.Windows.Forms.MessageBoxIcon]::Error
        )
    }
})




$labelNombre = New-Object System.Windows.Forms.Label
$labelNombre.Text = "Por: Antonio Jesús"
$labelNombre.Font = New-Object System.Drawing.Font("Arial", 8, [System.Drawing.FontStyle]::Italic)
$labelNombre.ForeColor = [System.Drawing.Color]::Gray
$labelNombre.Size = New-Object System.Drawing.Size(150, 20)
$labelNombre.Location = New-Object System.Drawing.Point(($form.Width - 170), ($form.Height - 60))
$labelNombre.TextAlign = [System.Drawing.ContentAlignment]::MiddleRight
$form.Controls.Add($labelNombre)


# Mostrar el formulario
$form.ShowDialog()