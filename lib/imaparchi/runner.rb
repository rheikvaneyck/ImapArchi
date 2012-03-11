#!/usr/bin/env ruby
# This module encaspulates functionality to run the server-health programm.
# The main programm flow is in the run method
#--
# Copyright (c) 2011 Marcus Nasarek
# Licensed under the same terms as Ruby. No warranty is provided.

require 'fileutils'

module ImapArchi
  class Runner
    # Initilialize the runner. Heaps of options are defined, parsed
    # with the ImapArchi::Options class. During initialization
    # the folder tree holding the data for the new server is created
    # with create_directories. Templates for the credential file are
    # copied to specific locations in the new folder tree. Furthermore
    # a connection to the sqlite3 database is established.
    def initialize(argv)
      @options = ImapArchi::Options.new(argv)
      create_directories
      provide_templates
      @db = ImapArchi::DBManager.new(File.join(@options.base_dir,@options.database_dir, @options.database_file))
    end
    
    def run
    end
	
    private
    def create_directories
      @options.instance_variables.each do |v|
        if  v =~ /^.(?!base|remote).*_dir$/ then
          dir = File.join(@options.base_dir, @options.instance_variable_get(v))
          FileUtils.mkdir_p(dir)
        end
      end
    end
    def provide_templates
      gems_dir = %x[gem env gemdir]
      # credential template
      gem_template_file = File.join(gems_dir,"gems","imaparchi","config",@options.credential_file)
      if File.exists?(File.join(@options.config_dir,@options.credential_file))
        template_src = File.join(@options.config_dir,@options.credential_file)
      elsif File.exists?(gem_template_file)
        template_src = File.join(gem_template_file)
      else
        puts "Can not provide credential sample file"
      end
      template_dest = File.join(@options.base_dir, @options.config_dir,@options.credential_file)
      unless File.exists?(template_dest)
        begin 
          FileUtils.cp(template_src,template_dest)
        ensure
          puts "Edit the credential file #{template_dest}, programm ends here for now"
          exit
        end
      end     
    end
  end
end
