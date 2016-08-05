# Clase para realizar el login a la aplicación ##############################
  # Clase 
  require 'json'
  class Login
    attr_accessor
      :browser
      :rutaJsonConfiguracion
      :modulo
      :usuario
      :password
      :urlModulo
      :rutaScreenshots
      :rutaLogs
      :rutaJSON
   # constructor
    #def initialize(urlModulo, usuario, password)
    #def new(rutaJsonConfiguracion, modulo)
      #@urlModulo = urlModulo
      #@usuario = usuario
      #@password = password
      #puts "Nuevo NEW"
      #self.initialize(rutaJsonConfiguracion, modulo)      
    #end
    def initialize(rutaJsonConfiguracion, modulo)
      #@urlModulo = urlModulo
      #@usuario = usuario
      #@password = password
      #puts "Nuevo initialize"
      self.setModulo(modulo)
      self.setRutaJsonConfiguracion(rutaJsonConfiguracion)
      self.parseJSON()
    end
    # Levanta los datos de login desde un JSON
    def parseJSON()
      #archivoDatosLogin = open("../JSON/usuarioSade.json")
      archivoDatosConf = open(self.getRutaJsonConfiguracion())
      datosConf = archivoDatosConf.read
      datosLoginParseo = JSON.parse(datosConf)
      puts datosLoginParseo
      self.setUsuario(datosLoginParseo["login"]["usuario"]["nombreUsuario"])
      self.setPassword(datosLoginParseo["login"]["usuario"]["password"])
      #-------------#
      #if (self.getModulo() == "GEDO")
      #  self.setUrlModulo(datosLoginParseo["configuraciones"]["urls"]["rutaGEDO"])
      #end
      #if (self.getModulo() == "EE")
      #  self.setUrlModulo(datosLoginParseo["configuraciones"]["urls"]["rutaEE"])
      #end
      #-------------#
      case self.getModulo()
        when 'EE'
          self.setUrlModulo(datosLoginParseo["configuraciones"]["urls"]["rutaEE"])
        when 'EU'
          self.setUrlModulo(datosLoginParseo["configuraciones"]["urls"]["rutaEU"])
        when 'GEDO'
          self.setUrlModulo(datosLoginParseo["configuraciones"]["urls"]["rutaGEDO"])
        else
          return nil
      end
    end
    # Getters
    def getUrlModulo()
      return @urlModulo
    end
    def getUsuario()
      return @usuario
    end
    def getPassword()
      return @password
    end
    def getBrowser()
      return @browser
    end
    def getRutaJsonConfiguracion()
      return @rutaJsonConfiguracion
    end
    #
    def getModulo()
      return @modulo
    end
    # Setters
    def setUrlModulo(urlModulo)
      @urlModulo = urlModulo
    end
    #
    def setModulo(modulo)
      @modulo = modulo
    end
    #
    def setUsuario(usuario)
      @usuario = usuario
    end
    #
    def setPassword(password)
      @password = password
    end
    #
    def setBrowser(browser)
      @browser = browser
    end
    #
    def setRutaJsonConfiguracion(rutaJsonConfiguracion)
      @rutaJsonConfiguracion = rutaJsonConfiguracion
    end
    # Métodos
    # Ingresar al módulo
    def ingresar()
      browser = Watir::Browser.new
      # Se setea el timeout a 90 segundos
      Watir.default_timeout = 90
      browser.goto getUrlModulo()
      Watir::Wait.until { browser.text_field(:id => 'username').exists?}
      #log.info("Inicio Login CAS")  
      # Inicio Login CAS  
      browser.text_field(:id => 'username').set getUsuario()
      browser.text_field(:id => 'password').set getPassword()
      browser.button(:name => 'submit').click
      self.setBrowser(browser)
      #return self
      #return browser
    end
    # Métodos a investigar a futuro para utilizar Chrome
    # Ingresar al módulo
    #def ingresar(browser)
      #browser = Watir::Browser.new
      # Se setea el timeout a 90 segundos
    #  Watir.default_timeout = 90
    #  browser.goto getUrlModulo()
    #  Watir::Wait.until { browser.text_field(:id => 'username').exists?}
      #log.info("Inicio Login CAS")  
      # Inicio Login CAS  
    #  browser.text_field(:id => 'username').set getUsuario()
    #  browser.text_field(:id => 'password').set getPassword()
    #  browser.button(:name => 'submit').click
    #  self.setBrowser(browser)
      #return self
      #return browser
    #end
    # Ingresar al módulo mediante Firefox
    #def ingresarFirefox()
      #browser = Watir::Browser.new
      #self.ingresar(browser)
    #end
    # Ingresar al módulo mediante Chrome
    #def ingresarChrome()
      #browser = Watir::Browser.new :chrome
      #Selenium::WebDriver::Chrome.path = 'C:/chromedriver/chromedriver.exe'
      #driver = Selenium::WebDriver.for :chrome
      #browser = Watir::Browser.new driver
      #self.ingresar(browser)
    #end
  end
#############################################################################