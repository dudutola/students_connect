class MeetingPolicy < ApplicationPolicy
  # NOTE: Up to Pundit v2.3.1, the inheritance was declared as
  # `Scope < Scope` rather than `Scope < ApplicationPolicy::Scope`.
  # In most cases the behavior will be identical, but if updating existing
  # code, beware of possible changes to the ancestors:
  # https://gist.github.com/Burgestrand/4b4bc22f31c8a95c425fc0e30d7ef1f5

  class Scope < ApplicationPolicy::Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      # scope.all
      scope.where("requester_id = ? OR receiver_id = ?", user.id, user.id)
    end
  end

  def show?
    record.requester == user || record.receiver == user
  end

  def create?
    # For example, check if the user is either the requester or the receiver
    user == record.requester || user == record.receiver
  end

  def accept?
    record.receiver == user
  end

  def decline?
    record.requester == user || record.receiver == user
  end

  def cancel?
    record.requester == user && record.status == "pending"
  end
end
