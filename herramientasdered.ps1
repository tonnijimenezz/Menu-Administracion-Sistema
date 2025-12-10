# Herramientasdered.ps1
# Herramientas esenciales de red

function Mostrar-HerramientasRed {
    # Crear formulario principal
    $formHerramientasRed = New-Object System.Windows.Forms.Form
    $formHerramientasRed.Text = "Herramientas de Red"
    $formHerramientasRed.Size = New-Object System.Drawing.Size(700, 600)
    $formHerramientasRed.StartPosition = "CenterScreen"
    $formHerramientasRed.BackColor = [System.Drawing.Color]::White
    $formHerramientasRed.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedDialog
    $formHerramientasRed.MaximizeBox = $false
    $formHerramientasRed.MinimizeBox = $false

    # Panel principal
    $panelPrincipal = New-Object System.Windows.Forms.Panel
    $panelPrincipal.Location = New-Object System.Drawing.Point(10, 10)
    $panelPrincipal.Size = New-Object System.Drawing.Size(670, 540)
    $panelPrincipal.BackColor = [System.Drawing.Color]::White
    $formHerramientasRed.Controls.Add($panelPrincipal)

    # Titulo
    $labelTitulo = New-Object System.Windows.Forms.Label
    $labelTitulo.Text = "HERRAMIENTAS DE RED ESENCIALES"
    $labelTitulo.Font = New-Object System.Drawing.Font("Arial", 14, [System.Drawing.FontStyle]::Bold)
    $labelTitulo.ForeColor = [System.Drawing.Color]::DarkBlue
    $labelTitulo.Size = New-Object System.Drawing.Size(650, 30)
    $labelTitulo.Location = New-Object System.Drawing.Point(10, 10)
    $labelTitulo.TextAlign = [System.Drawing.ContentAlignment]::MiddleCenter
    $panelPrincipal.Controls.Add($labelTitulo)

    # Descripcion
    $labelDesc = New-Object System.Windows.Forms.Label
    $labelDesc.Text = "Seleccione una herramienta:"
    $labelDesc.Font = New-Object System.Drawing.Font("Arial", 10, [System.Drawing.FontStyle]::Regular)
    $labelDesc.ForeColor = [System.Drawing.Color]::Black
    $labelDesc.Size = New-Object System.Drawing.Size(400, 25)
    $labelDesc.Location = New-Object System.Drawing.Point(20, 50)
    $panelPrincipal.Controls.Add($labelDesc)

    # Area de texto para resultados
    $textBoxResultados = New-Object System.Windows.Forms.TextBox
    $textBoxResultados.Multiline = $true
    $textBoxResultados.ScrollBars = "Vertical"
    $textBoxResultados.Font = New-Object System.Drawing.Font("Consolas", 9, [System.Drawing.FontStyle]::Regular)
    $textBoxResultados.Size = New-Object System.Drawing.Size(630, 220)
    $textBoxResultados.Location = New-Object System.Drawing.Point(20, 230)
    $textBoxResultados.BackColor = [System.Drawing.Color]::Black
    $textBoxResultados.ForeColor = [System.Drawing.Color]::Lime
    $textBoxResultados.ReadOnly = $true
    $panelPrincipal.Controls.Add($textBoxResultados)

    # Barra de progreso
    $barraProgreso = New-Object System.Windows.Forms.ProgressBar
    $barraProgreso.Size = New-Object System.Drawing.Size(630, 20)
    $barraProgreso.Location = New-Object System.Drawing.Point(20, 510)
    $barraProgreso.Style = [System.Windows.Forms.ProgressBarStyle]::Continuous
    $barraProgreso.Visible = $false
    $panelPrincipal.Controls.Add($barraProgreso)

    # Etiqueta de estado
    $labelEstado = New-Object System.Windows.Forms.Label
    $labelEstado.Text = "Listo para diagnosticar o reparar la red"
    $labelEstado.Font = New-Object System.Drawing.Font("Arial", 9, [System.Drawing.FontStyle]::Regular)
    $labelEstado.ForeColor = [System.Drawing.Color]::DarkGreen
    $labelEstado.Size = New-Object System.Drawing.Size(630, 20)
    $labelEstado.Location = New-Object System.Drawing.Point(20, 535)
    $labelEstado.TextAlign = [System.Drawing.ContentAlignment]::MiddleLeft
    $panelPrincipal.Controls.Add($labelEstado)

    # ============ BOTONES PRINCIPALES ============

    # Boton 1: DIAGNOSTICO COMPLETO 
    $btnDiagnostico = New-Object System.Windows.Forms.Button
    $btnDiagnostico.Text = "1. DIAGNOSTICO COMPLETO DE RED"
    $btnDiagnostico.Font = New-Object System.Drawing.Font("Arial", 10, [System.Drawing.FontStyle]::Bold)
    $btnDiagnostico.ForeColor = [System.Drawing.Color]::White
    $btnDiagnostico.Size = New-Object System.Drawing.Size(630, 50)
    $btnDiagnostico.Location = New-Object System.Drawing.Point(20, 90)
    $btnDiagnostico.BackColor = [System.Drawing.Color]::RoyalBlue
    $btnDiagnostico.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
    $panelPrincipal.Controls.Add($btnDiagnostico)

    # Boton 2: REPARACION RAPIDA
    $btnReparacion = New-Object System.Windows.Forms.Button
    $btnReparacion.Text = "2. REPARACION RAPIDA DE CONEXION"
    $btnReparacion.Font = New-Object System.Drawing.Font("Arial", 10, [System.Drawing.FontStyle]::Bold)
    $btnReparacion.ForeColor = [System.Drawing.Color]::White
    $btnReparacion.Size = New-Object System.Drawing.Size(630, 50)
    $btnReparacion.Location = New-Object System.Drawing.Point(20, 150)
    $btnReparacion.BackColor = [System.Drawing.Color]::DarkOrange
    $btnReparacion.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
    $panelPrincipal.Controls.Add($btnReparacion)



    # ============ FUNCIONES PRINCIPALES ============

    # Funcion para mostrar progreso
    function Actualizar-Progreso {
        param([string]$mensaje, [int]$porcentaje = -1)
        
        if ($porcentaje -ge 0) {
            $barraProgreso.Value = $porcentaje
            $barraProgreso.Visible = $true
        }
        
        $labelEstado.Text = $mensaje
        $textBoxResultados.AppendText("$(Get-Date -Format 'HH:mm:ss') - $mensaje`r`n")
        $textBoxResultados.ScrollToCaret()
        $formHerramientasRed.Refresh()
    }

    # Funcion para agregar resultado
    function Agregar-Resultado {
        param([string]$texto, [string]$tipo = "info")
        
        # Usar simbolos simples
        $simbolo = switch ($tipo) {
            "exito" { "[OK]" }
            "error" { "[ERROR]" }
            "advertencia" { "[ADVERTENCIA]" }
            "info" { "[INFO]" }
            default { "•" }
        }
        
        $textBoxResultados.AppendText("$simbolo $texto`r`n")
    }

    # ============ OPCION 1: DIAGNOSTICO COMPLETO ============

    function Iniciar-DiagnosticoRed {
        $textBoxResultados.Clear()
        Actualizar-Progreso "Iniciando diagnostico completo de red..."
        $barraProgreso.Style = [System.Windows.Forms.ProgressBarStyle]::Marquee
        $barraProgreso.Visible = $true
        
        try {
            # Encabezado
            $textBoxResultados.AppendText("=" * 70 + "`r`n")
            $textBoxResultados.AppendText("DIAGNOSTICO COMPLETO DE RED`r`n")
            $textBoxResultados.AppendText("Fecha: $(Get-Date -Format 'dd/MM/yyyy HH:mm:ss')`r`n")
            $textBoxResultados.AppendText("=" * 70 + "`r`n`r`n")
            
            # 1. OBTENER CONFIGURACION DE RED
            Actualizar-Progreso "Obteniendo configuracion de red..."
            $textBoxResultados.AppendText("CONFIGURACION DE RED:`r`n")
            $textBoxResultados.AppendText("-" * 40 + "`r`n")
            
            # Obtener informacion de red en espanol
            $configuracionIP = ipconfig /all
            foreach ($linea in $configuracionIP) {
                if ($linea -match "Adaptador|IPv4|Puerta|Servidores DNS|Direccion fisica") {
                    $textBoxResultados.AppendText("$linea`r`n")
                }
            }
            
            # Extraer puerta de enlace (gateway)
            $puertaEnlace = ""
            foreach ($linea in $configuracionIP) {
                if ($linea -match "Puerta de enlace") {
                    $puertaEnlace = $linea -replace ".*Puerta de enlace.*: ", ""
                    $puertaEnlace = $puertaEnlace.Trim()
                    break
                }
            }
            
            if (-not $puertaEnlace) {
                $puertaEnlace = "8.8.8.8"  # DNS de Google como respaldo
            }
            
            # 2. PING AL ROUTER/PUERTA DE ENLACE
            Actualizar-Progreso "Probando conexion local (ping al router)..."
            $textBoxResultados.AppendText("`r`nCONEXION LOCAL:`r`n")
            $textBoxResultados.AppendText("-" * 40 + "`r`n")
            
            $resultadoPing = ping $puertaEnlace -n 2
            $pingExitoso = $resultadoPing -match "TTL="
            
            if ($pingExitoso) {
                Agregar-Resultado "Conexion al router ($puertaEnlace): OK" -tipo "exito"
            } else {
                Agregar-Resultado "Conexion al router ($puertaEnlace): FALLIDA" -tipo "error"
                Agregar-Resultado "Posible problema con cable/WiFi o router apagado" -tipo "advertencia"
            }
            
            # 3. PING A INTERNET (DNS de Google)
            Actualizar-Progreso "Probando conexion a internet..."
            $textBoxResultados.AppendText("`r`nCONEXION A INTERNET:`r`n")
            $textBoxResultados.AppendText("-" * 40 + "`r`n")
            
            $pingInternet = ping 8.8.8.8 -n 2
            $internetExitoso = $pingInternet -match "TTL="
            
            if ($internetExitoso) {
                Agregar-Resultado "Conexion a internet (8.8.8.8): OK" -tipo "exito"
            } else {
                Agregar-Resultado "Conexion a internet (8.8.8.8): FALLIDA" -tipo "error"
                Agregar-Resultado "Posible problema del proveedor de internet" -tipo "advertencia"
            }
            
            # 4. PING A GOOGLE (DNS)
            Actualizar-Progreso "Probando resolucion DNS..."
            $pingDNS = ping google.com -n 2
            $dnsExitoso = $pingDNS -match "TTL="
            
            if ($dnsExitoso) {
                Agregar-Resultado "Resolucion DNS (google.com): OK" -tipo "exito"
            } else {
                Agregar-Resultado "Resolucion DNS (google.com): FALLIDA" -tipo "error"
                if ($internetExitoso) {
                    Agregar-Resultado "Internet funciona pero DNS no. Use REPARACION RAPIDA" -tipo "advertencia"
                }
            }
            
            # 5. OBTENER IP PUBLICA
            Actualizar-Progreso "Obteniendo IP publica..."
            $textBoxResultados.AppendText("`r`nINFORMACION ADICIONAL:`r`n")
            $textBoxResultados.AppendText("-" * 40 + "`r`n")
            
            try {
                # Intentar obtener IP publica
                $clienteWeb = New-Object System.Net.WebClient
                $ipPublica = $clienteWeb.DownloadString("https://api.ipify.org")
                Agregar-Resultado "IP Publica: $ipPublica" -tipo "info"
            } catch {
                Agregar-Resultado "IP Publica: No se pudo obtener (sin internet o bloqueado)" -tipo "advertencia"
            }
            
            # RESUMEN
            $textBoxResultados.AppendText("`r`n" + "=" * 70 + "`r`n")
            $textBoxResultados.AppendText("RESUMEN DEL DIAGNOSTICO:`r`n")
            $textBoxResultados.AppendText("=" * 70 + "`r`n")
            
            if ($pingExitoso -and $internetExitoso -and $dnsExitoso) {
                Agregar-Resultado "TODAS LAS PRUEBAS PASARON - La red funciona correctamente" -tipo "exito"
                Agregar-Resultado "Recomendacion: Ninguna accion necesaria" -tipo "exito"
            } elseif ($pingExitoso -and $internetExitoso -and (-not $dnsExitoso)) {
                Agregar-Resultado "PROBLEMA CON DNS - Internet funciona pero DNS no" -tipo "advertencia"
                Agregar-Resultado "Solucion: Use 'REPARACION RAPIDA DE CONEXION'" -tipo "advertencia"
            } elseif ($pingExitoso -and (-not $internetExitoso)) {
                Agregar-Resultado "SIN INTERNET - Red local OK pero sin salida a internet" -tipo "error"
                Agregar-Resultado "Posible causa: Problema del proveedor o router mal configurado" -tipo "error"
            } else {
                Agregar-Resultado "SIN CONEXION LOCAL - Problema con router/cable/WiFi" -tipo "error"
                Agregar-Resultado "Solucion: Revise conexiones fisicas y reinicie router" -tipo "error"
            }
            
            Actualizar-Progreso "Diagnostico completado. Revise resultados arriba."
            
        } catch {
            Actualizar-Progreso "Error durante el diagnostico: $($_.Exception.Message)"
            Agregar-Resultado "Error: $($_.Exception.Message)" -tipo "error"
        }
        
        $barraProgreso.Visible = $false
    }

    # ============ OPCION 2: REPARACION RAPIDA ============

    function Iniciar-ReparacionRed {
        # Confirmacion
        $confirmar = [System.Windows.Forms.MessageBox]::Show(
            "¿REPARAR PROBLEMAS DE RED?`r`n`r`n" +
            "Esta operacion realizara:`r`n" +
            "1. Limpiar cache DNS (borrar cache DNS)`r`n" +
            "2. Reiniciar Winsock (reiniciar sockets)`r`n" +
            "3. Liberar y renovar IP`r`n" +
            "4. Limpiar cache ARP`r`n`r`n" +
            "¿Desea continuar?",
            "Reparacion Rapida de Red",
            [System.Windows.Forms.MessageBoxButtons]::YesNo,
            [System.Windows.Forms.MessageBoxIcon]::Information
        )
        
        if ($confirmar -eq "Yes") {
            $textBoxResultados.Clear()
            Actualizar-Progreso "Iniciando reparacion rapida de red..."
            $barraProgreso.Style = [System.Windows.Forms.ProgressBarStyle]::Marquee
            $barraProgreso.Visible = $true
            
            try {
                $textBoxResultados.AppendText("=" * 70 + "`r`n")
                $textBoxResultados.AppendText("REPARACION RAPIDA DE RED`r`n")
                $textBoxResultados.AppendText("Fecha: $(Get-Date -Format 'dd/MM/yyyy HH:mm:ss')`r`n")
                $textBoxResultados.AppendText("=" * 70 + "`r`n`r`n")
                
                # 1. LIMPIAR CACHE DNS
                Actualizar-Progreso "Paso 1/4: Limpiando cache DNS..."
                Agregar-Resultado "Ejecutando: ipconfig /flushdns" -tipo "info"
                $resultadoDNS = ipconfig /flushdns 2>&1
                if ($LASTEXITCODE -eq 0) {
                    Agregar-Resultado "Cache DNS limpiado correctamente" -tipo "exito"
                } else {
                    Agregar-Resultado "Error limpiando cache DNS" -tipo "error"
                }
                
                # 2. REINICIAR WINSOCK
                Actualizar-Progreso "Paso 2/4: Reiniciando Winsock..."
                Agregar-Resultado "Ejecutando: netsh winsock reset" -tipo "info"
                $resultadoWinsock = netsh winsock reset 2>&1
                if ($LASTEXITCODE -eq 0) {
                    Agregar-Resultado "Winsock reiniciado correctamente" -tipo "exito"
                    Agregar-Resultado "NOTA: Reinicie el equipo para cambios completos" -tipo "advertencia"
                } else {
                    Agregar-Resultado "Error reiniciando Winsock" -tipo "error"
                }
                
                # 3. LIBERAR Y RENOVAR IP
                Actualizar-Progreso "Paso 3/4: Liberando y renovando IP..."
                Agregar-Resultado "Ejecutando: ipconfig /release" -tipo "info"
                ipconfig /release 2>&1 | Out-Null
                Start-Sleep -Seconds 2
                
                Agregar-Resultado "Ejecutando: ipconfig /renew" -tipo "info"
                ipconfig /renew 2>&1 | Out-Null
                Start-Sleep -Seconds 3
                
                # Verificar nueva IP
                $nuevaConfigIP = ipconfig
                $lineaNuevaIP = $nuevaConfigIP | Select-String "IPv4"
                if ($lineaNuevaIP) {
                    $nuevaIP = ($lineaNuevaIP | Select-Object -First 1).ToString() -replace ".*: ", ""
                    Agregar-Resultado "IP renovada: $nuevaIP" -tipo "exito"
                } else {
                    Agregar-Resultado "Advertencia: No se pudo renovar IP automaticamente" -tipo "advertencia"
                }
                
                # 4. LIMPIAR CACHE ARP
                Actualizar-Progreso "Paso 4/4: Limpiando cache ARP..."
                Agregar-Resultado "Ejecutando: arp -d *" -tipo "info"
                arp -d * 2>&1 | Out-Null
                Agregar-Resultado "Cache ARP limpiado" -tipo "exito"
                
                # RESUMEN
                $textBoxResultados.AppendText("`r`n" + "=" * 70 + "`r`n")
                $textBoxResultados.AppendText("REPARACION COMPLETADA`r`n")
                $textBoxResultados.AppendText("=" * 70 + "`r`n")
                
                Agregar-Resultado "Todas las reparaciones se ejecutaron correctamente" -tipo "exito"
                Agregar-Resultado "Recomendaciones:" -tipo "info"
                Agregar-Resultado "  1. Reinicie el navegador web" -tipo "info"
                Agregar-Resultado "  2. Si persisten problemas, reinicie el equipo" -tipo "info"
                Agregar-Resultado "  3. Pruebe acceder a paginas web que antes fallaban" -tipo "info"
                
                Actualizar-Progreso "Reparacion completada. Pruebe su conexion."
                
                # Mostrar mensaje final
                [System.Windows.Forms.MessageBox]::Show(
                    "Reparacion de red completada.`r`n`r`n" +
                    "Acciones realizadas:`r`n" +
                    "• Cache DNS limpiado`r`n" +
                    "• Winsock reiniciado`r`n" +
                    "• IP liberada y renovada`r`n" +
                    "• Cache ARP limpiado`r`n`r`n" +
                    "Reinicie su navegador y pruebe la conexion.",
                    "Reparacion Exitosa",
                    [System.Windows.Forms.MessageBoxButtons]::OK,
                    [System.Windows.Forms.MessageBoxIcon]::Information
                )
                
            } catch {
                Actualizar-Progreso "Error durante la reparacion: $($_.Exception.Message)"
                Agregar-Resultado "Error: $($_.Exception.Message)" -tipo "error"
                
                [System.Windows.Forms.MessageBox]::Show(
                    "Error durante la reparacion: $($_.Exception.Message)`r`n" +
                    "Intente ejecutar los comandos manualmente como administrador.",
                    "Error en Reparacion",
                    [System.Windows.Forms.MessageBoxButtons]::OK,
                    [System.Windows.Forms.MessageBoxIcon]::Error
                )
            }
            
            $barraProgreso.Visible = $false
            $barraProgreso.Style = [System.Windows.Forms.ProgressBarStyle]::Continuous
            
        } else {
            Actualizar-Progreso "Reparacion cancelada por el usuario."
        }
    }

    # ============ EVENTOS DE BOTONES ============

    # Eventos hover para botones
    $botones = @($btnDiagnostico, $btnReparacion)
    
    foreach ($boton in $botones) {
        $boton.Add_MouseEnter({
            $this.BackColor = [System.Drawing.Color]::LightBlue
            $this.Cursor = [System.Windows.Forms.Cursors]::Hand
        })
        $boton.Add_MouseLeave({
            if ($this.Text -match "DIAGNOSTICO") {
                $this.BackColor = [System.Drawing.Color]::RoyalBlue
            } elseif ($this.Text -match "REPARACION") {
                $this.BackColor = [System.Drawing.Color]::DarkOrange
            }
            $this.Cursor = [System.Windows.Forms.Cursors]::Default
        })
    }

    # Evento boton Diagnostico
    $btnDiagnostico.Add_Click({
        Iniciar-DiagnosticoRed
    })

    # Evento boton Reparacion
    $btnReparacion.Add_Click({
        Iniciar-ReparacionRed
    })

  

    # Mostrar formulario
    $formHerramientasRed.Add_Shown({$formHerramientasRed.Activate()})
    [void]$formHerramientasRed.ShowDialog()
}