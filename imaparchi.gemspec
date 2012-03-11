Gem::Specification.new do |s|
    s.name = "imaparchi"
    s.version = "0.1.0"
    s.authors = ["Marcus Nasarek", "Rheik van Eyck"]
    s.date = %q{2012-02-15}
    s.description = "imapArchi - backup emails from imap servers"
    s.summary = s.description
    s.email = "rheikvaneyck@yahoo.de"
    s.files = Dir["lib/**/*", "test/*", "*.txt", "README*"]
    s.bindir = "bin"
    s.executables = "imaparchi"
    s.homepage = "http://myname.plus/MarcusNasarek"
    s.has_rdoc = false
    s.rubyforge_project = "imaparchi"
    s.add_dependency('shoulda')
    s.add_dependency('googlecharts')
    s.add_dependency('activerecord')
    s.add_dependency('sqlite3')    
end
    