  # Clase que se utiliza para acceder a los elementos HTML
  require 'watir-webdriver'
  require 'logger'
  require 'json'
  require 'htmlentities'
  require './elementosHTML.rb'
  #require '../constantes.rb'
  class ElementoImagen < ElementosHTML
    attr_accessor

    # Métodos
    #
    #
    # Se parsean todos las imagenes que derivan en botones de la pantalla de tramitar expediente
    # Migrar a clase elementoImagen y Deprecar
    # 
    # Se parsean todos las imagenes que derivan en botones de la pantalla de tramitar expediente
    def presionarBotonImagen(nombreBoton, indiceFrame, clase)
      #Obtener todas imagenes que sean botones
      #Watir::Wait.until { (self.getBrowser().div(:class => 'z-window-highlighted-cnt')).exists?}
      #botonesImagenes = (self.getBrowser().divs(:class => 'z-window-highlighted-cnt'))[indiceFrame].images
      #clase = 'z-window-highlighted-cnt' # HARDCODE
      Watir::Wait.until { (self.getBrowser().div(:class => clase)).exists?}
      botonesImagenes = (self.getBrowser().divs(:class => clase))[indiceFrame].images
      botonPresionado = nil
      botonesImagenes.each do |boton|
        rutaImagenSplit = boton.src.split('/')
        nombreImagen = rutaImagenSplit[rutaImagenSplit.length - 1]
        if ((nombreImagen == nombreBoton) && (boton.visible?) && (boton.present?))
          begin
              boton.click
              botonPresionado = boton
              return botonPresionado
          rescue
            puts "Hubo un error al dar click en el botón y/o el mismo no es visible."
          end          
        end
        #
      end
      #return botonPresionado
      return false
    end
    #
    #        
  end