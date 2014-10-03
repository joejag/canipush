require 'yaml'
require 'nokogiri'
require 'open-uri'
require 'colorize'
require 'ostruct'

require "canipush/version"

module Canipush
  class Checker

  def load_config
    config = YAML::load_file('.canipush')
    [config['go_url'], config['depends_on']]
  end
  
  def xml_project_to_struct project
    name = project['name'].split("::").first.strip
    activity = project['activity'] 
    last_build_status = project['lastBuildStatus']
    OpenStruct.new(name: name, activity: activity, last_build_status: last_build_status)
  end
  
  def failing_build?(dependency, proj)
      proj.name ==  dependency and proj.last_build_status == 'Failure'
  end
  
  def can_i_push
    go, dependencies = load_config()
    
    broken = {}
    
    Nokogiri::XML(open(go)).xpath('//Project').each do |project|
      proj = xml_project_to_struct(project)
    
      dependencies.each do |dependency|
        if failing_build?(dependency, proj)
           message = project.xpath('messages/message/@text').to_s
           broken[name] = message
        end
      end
    end
    
    if broken.empty?
      puts "All good. Push, push, push!".green
    else
      puts "Don't push! These builds are broken:".white
      broken.each do |name, message|
        print " * ".cyan
        print name.yellow
        print " by "
        puts message.red
      end
    end
  end

end
end
