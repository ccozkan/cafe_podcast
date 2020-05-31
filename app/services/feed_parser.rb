# frozen_string_literal: true

class FeedParser
  def self.call(content)
    { title: content.title,
      duration: content.enclosure_length.to_i / 983_040 + 1,
      summary: content.itunes_summary,
      url: content.enclosure_url,
      entry_id: content.entry_id,
      keywords: content.itunes_keywords,
      publish_date: content.published }
  end
end
