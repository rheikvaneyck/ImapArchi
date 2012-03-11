#!/usr/bin/env ruby
require 'optparse'

module ImapArchi
  class Options
    BASE_DIR = "server"
    DATABASE_DIR = "db"
    DATABASE_FILE = "emails-dev.sqlite"   
    CONFIG_DIR = "config"
    CREDENTIAL_FILE = "credentials.yml"
    ATTACHEMENTS_DIR = "attachements"
    
    attr_reader :base_dir
    attr_reader :database_dir
    attr_reader :database_file
    attr_reader :config_dir
    attr_reader :credential_file
    attr_reader :attachements_dir
    
    def initialize(argv)
      @base_dir = BASE_DIR
      @database_dir = DATABASE_DIR
      @database_file = DATABASE_FILE
      @config_dir = CONFIG_DIR
      @credential_file = CREDENTIAL_FILE
      @attachements_dir = ATTACHEMENTS_DIR
      
      parse(argv)
      puts argv
    end
    private
    def parse(argv)
      OptionParser.new do |opts|
        opts.banner = "Usage: imaparchi [ options ]"
        opts.on("-b", "--base-dir path", String, "Path to directory") do |b|
          @base_dir = b
        end
        opts.on("-d", "--db-dir path", String, "Path to directory") do |db|
          @database_dir = db
        end
        opts.on("-f", "--db-file name", String, "File name") do |f|
          @database_file = f
        end
        opts.on("-c", "--config-dir path", String, "Path to directory") do |c|
          @config_dir = c
        end
        opts.on("-l", "--credential-file name", String, "File name") do |a|
          @credential_file = a
        end
        opts.on("-a", "--attachements-dir path", String, "Path to directory") do |r|
          @attachements_dir = r
        end
        opts.on("-h", "--help", "Show this message") do
          puts opts
          exit
        end
        begin
          # argv = ["-h"] if argv.empty?
          opts.parse!(argv)
        rescue OptionParser::ParseError => e
          STDERR.puts e.message, "\n", opts
          exit(-1)
        end        
      end
    end
  end
end