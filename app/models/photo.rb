class Photo < ActiveRecord::Base
  has_attached_file :image, styles: { big: "800x800#", medium: "400x400#", thumb: "300x300#", mini: "120x120#" },
  default_url: "/images/:style/missing.png",
  :url  => ":s3_domain_url",
  :path => "public/system/photos/images/000/000/:id/:style_:basename.:extension",
  :storage => :fog,
  :fog_credentials => {
        provider: 'AWS',
        aws_access_key_id: ENV["AWS_ACCESS_KEY_ID"],
        aws_secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"],
        region: 'us-west-2'
  },
  fog_directory: ENV["FOG_DIRECTORY"]

  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  validates :image, attachment_presence: true
  belongs_to :user
end
