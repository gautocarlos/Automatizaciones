  # Clase que se utiliza para acceder a los elementos HTML
  require 'watir-webdriver'
  require 'logger'
  require 'json'
  # Elementos a fabricar
  require './elementosHTML.rb'
  require './elementoButton.rb'
  require './elementoDIV.rb'
  require './elementoFieldset.rb'
  require './elementoI.rb'
  require './elementoImagen.rb'
  require './elementoINPUT.rb'
  require './elementoINPUTFILE.rb'
  require './elementoLI.rb'
  require './elementoLink.rb'  
  require './elementoSPAN.rb'
  require './elementoTD.rb'
  require './elementoTBODY.rb'
  require './elementoBandbox.rb'
  #
  class ElementosHTMLFactory
    attr_accessor
        :browser
    #
    def initialize(browser)
      self.setBrowser(browser)
    end
    # Getters
    def getBrowser()
      return @browser
    end
    #
    def setBrowser(browser)
      @browser = browser
    end
    # Metódo que fabrica elementos
    def getElemento(elemento)
      browser = getBrowser()
      if(elemento == nil)
        return nil
      end
      #
      elemento.downcase
      # Fabricación de elementos
      case elemento
        when 'button'
          #return ElementoButton.new(browser, self)
          return ElementoButton.new(browser)
        when 'div'
          #return ElementoDIV.new(browser, self)
          return ElementoDIV.new(browser)
        when 'fieldset'
          #return ElementoFieldset.new(browser, self)
          return ElementoFieldset.new(browser)
        when 'i'
          #return ElementoI.new(browser, self)
          return ElementoI.new(browser)
        when 'imagen'
          #return ElementoImagen.new(browser, self)
          return ElementoImagen.new(browser)
        when 'input'
          #return ElementoINPUT.new(browser, self)
          return ElementoINPUT.new(browser)
        when 'inputfile'
          #return ElementoINPUTFILE.new(browser, self)
          return ElementoINPUTFILE.new(browser)
        when 'li'
          #return ElementoLI.new(browser, self)
          return ElementoLI.new(browser)
        when 'link'
          #return ElementoLink.new(browser, self)
          return ElementoLink.new(browser)
        when 'span'
          #return ElementoSPAN.new(browser, self)
          return ElementoSPAN.new(browser)
        when 'td'
          #return ElementoTD.new(browser, self)
          return ElementoTD.new(browser)
        when 'tbody'
          #return ElementoTBODY.new(browser, self)
          return ElementoTBODY.new(browser)
        when 'elementoBandbox'
          #return ElementoTBODY.new(browser, self)
          return ElementoBandbox.new(browser)
        else
          return nil
      end
    end
  end