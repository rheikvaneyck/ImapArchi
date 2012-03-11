# This module encapsulates functionality related to the download of 
# emails from the imap server. 
#--
# Copyright (c) 2011 Marcus Nasarek
# Licensed under GPL. No warranty is provided.

require 'net/imap'

module ImapArchi
  # Class of the Imap Downloader
  # 
  # :call-seq:
  #    ImapDownloader.new(server, user, pw, port, ssl)
  class ImapDownloader
    def initialize(server, user, pw, port = 993, ssl = true)
      @imap = Net::IMAP.new(server, port, ssl)
      @imap.login(user, pw)
    end
    
    def emails_count(folder = "INBOX")
      @imap.select(folder)
      uids = @imap.uid_search(['ALL'])
      return uids.length
    end
    
    def download_folder(folder = "INBOX", uid_block_size = 10)
      record_hash = {}
      @imap.select(folder)
      uids = @imap.uid_search(['ALL'])
      pos = 0
      @imap.uid_fetch(uids[pos, uid_block_size], ['ENVELOPE']).each do |data|
        msg = @imap.uid_fetch(data.attr['UID'], ['ENVELOPE', 'FLAGS','BODY']).first
        record_hash[data.attr['UID']] = msg.attr['ENVELOPE'].subject
      end
      return record_hash
    end
    
    def quit
      @imap.logout
      @imap.disconnect
    end
  end
end

