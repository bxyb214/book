class Topic < ActiveRecord::Base
  include Likeable
  include Trashable
  include Subscribable
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  TOP_HOT_VALUE = 100000000000000000000

  belongs_to :user, counter_cache: true
  belongs_to :category, counter_cache: true
  has_many :comments, as: 'commentable'

  validates :title, :body, presence: true

  after_create :update_hot, :owner_subscribe
  after_touch :update_hot

  after_trash :decrement_counter_cache
  after_restore :increment_counter_cache
  # Fix double desc counter
  after_destroy :increment_counter_cache, if: :trashed?

  def increment_counter_cache
    if category
      Category.update_counters category.id, topics_count: 1
    end
    User.update_counters user.id, topics_count: 1
  end

  def decrement_counter_cache
    if category
      Category.update_counters category.id, topics_count: -1
    end
    User.update_counters user.id, topics_count: -1
  end

  def calculate_hot
    order = Math.log10([comments_count, 1].max)
    order + created_at.to_f / 45000 * 2 * 30
  end

  def update_hot
    # reload because comments_count has been cache in associations
    reload
    update_attribute :hot, calculate_hot
  end

  def owner_subscribe
    subscribe_by user
  end

  def total_pages
    (comments_count.to_f / Comment.default_per_page).ceil
  end

  def top_it
    self.hot = TOP_HOT_VALUE
    self.save
  end
  def cancel_top_it
    self.update_hot
  end

  def more_like_this(num = 5)
    Topic.search(
      query: {
        more_like_this: {
          fields: ['title', 'body'],
          like_text: title + '\n' + body
        }
      },
      filter: {
        and: [
          { term: { trashed: false } },
          { not: { term: { id: id } } }
        ]
      }
    ).limit(num).records.to_a rescue []
  end
end
