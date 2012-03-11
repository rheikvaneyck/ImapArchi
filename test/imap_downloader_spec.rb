require File.dirname(__FILE__) + '/../lib/imaparchi'
module ImapArchi 
  describe ImapDownloader do
    before :each do
      @imap = ImapDownloader.new('imap.gmail.com', user, pw)
    end
    
    after :each do
      @imap.quit
    end
    
    it "should return INBOX count" do
      @imap.emails_count.should_not eql(0)
    end
    
    it "should download first 128 subjects" do
      rh = @imap.download_folder
      rh.each do |id, s|
        puts "#{id}: #{s}"
      end
      rh.should_not be_empty
    end
  end
end
