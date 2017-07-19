class Client < ActiveRecord::Base
  belongs_to :cidade 
  belongs_to :estado
  has_many :dns_servers 
  has_many :receipts
  belongs_to :licence
  belongs_to :callcenter
  has_many :extra_sales

  has_many :patrimonios
  
  validates :name, :address, :neighborhood, :zipcode, :phone, :cnpj, :email, :cidade_id, :estado_id, :status,
  presence: true
  
  #before_create :file_size_under_one_mb
    
  def initialize(params = {})
    @file = params.delete(:file)
    super
    if @file
      self.filename = sanitize_filename(@file.original_filename)
      self.content_type = @file.content_type
      self.file_contents = @file.read
    end
  end

  private

    def sanitize_filename(filename)
      # Get only the filename, not the whole path (for IE)
      # Thanks to this article I just found for the tip: http://mattberther.com/2007/10/19/uploading-files-to-a-database-using-rails
      return File.basename(filename)
    end

    NUM_BYTES_IN_MEGABYTE = 1048576
    def file_size_under_one_mb
              
        if (@file.size.to_f / NUM_BYTES_IN_MEGABYTE) > 5
          errors.add(:file, 'O arquivo não pode ultrapassar 5mb.')
        end
 
    end
    
    
end
