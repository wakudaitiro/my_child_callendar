RakutenWebService.configure do |c|
  c.application_id = ENV['Rakuten_API_KEY']
end

# root = RakutenWebService::Ichiba::Genre.root # root genre
# # children returns sub genres
# root.children.each do |child|
#   puts "[#{child.id}] #{child.name}"
# end

# # Use genre id to fetch genre object
# RakutenWebService::Ichiba::Genre[100533].name #ベビー用品