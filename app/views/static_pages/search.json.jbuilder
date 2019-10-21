json.causes do
  json.array!(@causes) do |cause|
    json.title cause.title
    json.url cause_path(cause)
  end
end

json.events do
  json.array!(@events) do |event|
    json.title event.title
    json.url event_path(event)
  end
end

json.blogs do
  json.array!(@blogs) do |blog|
    json.title blog.title
    json.url blog_path(blog)
  end
end
