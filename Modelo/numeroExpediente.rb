# Clase que se utiliza para dar realizar operaciones en Expediente Electrónico
  require 'watir-webdriver'
  require 'logger'
  require 'json'
  require 'Matrix'
  require 'htmlentities'
  #require '../constantes.rb'
  class NumeroExpediente
    attr_accessor
      :browser
      :log
      :tipoActuacion
      :anio
      :numero
      :reparticionActuacion
      :reparticionUsuario
      :numeroCompleto
    #
    def initialize(numeroExpediente)
      numeroExpedienteSplit = numeroExpediente.split('-')
      self.setNumeroCompleto(numeroExpediente)
      self.setTipoActuacion(numeroExpedienteSplit[0])
      self.setAnio(numeroExpedienteSplit[1])
      self.setNumero(numeroExpedienteSplit[2])
      #
      self.setReparticionActuacion(numeroExpedienteSplit[4])
      self.setReparticionUsuario(numeroExpedienteSplit[5])
    end    
    #
    # Getters
    def getBrowser()
      return @browser
    end
    # 
    def getLog()
      return @log
    end
    #
    def getTipoActuacion()
      return @tipoActuacion
    end
    #
    def getAnio()
      return @anio
    end
    #
    def getNumero()
      return @numero
    end
    #
    def getNumeroCompleto()
      return @numeroCompleto
    end
    #
    def getReparticionActuacion()
      return @reparticionActuacion
    end
    # 
    def getReparticionUsuario()
      return @reparticionUsuario
    end
    #
    # Setters
    #
    def setTipoActuacion(tipoActuacion)
      @tipoActuacion = tipoActuacion
    end
    #
    def setAnio(anio)
      @anio = anio
    end
    #
    def setNumero(numero)
      @numero = numero
    end
    #
    def setNumeroCompleto(numeroCompleto)
      @numeroCompleto = numeroCompleto
    end
    #
    def setReparticionActuacion(reparticionActuacion)
      @reparticionActuacion = reparticionActuacion
    end
    # 
    def setReparticionUsuario(reparticionUsuario)
      @reparticionUsuario = reparticionUsuario
    end
    #
    # Métodos
    # Guarda el número del expediente de manera completa y de manera
    def splitNumeroExpediente(numeroExpediente)
      self.initialize(numeroExpediente)
    end
  end