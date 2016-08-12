  require 'json'
  class Configuracion
    attr_accessor
      :jsonConfiguracion
    # GETTERS
    def getJsonConfiguracion()
      return @jsonConfiguracion
    end
    # SETTERS
    def setJsonConfiguracion(jsonConfiguracion)
      @jsonConfiguracion = jsonConfiguracion
    end    
    # Constructor
    def initialize(rutaJsonConfiguracion)
      archivoJsonConfiguracion = open(rutaJsonConfiguracion)
      jsonConfiguracion = archivoJsonConfiguracion.read
      self.setJsonConfiguracion(JSON.parse(jsonConfiguracion))
    end
    # Retorna desde el archivo de configuración la ruta de los archivos JSON a utilizar
    def getRutaJSON()
      return getJsonConfiguracion()["configuraciones"]["rutas"]["rutaJSON"]
    end
    # Retorna desde el archivo de configuración la ruta donde se alojarán los logs
    def getRutaLogs()
      return getJsonConfiguracion()["configuraciones"]["rutas"]["rutaLogs"]
    end
    # Retorna desde el archivo de configuración la ruta donde se alojarán los screenshots
    def getRutaScreenshots()
      return getJsonConfiguracion()["configuraciones"]["rutas"]["rutaScreenshots"]
    end
    # Ruta de acceso a los módulos #
    def getRutaGEDO()
      return getJsonConfiguracion()["urls"]["rutaGEDO"]
    end
    def getRutaEE()
      return getJsonConfiguracion()["urls"]["rutaEE"]
    end
    def getRutaEU()
      return getJsonConfiguracion()["urls"]["rutaEU"]
    end
  end
#############################################################################