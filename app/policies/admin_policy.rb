class AdminPolicy < ApplicationPolicy
  def admin? = user&.admin?

  def index? = admin?
  def show? = admin?
  def create? = admin?
  def update? = admin?
  def destroy? = admin?
  def grant? = admin?
  def ungrant? = admin?
end
