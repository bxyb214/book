
node(:date) { DateTime.parse(Time.now.to_s).strftime('%Y%m%d').to_s }

child @topics do
    collection @topics, :object_root => false
    attributes :id, :title
    node(:image) { "http://pic4.zhimg.com/870cc8868a903f2ddad541d0b451c837.jpg" }

end