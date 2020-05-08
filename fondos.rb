#!/usr/bin/ruby
require 'selenium-webdriver'

def setup

    # path to Chrome driver
    Selenium::WebDriver::Chrome.driver_path = "./chromedriver"

    # options
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument('--headless')
    options.add_argument('--disable-gpu')
    
    # capabilities
    caps = Selenium::WebDriver::Remote::Capabilities.chrome
    caps["screen_resolution"] = "600x768"
    caps["record_network"] = "true"
    caps["takesScreenshot"] = "true"

    # create driver using options and capabilities
    @driver = Selenium::WebDriver.for :chrome, options: options, desired_capabilities: caps
    
end

def teardown
    @driver.quit
end

def run
    setup
    yield
    teardown
end


############ MAIN ###################

run do

    # go to cuprum's page
    @driver.get 'https://www.cuprum.cl/wwwcuprum/Login.aspx'
	rut = ENV['RUT']
    password = ENV['PASSWORD']
    
    element = @driver.find_element(:name, '_ctl0:MainContent:rut')
    element.send_keys rut
	element = @driver.find_element(:name, '_ctl0:MainContent:password')
    element.send_keys password
    element.submit

    # create screenshot of search results
    print "RESULTS TITLE: #{@driver.title}\n"

    time = Time.now.strftime("%Y%m%d%H%M%S")
    element = @driver.find_element(:id, 'SaldoTotalPorCuenta').find_element(:tag_name, 'h3') 
    
    print "#{time}: #{element.text}\n"
    File.write('cuprum.csv', "#{time},#{element.text}\n", mode: 'a')
    
    @driver.save_screenshot("#{time}.png")
end
