require 'json'
filepath = File.join(__dir__, "curriculum.json")
serialized_curriculum = File.read(filepath)

chapters = JSON.parse(serialized_curriculum)

chapters.each do |chapter|
  new_chapter = Chapter.find_or_create_by!(name: chapter["chapter_title"], description: chapter["chapter_overview"])
  chapter["chapter_groups"].each do |chapter_group|
    chapter_group["group_lectures"].each do |group_lecture|
      Lecture.find_or_create_by!(
        title: group_lecture["lecture_title"],
        group_name: chapter_group["group_title"],
        resource_url: group_lecture["lecture_url"],
        chapter: new_chapter
      )
    end
  end
end
