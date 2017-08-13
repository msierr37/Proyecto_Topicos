class Article < ActiveRecord::Base
  belongs_to :user
  validates :title, presence: true, uniqueness:true
  validates :body, presence: true, length: {minimum:20}
  before_create :set_visits_count
  scope :recientes, ->{order("created_at ASC")}

  has_attached_file :mp3
  validates_attachment :mp3, :content_type => {:content_type =>["audio/mpeg","audio/mp3"]}, :file_name => {:matches=>[/mp3\Z/]}
  def update_visits_count
    self.update(visit_count: self.visit_count + 1)
  end
  private

  def set_visits_count
    self.visit_count = 0
  end
end
