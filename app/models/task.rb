class Task < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  validates_presence_of :name
  validates_uniqueness_of :name,:scope => :project_id
  scope :by_status,lambda{|status| where("status = ?",status)}
  STATUSES =['Due' ,'Completed']
  before_create :set_default_status

  def self.due_task
    Task.by_status(STATUSES[0])
  end

  def self.completed_task
    Task.by_status(STATUSES[1])
  end
  #liquid_methods(:name,:description,:start_date,:end_date,:user_id,:status)
  def completed?
    self.status == STATUSES[1]
  end

  def set_default_status
    self.status = "Due"
  end


end
