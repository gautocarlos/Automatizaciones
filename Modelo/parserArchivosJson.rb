  require 'json'
  require './Configuracion.rb'
  class ParserArchivosJson
    attr_accessor
      :configuracion
    def initialize(configuracion)
      self.setConfiguracion(configuracion)
    end
    # Getters
    def getConfiguracion()
      return @configuracion
    end
    # Setters
    def setConfiguracion(configuracion)
      @configuracion = configuracion
    end
    #
    def leerParsearJson(rutaJson)
      archivoJson = open(rutaJson)
      return JSON.parse(archivoJson.read)
    end
    # Devuelve luego de realizar el parseo el objeto con el contenido del archivo altaUsuario.json
    def getInputsAltaUsuarioJson(posicion)
      archivoJson = self.getConfiguracion().getRutaJSON() + 'altaUsuario.json'
      return self.leerParsearJson(archivoJson)['usuario'][posicion]['inputs']
    end
    # Devuelve luego de realizar el parseo el objeto con el contenido del archivo altaUsuario.json
    def getBandboxesAltaUsuarioJson(posicion)
      archivoJson = self.getConfiguracion().getRutaJSON() + 'altaUsuario.json'
      return self.leerParsearJson(archivoJson)['usuario'][posicion]['bandboxes']
    end
    # Devuelve luego de realizar el parseo el objeto con el contenido del archivo expediente.json
    def getExpedienteJson(posicion)
      archivoJson = self.getConfiguracion().getRutaJSON() + 'expediente.json'
      return self.leerParsearJson(archivoJson)
    end
    # Devuelve luego de realizar el parseo el objeto con el contenido del archivo documentoImportado.json
    def getDocumentoImportadoJson(posicion)
      archivoJson = self.getConfiguracion().getRutaJSON() + 'documentoImportado.json'
      return self.leerParsearJson(archivoJson)
    end
    # Devuelve luego de realizar el parseo el objeto con el contenido del archivo documentoImportadoTemplate.json
    def getDocumentoImportadoTemplateJson(posicion)
      archivoJson = self.getConfiguracion().getRutaJSON() + 'documentoImportadoTemplate.json'
      return self.leerParsearJson(archivoJson)
    end
    # Devuelve luego de realizar el parseo el objeto con el contenido del archivo documentoImportadoTemplate.json
    def getDocumentoTemplateJson(posicion)
      archivoJson = self.getConfiguracion().getRutaJSON() + 'documentoTemplate.json'
      return self.leerParsearJson(archivoJson)
    end
    # Devuelve luego de realizar el parseo el objeto con el contenido del archivo documentoLibre.json
    def getDocumentoLibreJson(posicion)
      archivoJson = self.getConfiguracion().getRutaJSON() + 'documentoLibre.json'
      return self.leerParsearJson(archivoJson)
    end

  end
#############################################################################