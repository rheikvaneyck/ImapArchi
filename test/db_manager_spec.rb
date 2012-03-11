require File.dirname(__FILE__) + '/../lib/imaparchi'

describe "Database Manager" do
  before :each do
    @db = ImapArchi::DBManager.new("../db/emails-dev.sqlite")
  end
  after :each do
    ImapArchi::DBManager::Email.find_each do |l|
      l.destroy
    end         
  end
  it "should return connection state true" do
    @db.connection_state?.should eql(true)
  end
  it "should return table emails existens" do
    @db.table_exists?("emails").should eql(true), "Table emails does not exist"
  end
  it "should return table attachements existens" do
     @db.table_exists?("attachements").should eql(true), "Table attachements does not exist"
  end
  it "should be able to insert values to emails" do
    email = @db.insert_record(ImapArchi::DBManager::Email, {:sender => "Marcus", :delivery_date => "2011-10-05 22:00:00 +0200"})
    ImapArchi::DBManager::Email.find(email.id).sender.should eql("Marcus")
  end
  it "should return column from from emails" do
    @db.insert_record(ImapArchi::DBManager::Email, {:sender => "Marcus", :delivery_date => "2011-10-20 22:00:00 +0200"})
    @db.get_column(ImapArchi::DBManager::Email, :sender)[0].should eql("Marcus"), "column is empty"
  end
end

