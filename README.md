(((EN DESARROLLO)))

Este proyecto es una aplicación gráfica desarrollada en PowerShell que utiliza Windows Forms para crear una interfaz de usuario. 
Proporciona herramientas para el mantenimiento y administración del sistema Windows, organizada en botones para diferentes tareas.

Los lenguajes utilizados han sido:
- Powershell
- Windows Forms (.NET Framework) 

La funciones principales son las siguientes:

- Información del Sistema - Muestra detalles del hardware y software 
- Liberador de Espacio - Limpieza de archivos temporales y optimización de disco
- Reparación de Disco y Sistema - Herramientas de diagnóstico y reparación
- Herramientas de Red - Utilidades para diagnóstico y configuración de red

Estructura 

Explicación de lo que hace cada botón.

1. Información del Sistema
  1.1 Información general del sistema (Nombre dispositivo, Procesador, RAM, Tipo de Sistema, Edición de Windows, Version,
compilación, grupo de trabajo, nombre completo)
  1.2  Información especifica del sistema (Procesador "Modelo, fabricante, nucleos, procesaodres logicos, velocidad, arquitectura",
Memoria ram "total, modulos instalados", Almacenamiento "Disco, Sistema de archivos, Total, libre, usado", Conexión de red "
Adaptadores, MAC, IP, DNS", Bios y Placa base "Nombre del fabricante de la Bios, Placa base, Serial", Tarjetas graficas "Nombre,
ram, resolución, driver)
  1.3 Generar excel con toda la información general
  
2. Liberador de espacio
   2.1 Liberador de Disco (Automaticamente marca todas las casillas del liberador de espacio de windows y lo libera)
   2.2 Limpia la carpeta de archivos temporales del sistema
   2.3 Vacia la papelera de reciclaje

3. Reparación de Disco y Sistema
   3.1 Escanea errores de disco (Escanea y repara archivos del sistema corruptos)
   3.2 Reparar errores de disco (Utiliza chkdsk y repara)
   3.3 Repara archivos del sistema (Escanea todos los archivos protegidos del sistema, compara con versiones originales en
   caché y reemplaza archivos corruptos por versiones buenas)
   3.4 Reparar imagen de Windows (Conecta a Windows Update para descargar archivos, repara la imagen de Windows, prepara el
   sistema para SFC y mantiene el estado de las actualizaciones)

4. Herramientas de Red
   4.1 Diagnostico de red completo (Identificar exactamente dónde está el problema de conexión)
   4.2 Solucionar 4 problemas comunes de red en 1 clic (Cache DNS, Reiniciar Winsock, Liberar y renovar IP y Limpiar ARP)

5. Monitor de Sistema
   CPU: Uso en % con barra de colores (verde/amarillo/rojo)
   RAM: Uso actual con info detallada (GB usados/totales)
   DISCOS: Todas las unidades con barras de espacio
   PROCESOS: Top 5 que más CPU consumen
   ACTUALIZACIÓN AUTOMÁTICA: Cada 3 segundos


Para ejecutar y probar este codigo en powershell ejecutando como administrador escribimos

1 - Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
2 - .\Menu.ps1
