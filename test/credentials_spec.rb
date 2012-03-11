require File.dirname(__FILE__) + '/../lib/imaparchi'

module ImapArchi 
  describe Credentials do
    it 'should read credentials from a file' do
      credential_keys = ["imap_user", "imap_pw", "imap_server", "imap_port"]
      credentials = Credentials.read_from_yaml("../config/credentials.yml",credential_keys)
      credentials[:imap_user].should eql("marcus@mailserver.com")
      credentials[:imap_pw].should eql("geheim")
      credentials[:imap_server].should eql("imap.mailserver.com")
      credentials[:imap_port].should eql(165)
    end
    it 'should return email recipients from file' do
      credential_keys = ["email_to"]
      credentials = Credentials.read_from_yaml("../config/credentials.yml",credential_keys)
      credentials[:email_to].should eql("user@server.com, user2@server.com")
    end
    it 'should return email sender from file' do
      credential_keys = ["email_from"]
      credentials = Credentials.read_from_yaml("../config/credentials.yml",credential_keys)
      credentials[:email_from].should eql("admin@server.com")
    end
  end
end
