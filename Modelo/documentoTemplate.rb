# Clase que se utiliza para dar de alta un nuevo documento GEDO del tipo libre#
  require 'watir-webdriver'
  require '../constantes.rb'
  require './documento.rb'

  class DocumentoTemplate < Documento
    # Cada tipo de documento deberá implementar su manera de parsear    
    def parseJSON()
      archivoDatosGEDO = open("../JSON/documentoTemplate.json")
      datosGEDO = archivoDatosGEDO.read
      datosGEDOParseo = JSON.parse(datosGEDO)
      self.parseJSONGenerico(datosGEDOParseo)
      self.parseJSONFFCC(datosGEDOParseo)
    end
    # 
    def producirDocumento()
      #Cada documento debe implementar su manera de confeccionar
      self.completarReferencia(self.getReferencia())
      self.completarFFCC()
      self.parsearBotonesProducirDocumento()
    end
  end
###############################################################################