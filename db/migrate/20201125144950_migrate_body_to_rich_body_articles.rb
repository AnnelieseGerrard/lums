class MigrateBodyToRichBodyArticles < ActiveRecord::Migration[6.0]
  def up
    Lecture.find_each do |lecture|
      lecture.update(rich_content: lecture.content)
    end
  end
  def down
    Lecture.find_each do |lecture|
      lecture.update(content: article.rich_content)
      lecture.update(rich_content: nil)
    end
  end
end
