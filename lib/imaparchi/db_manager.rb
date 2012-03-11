# This module encapsulates functionality related to the connection to the 
# database. 
#--
# Copyright (c) 2011 Marcus Nasarek
# Licensed under GPL. No warranty is provided.

require 'active_record'

module ImapArchi
  # Class of the Database Manager
  # 
  # :call-seq:
  #    DB.new(database_name)
  class DBManager
    def initialize(db_file_path)
      ActiveRecord::Base.establish_connection(
        :adapter => "sqlite3",
        :database => db_file_path
      )
      create_tables
    end
    class Email < ActiveRecord::Base
      has_many :attachements
    end
    class Attachement < ActiveRecord::Base
      belongs_to :email
    end

    def connection_state?
      return ActiveRecord::Base.connected?
    end
    
    def table_exists?(table_name)
      return ActiveRecord::Base.connection.table_exists?(table_name)
    end
    
    def insert_record(model, values)
      model.create(values)
    end
    
    def get_column(model, column)
      model.find(:all, :select => column.to_s).map(&column)
    end
    
    private
    def create_tables
      unless ActiveRecord::Base.connection.table_exists?("emails")
        ActiveRecord::Schema.define do
          create_table :emails do |table|
            table.column :sender, :string
            table.column :recipients, :string
            table.column :subject, :string
            table.column :attachements_count, :integer, :default => 0
            table.column :attachements_size, :integer, :default => 0
            table.column :delivery_date, :date
          end
        end
      end
      unless ActiveRecord::Base.connection.table_exists?("attachements")
        ActiveRecord::Schema.define do
          create_table :attachements do |table|
            table.column :email_id, :integer
            table.column :attachement_size, :integer, :default => 0
            table.column :file_name, :string
            table.column :content_type, :string
            table.column :local_path, :string
          end
        end
      end 
    end
    
  end 
end

