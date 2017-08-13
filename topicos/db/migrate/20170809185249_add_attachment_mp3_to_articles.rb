class AddAttachmentMp3ToArticles < ActiveRecord::Migration[5.1]
  def self.up
    change_table :articles do |t|
      t.attachment :mp3
    end
  end

  def self.down
    remove_attachment :articles, :mp3
  end
end
