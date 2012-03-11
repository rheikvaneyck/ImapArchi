$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))
require 'imaparchi/options'
require 'imaparchi/credentials'
require 'imaparchi/db_manager'
require 'imaparchi/imap_downloader'
require 'imaparchi/runner'

module ImapArchi
  VERSION = '0.1.0'
end