  # Clase que se utiliza para acceder a los elementos HTML
  require 'watir-webdriver'
  require 'logger'
  require 'json'
  require 'htmlentities'
  #require './elementosHTMLFactory.rb'
  #require '../constantes.rb'
  class ElementosHTML
    attr_accessor
      :browser
      :siMismo
      #:elementosHTMLFactory
    # Contructor
    #def initialize(browser, elementosHTMLFactory)
    #  self.setBrowser(browser)
    #  self.setElementosHTMLFactory(elementosHTMLFactory)
    #end
    def initialize(browser)
      self.setBrowser(browser)
    end
    # Getters
    def getBrowser()
      return @browser
    end
    def getSiMismo()
      return @siMismo
    end
    #def getElementosHTMLFactory()
    #  return @elementosHTMLFactory
    #end
    # Setters
    def setBrowser(browser)
      @browser = browser
    end
    def setSiMismo(siMismo)
      @siMismo = siMismo
    end
    #def setElementosHTMLFactory(elementosHTMLFactory)
    #  @elementosHTMLFactory = elementosHTMLFactory
    #end
    # Métodos
    def realizarClick(clase)
        self.getBrowser().element(:class => clase).click
    end
    #
    # Se realiza click sobre un elemento cualquiera según su clase y su posición
    def realizarClick(posicion, clase)
      self.getBrowser().elements(:class => clase)[posicion].click
    end
    #
    # Se realiza click sobre un elemento cualquiera según su clase y su posición
    def esperarRealizarClick(posicion, clase)
      Watir::Wait.until { self.getBrowser().elements(:class => clase)[posicion].exists?}
      self.getBrowser().elements(:class => clase)[posicion].click
    end
    #
    # Se realiza click sobre un elemento cualquiera según su clase y su posición
    def realizarClickEsperar(posicion, clase)
      self.getBrowser().elements(:class => clase)[posicion].click
      self.getBrowser().elements(:class => clase)[posicion].wait_while_present
    end
    # Se realiza click sobre un elemento cualquiera según su clase y su posición
    def esperarRealizarClickEsperar(posicion, clase)
      Watir::Wait.until { self.getBrowser().elements(:class => clase)[posicion].exists?}
      self.getBrowser().elements(:class => clase)[posicion].click
      self.getBrowser().elements(:class => clase)[posicion].wait_while_present
    end
  end