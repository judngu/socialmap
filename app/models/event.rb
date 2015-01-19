class Event < ActiveRecord::Base
  belongs_to :user
  has_many :attendees
  has_many :picks
  has_many :users, through: :attendees

  validates :name, presence: true
  validates :user, presence:true
  validates :question, presence: true
  validates :passphrase, presence: true, uniqueness: true

  def other_attendees(user)
  	users.all_except(user)
  end

  def sociograph
    nodes = Pick.nodes(self)

    node_index = Pick.node_index(nodes)
    links = Pick.links(self, node_index)

    { nodes: nodes, links: links }
  end

  def self.random_passphrase
    ('a'..'z').to_a.shuffle[0, 10].join.upcase
  end
end
