
  require 'json'
  class Configuracion
    attr_accessor
      :datosJsonConfiguracion
    # GETTERS
    def getJsonConfiguracion()
      return @jsonConfiguracion
    end
    # SETTERS
    def setJsonConfiguracion(jsonConfiguracion)
      @jsonConfiguracion = jsonConfiguracion
    end    
    # 
    def initialize(rutaJsonConfiguracion)
      archivoJsonConfiguracion = open(rutaJsonConfiguracion)
      jsonConfiguracion = archivoJsonConfiguracion.read
      self.setDatosJsonConfiguracion(JSON.parse(jsonConfiguracion))
    end
    # Retorna desde el archivo de configuración la ruta de los archivos JSON a utilizar
    def getRutaJSON()
      return getJsonConfiguracion()["configuraciones"]["rutas"]["rutaJSON"]
    end
    #
    def getRutaLogs()
      return getJsonConfiguracion()["configuraciones"]["rutas"]["rutaLogs"]
    end
    #
    def getRutaScreenshots()
      return getJsonConfiguracion()["configuraciones"]["rutas"]["rutaScreenshots"]
    end
  end
#############################################################################