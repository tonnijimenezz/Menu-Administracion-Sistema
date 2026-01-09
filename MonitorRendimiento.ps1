# Monitor de rendimiento del sistema

function Mostrar-MonitorRendimiento {
    # Crear formulario principal
    $formMonitor = New-Object System.Windows.Forms.Form
    $formMonitor.Text = "Monitor de Rendimiento"
    $formMonitor.Size = New-Object System.Drawing.Size(800, 500)
    $formMonitor.StartPosition = "CenterScreen"
    $formMonitor.BackColor = [System.Drawing.Color]::White
    $formMonitor.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedDialog
    $formMonitor.MaximizeBox = $false
    $formMonitor.MinimizeBox = $false

    # Panel principal
    $panelPrincipal = New-Object System.Windows.Forms.Panel
    $panelPrincipal.Location = New-Object System.Drawing.Point(10, 10)
    $panelPrincipal.Size = New-Object System.Drawing.Size(770, 440)
    $panelPrincipal.BackColor = [System.Drawing.Color]::White
    $formMonitor.Controls.Add($panelPrincipal)

    # Titulo
    $labelTitulo = New-Object System.Windows.Forms.Label
    $labelTitulo.Text = "MONITOR DE RENDIMIENTO EN TIEMPO REAL"
    $labelTitulo.Font = New-Object System.Drawing.Font("Arial", 14, [System.Drawing.FontStyle]::Bold)
    $labelTitulo.ForeColor = [System.Drawing.Color]::DarkBlue
    $labelTitulo.Size = New-Object System.Drawing.Size(750, 30)
    $labelTitulo.Location = New-Object System.Drawing.Point(10, 10)
    $labelTitulo.TextAlign = [System.Drawing.ContentAlignment]::MiddleCenter
    $panelPrincipal.Controls.Add($labelTitulo)

    # ============ SECCIÓN CPU ============

    # Etiqueta CPU
    $labelCPU = New-Object System.Windows.Forms.Label
    $labelCPU.Text = "USO DE CPU:"
    $labelCPU.Font = New-Object System.Drawing.Font("Arial", 11, [System.Drawing.FontStyle]::Bold)
    $labelCPU.ForeColor = [System.Drawing.Color]::DarkRed
    $labelCPU.Size = New-Object System.Drawing.Size(150, 25)
    $labelCPU.Location = New-Object System.Drawing.Point(20, 60)
    $panelPrincipal.Controls.Add($labelCPU)

    # Barra progreso CPU
    $barraCPU = New-Object System.Windows.Forms.ProgressBar
    $barraCPU.Size = New-Object System.Drawing.Size(400, 25)
    $barraCPU.Location = New-Object System.Drawing.Point(180, 60)
    $barraCPU.Style = [System.Windows.Forms.ProgressBarStyle]::Continuous
    $panelPrincipal.Controls.Add($barraCPU)

    # Porcentaje CPU
    $labelPorcentajeCPU = New-Object System.Windows.Forms.Label
    $labelPorcentajeCPU.Text = "0%"
    $labelPorcentajeCPU.Font = New-Object System.Drawing.Font("Arial", 11, [System.Drawing.FontStyle]::Bold)
    $labelPorcentajeCPU.ForeColor = [System.Drawing.Color]::DarkRed
    $labelPorcentajeCPU.Size = New-Object System.Drawing.Size(50, 25)
    $labelPorcentajeCPU.Location = New-Object System.Drawing.Point(590, 60)
    $labelPorcentajeCPU.TextAlign = [System.Drawing.ContentAlignment]::MiddleLeft
    $panelPrincipal.Controls.Add($labelPorcentajeCPU)

    # ============ SECCIÓN MEMORIA RAM ============

    # Etiqueta RAM
    $labelRAM = New-Object System.Windows.Forms.Label
    $labelRAM.Text = "USO DE RAM:"
    $labelRAM.Font = New-Object System.Drawing.Font("Arial", 11, [System.Drawing.FontStyle]::Bold)
    $labelRAM.ForeColor = [System.Drawing.Color]::DarkBlue
    $labelRAM.Size = New-Object System.Drawing.Size(150, 25)
    $labelRAM.Location = New-Object System.Drawing.Point(20, 100)
    $panelPrincipal.Controls.Add($labelRAM)

    # Barra progreso RAM
    $barraRAM = New-Object System.Windows.Forms.ProgressBar
    $barraRAM.Size = New-Object System.Drawing.Size(400, 25)
    $barraRAM.Location = New-Object System.Drawing.Point(180, 100)
    $barraRAM.Style = [System.Windows.Forms.ProgressBarStyle]::Continuous
    $panelPrincipal.Controls.Add($barraRAM)

    # Porcentaje RAM
    $labelPorcentajeRAM = New-Object System.Windows.Forms.Label
    $labelPorcentajeRAM.Text = "0%"
    $labelPorcentajeRAM.Font = New-Object System.Drawing.Font("Arial", 11, [System.Drawing.FontStyle]::Bold)
    $labelPorcentajeRAM.ForeColor = [System.Drawing.Color]::DarkBlue
    $labelPorcentajeRAM.Size = New-Object System.Drawing.Size(50, 25)
    $labelPorcentajeRAM.Location = New-Object System.Drawing.Point(590, 100)
    $labelPorcentajeRAM.TextAlign = [System.Drawing.ContentAlignment]::MiddleLeft
    $panelPrincipal.Controls.Add($labelPorcentajeRAM)

    # Info RAM detallada
    $labelInfoRAM = New-Object System.Windows.Forms.Label
    $labelInfoRAM.Text = "Cargando..."
    $labelInfoRAM.Font = New-Object System.Drawing.Font("Arial", 9, [System.Drawing.FontStyle]::Regular)
    $labelInfoRAM.ForeColor = [System.Drawing.Color]::DarkSlateGray
    $labelInfoRAM.Size = New-Object System.Drawing.Size(400, 20)
    $labelInfoRAM.Location = New-Object System.Drawing.Point(180, 130)
    $panelPrincipal.Controls.Add($labelInfoRAM)

    # ============ SECCIÓN DISCOS ============

    # Etiqueta Discos
    $labelDiscos = New-Object System.Windows.Forms.Label
    $labelDiscos.Text = "ESPACIO EN DISCOS:"
    $labelDiscos.Font = New-Object System.Drawing.Font("Arial", 11, [System.Drawing.FontStyle]::Bold)
    $labelDiscos.ForeColor = [System.Drawing.Color]::DarkGreen
    $labelDiscos.Size = New-Object System.Drawing.Size(170, 35)
    $labelDiscos.Location = New-Object System.Drawing.Point(20, 170)
    $panelPrincipal.Controls.Add($labelDiscos)

    # Panel para discos
    $panelDiscos = New-Object System.Windows.Forms.Panel
    $panelDiscos.Location = New-Object System.Drawing.Point(200, 170)
    $panelDiscos.Size = New-Object System.Drawing.Size(530, 100)
    $panelDiscos.BackColor = [System.Drawing.Color]::WhiteSmoke
    $panelDiscos.BorderStyle = "FixedSingle"
    $panelPrincipal.Controls.Add($panelDiscos)

    # ============ SECCIÓN PROCESOS ============

    # Etiqueta Top Procesos
    $labelProcesos = New-Object System.Windows.Forms.Label
    $labelProcesos.Text = "TOP 5 PROCESOS (CPU):"
    $labelProcesos.Font = New-Object System.Drawing.Font("Arial", 11, [System.Drawing.FontStyle]::Bold)
    $labelProcesos.ForeColor = [System.Drawing.Color]::Purple
    $labelProcesos.Size = New-Object System.Drawing.Size(200, 25)
    $labelProcesos.Location = New-Object System.Drawing.Point(20, 290)
    $panelPrincipal.Controls.Add($labelProcesos)

    # Lista de procesos
    $listBoxProcesos = New-Object System.Windows.Forms.ListBox
    $listBoxProcesos.Font = New-Object System.Drawing.Font("Consolas", 9, [System.Drawing.FontStyle]::Regular)
    $listBoxProcesos.Size = New-Object System.Drawing.Size(720, 150)
    $listBoxProcesos.Location = New-Object System.Drawing.Point(20, 320)
    $listBoxProcesos.BackColor = [System.Drawing.Color]::Black
    $listBoxProcesos.ForeColor = [System.Drawing.Color]::Lime
    $panelPrincipal.Controls.Add($listBoxProcesos)

    # ============ BOTONES ============

    # Boton Actualizar
    $btnActualizar = New-Object System.Windows.Forms.Button
    $btnActualizar.Text = "ACTUALIZAR AHORA"
    $btnActualizar.Font = New-Object System.Drawing.Font("Arial", 10, [System.Drawing.FontStyle]::Bold)
    $btnActualizar.ForeColor = [System.Drawing.Color]::White
    $btnActualizar.Size = New-Object System.Drawing.Size(180, 35)
    $btnActualizar.Location = New-Object System.Drawing.Point(200, 460)
    $btnActualizar.BackColor = [System.Drawing.Color]::RoyalBlue
    $btnActualizar.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
    $formMonitor.Controls.Add($btnActualizar)

    # Boton Cerrar
    $btnCerrar = New-Object System.Windows.Forms.Button
    $btnCerrar.Text = "CERRAR"
    $btnCerrar.Font = New-Object System.Drawing.Font("Arial", 10, [System.Drawing.FontStyle]::Bold)
    $btnCerrar.ForeColor = [System.Drawing.Color]::White
    $btnCerrar.Size = New-Object System.Drawing.Size(180, 35)
    $btnCerrar.Location = New-Object System.Drawing.Point(400, 460)
    $btnCerrar.BackColor = [System.Drawing.Color]::DarkRed
    $btnCerrar.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
    $formMonitor.Controls.Add($btnCerrar)

    # ============ FUNCIONES ============

    # Funcion para obtener y mostrar información (SIMPLIFICADA)
    function Actualizar-Monitor {
        try {
            # 1. OBTENER USO GLOBAL DE CPU
            $cpuUsage = Get-WmiObject Win32_Processor | Measure-Object -Property LoadPercentage -Average | Select-Object -ExpandProperty Average
            if ($cpuUsage -gt 100) { $cpuUsage = 100 }
            if ($cpuUsage -lt 0) { $cpuUsage = 0 }
            
            $barraCPU.Value = [int]$cpuUsage
            $labelPorcentajeCPU.Text = "$([math]::Round($cpuUsage, 1))%"
            
            # Color según uso
            if ($cpuUsage -gt 80) {
                $barraCPU.ForeColor = [System.Drawing.Color]::Red
                $labelPorcentajeCPU.ForeColor = [System.Drawing.Color]::Red
            } elseif ($cpuUsage -gt 60) {
                $barraCPU.ForeColor = [System.Drawing.Color]::Orange
                $labelPorcentajeCPU.ForeColor = [System.Drawing.Color]::Orange
            } else {
                $barraCPU.ForeColor = [System.Drawing.Color]::Green
                $labelPorcentajeCPU.ForeColor = [System.Drawing.Color]::DarkGreen
            }
            
            # 2. OBTENER USO DE MEMORIA RAM
            $memInfo = Get-WmiObject Win32_OperatingSystem
            $totalRAM = [math]::Round($memInfo.TotalVisibleMemorySize / 1MB, 2)
            $freeRAM = [math]::Round($memInfo.FreePhysicalMemory / 1MB, 2)
            $usedRAM = $totalRAM - $freeRAM
            $ramPercent = [math]::Round(($usedRAM / $totalRAM) * 100, 1)
            
            $barraRAM.Value = [int]$ramPercent
            $labelPorcentajeRAM.Text = "$ramPercent%"
            $labelInfoRAM.Text = "Usado: ${usedRAM}GB / Total: ${totalRAM}GB | Libre: ${freeRAM}GB"
            
            # Color según uso RAM
            if ($ramPercent -gt 85) {
                $barraRAM.ForeColor = [System.Drawing.Color]::Red
                $labelPorcentajeRAM.ForeColor = [System.Drawing.Color]::Red
            } elseif ($ramPercent -gt 70) {
                $barraRAM.ForeColor = [System.Drawing.Color]::Orange
                $labelPorcentajeRAM.ForeColor = [System.Drawing.Color]::Orange
            } else {
                $barraRAM.ForeColor = [System.Drawing.Color]::Green
                $labelPorcentajeRAM.ForeColor = [System.Drawing.Color]::DarkGreen
            }
            
            # 3. OBTENER INFORMACIÓN DE DISCOS
            $panelDiscos.Controls.Clear()
            
            $discos = Get-WmiObject Win32_LogicalDisk | Where-Object { $_.DriveType -eq 3 -and $_.Size -gt 0 }
            $yPos = 10
            
            foreach ($disco in $discos) {
                $driveLetter = $disco.DeviceID
                $sizeGB = [math]::Round($disco.Size / 1GB, 2)
                $freeGB = [math]::Round($disco.FreeSpace / 1GB, 2)
                $usedGB = $sizeGB - $freeGB
                $percent = [math]::Round(($usedGB / $sizeGB) * 100, 1)
                
                # Etiqueta unidad
                $labelDrive = New-Object System.Windows.Forms.Label
                $labelDrive.Text = "$driveLetter"
                $labelDrive.Font = New-Object System.Drawing.Font("Arial", 9, [System.Drawing.FontStyle]::Bold)
                $labelDrive.ForeColor = [System.Drawing.Color]::Black
                $labelDrive.Size = New-Object System.Drawing.Size(30, 20)
                $labelDrive.Location = New-Object System.Drawing.Point(10, $yPos)
                $panelDiscos.Controls.Add($labelDrive)
                
                # Barra progreso disco
                $barraDisco = New-Object System.Windows.Forms.ProgressBar
                $barraDisco.Size = New-Object System.Drawing.Size(300, 20)
                $barraDisco.Location = New-Object System.Drawing.Point(50, $yPos)
                $barraDisco.Value = [int]$percent
                
                # Color según espacio libre
                if ($percent -gt 90) {
                    $barraDisco.ForeColor = [System.Drawing.Color]::Red
                } elseif ($percent -gt 75) {
                    $barraDisco.ForeColor = [System.Drawing.Color]::Orange
                } else {
                    $barraDisco.ForeColor = [System.Drawing.Color]::Green
                }
                
                $panelDiscos.Controls.Add($barraDisco)
                
                # Etiqueta porcentaje
                $labelDiskPercent = New-Object System.Windows.Forms.Label
                $labelDiskPercent.Text = "$percent%"
                $labelDiskPercent.Font = New-Object System.Drawing.Font("Arial", 8, [System.Drawing.FontStyle]::Regular)
                $labelDiskPercent.ForeColor = [System.Drawing.Color]::Black
                $labelDiskPercent.Size = New-Object System.Drawing.Size(40, 20)
                $labelDiskPercent.Location = New-Object System.Drawing.Point(360, $yPos)
                $panelDiscos.Controls.Add($labelDiskPercent)
                
                # Info tamaño
                $labelDiskInfo = New-Object System.Windows.Forms.Label
                $labelDiskInfo.Text = "${usedGB}GB/${sizeGB}GB"
                $labelDiskInfo.Font = New-Object System.Drawing.Font("Arial", 8, [System.Drawing.FontStyle]::Regular)
                $labelDiskInfo.ForeColor = [System.Drawing.Color]::DarkSlateGray
                $labelDiskInfo.Size = New-Object System.Drawing.Size(100, 20)
                $labelDiskInfo.Location = New-Object System.Drawing.Point(410, $yPos)
                $panelDiscos.Controls.Add($labelDiskInfo)
                
                $yPos += 25
            }
            
            # 4. OBTENER TOP 5 PROCESOS - VERSIÓN MEJORADA
$listBoxProcesos.Items.Clear()
$listBoxProcesos.Items.Add("PROCESO" + " " * 35 + "CPU%   MEMORIA   ID")
$listBoxProcesos.Items.Add("-" * 70)

# Filtrar SOLO procesos con > 0.1% de CPU
$topProcesos = Get-WmiObject Win32_PerfFormattedData_PerfProc_Process | 
    Where-Object { 
        $_.Name -notmatch '^(_Total|Idle|System)$' -and
        $_.PercentProcessorTime -gt 0.1  # Solo > 0.1%
    } |
    Sort-Object PercentProcessorTime -Descending | 
    Select-Object -First 5

if ($topProcesos.Count -gt 0) {
    foreach ($proc in $topProcesos) {
        $procName = $proc.Name
        $cpuPercent = [math]::Round($proc.PercentProcessorTime, 1)
        
        # Obtener memoria
        $processInfo = Get-Process -Id $proc.IDProcess -ErrorAction SilentlyContinue
        if ($processInfo) {
            $memMB = [math]::Round($processInfo.WorkingSet / 1MB, 1)
            $procID = $processInfo.Id
        } else {
            $memMB = 0
            $procID = $proc.IDProcess
        }
        
        $procNameDisplay = $procName.PadRight(35).Substring(0, [math]::Min(35, $procName.Length))
        $linea = "$procNameDisplay $cpuPercent%".PadRight(45) + "${memMB}MB".PadRight(10) + $procID
        $listBoxProcesos.Items.Add($linea)
    }
} else {
    # Si no hay procesos usando CPU
    $listBoxProcesos.Items.Add("No hay procesos usando CPU significativamente")
    $listBoxProcesos.Items.Add("(CPU está en reposo o bajo uso)")
}
            
        } catch {
            $listBoxProcesos.Items.Clear()
            $listBoxProcesos.Items.Add("Error: $($_.Exception.Message)")
        }
    }

    # ============ TIMER PARA ACTUALIZACIÓN AUTOMÁTICA ============

    $timer = New-Object System.Windows.Forms.Timer
    $timer.Interval = 3000
    $timer.Add_Tick({
        Actualizar-Monitor
    })

    # ============ EVENTOS ============

    # Evento botón Actualizar
    $btnActualizar.Add_Click({
        Actualizar-Monitor
    })

    # Evento botón Cerrar
    $btnCerrar.Add_Click({
        $timer.Stop()
        $formMonitor.Close()
    })

    # Evento al cargar formulario
    $formMonitor.Add_Shown({
        Actualizar-Monitor
        $timer.Start()
    })

    # Evento al cerrar formulario
    $formMonitor.Add_FormClosing({
        $timer.Stop()
    })

    # ============ MOSTRAR FORMULARIO ============

    [void]$formMonitor.ShowDialog()
}