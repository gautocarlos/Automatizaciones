  # Clase que se utiliza para acceder a los elementos HTML
  require 'watir-webdriver'
  require 'logger'
  require 'json'
  require 'htmlentities'
  require './elementosHTML.rb'
  #require './elementosHTMLFactory.rb'
  #require '../constantes.rb'
  class ElementoI < ElementosHTML
    attr_accessor

    # Métodos
    def realizarClick(clase)
        self.getBrowser().i(:class => clase).click
    end
    #
    # Se realiza click sobre un elemento cualquiera según su clase y su posición
    def realizarClick(posicion, clase)
      self.getBrowser().is(:class => clase)[posicion].click
    end
    #
    # Se realiza click sobre un elemento cualquiera según su clase y su posición
    def esperarRealizarClick(posicion, clase)
      Watir::Wait.until { self.getBrowser().is(:class => clase)[posicion].exists?}
      self.getBrowser().is(:class => clase)[posicion].click
    end
    #
    # Se realiza click sobre un elemento cualquiera según su clase y su posición
    def realizarClickEsperar(posicion, clase)
      self.getBrowser().is(:class => clase)[posicion].click
      self.getBrowser().is(:class => clase)[posicion].wait_while_present
    end
    # Se realiza click sobre un elemento cualquiera según su clase y su posición
    def esperarRealizarClickEsperar(posicion, clase)
      Watir::Wait.until { self.getBrowser().is(:class => clase)[posicion].exists?}
      self.getBrowser().is(:class => clase)[posicion].click
      self.getBrowser().is(:class => clase)[posicion].wait_while_present
    end
    #
    # def esperarCompletarBandboxesDeLista(texto, posicion, lista, fabrica)
    #   begin
    #     Watir::Wait.until { lista[posicion].exists?}        
    #     lista[posicion].click
    #     #fabrica.getElemento('i')
    #     self.completarBandbox(texto, posicion, lista, fabrica)
    #     puts "4"
    #   rescue
    #     puts "Error en: esperarCompletarBandboxesDeLista(#{texto}, #{posicion}, #{lista}) - Elemento no visible o no existente."
    #   end
    # end
    # #
    # def completarBandbox(texto, posicion, lista, fabrica)
    #   claseZ_BANDPOPUP = Z_BANDPOPUP
    #   claseInputsSimples = Z_TEXTBOX
    #   #claseBanbox = Z_BANDBOX
    #   posicion_BANDPOPUP = 10
    #   begin
    #     puts "completarBandbox"
    #     puts "texto :: #{texto}"
    #     puts "posicion :: #{posicion}"
    #     puts "lista :: #{lista}"
    #     puts "lista.size :: #{lista.size}"
    #     puts "lista[posicion] :: #{lista[posicion]}"
    #     puts "-------A-----"
    #     divBandBox = fabrica.getElemento('div')
    #     puts "-------B-----"
    #     divBandBox.esperarObtenerElemento(claseZ_BANDPOPUP, posicion_BANDPOPUP)
    #     puts "-------C-----"
    #     listaInputsZ_textbox = tbody.retornarElementosInputContenidos(claseInputsSimples)
    #     puts "-------D-----"
    #     puts "::: listaInputsZ_textbox.size ::: #{listaInputsZ_textbox.size}"
    #     puts "1: completarBandbox"
    #     lista[posicion].set texto
    #     puts "1: completarBandbox"
    #     lista[posicion].fire_event :blur
    #     puts "2: completarBandbox"
    #   rescue
    #     puts "Error en: completarBandbox(#{texto}, #{posicion}, #{lista}) -"
    #   end
    # end
  end