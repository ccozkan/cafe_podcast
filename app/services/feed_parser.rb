# frozen_string_literal: true

class FeedParser
  def self.call(content)
    # you no track me
    stripped_url = content.enclosure_url.split('?', 2)[0]

    { title: content.title,
      duration: content.enclosure_length.to_i / 983_040 + 1,
      summary: content.itunes_summary,
      url: stripped_url,
      entry_id: content.entry_id,
      keywords: content.itunes_keywords,
      publish_date: content.published }
  end
end
