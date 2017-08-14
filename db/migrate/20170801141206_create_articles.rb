class CreateArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :articles do |t|
      t.string :title
      t.text :body
      t.integer :visit_count
      t.string :artista
      t.string :tamano
      t.string :privacida
      t.string :album
      t.integer :ano
      t.string :tiempo
    end
  end
end
