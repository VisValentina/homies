module ApplicationHelper
  def total_expense_amount_sphere(sphere)
    Expense.where(sphere_id: sphere.id).sum("cost")
  end

  def total_expense_by_category(sphere_id)
    sql = "SELECT sum(e.cost), c.name from users u, expenses e, categories c where u.id = e.user_id and c.id = e.category_id and sphere_id = #{sphere_id} group by c.name;"
    results = ActiveRecord::Base.connection.execute(sql)
  end

  def total_expense_by_user(sphere_id)
    sql = "SELECT sum(e.cost), u.username from users u, expenses e, categories c where u.id = e.user_id and c.id = e.category_id and sphere_id = #{sphere_id} group by u.username;"
    results = ActiveRecord::Base.connection.execute(sql)
  end

  def itemized_expense_by_user(sphere_id, user_id)
    sql = "SELECT e.cost, e.name, u.username from users u, expenses e, categories c where u.id = e.user_id and c.id = e.category_id and e.sphere_id = #{sphere_id} and u.id = #{user_id};"
    results = ActiveRecord::Base.connection.execute(sql)
  end

  def user_id_in_sphere(sphere_id)
    Expense.where(sphere_id: sphere_id).select("user_id").distinct
  end

  def number_of_user_in_sphere(sphere_id)
    Connection.where(sphere_id: sphere_id).select("user_id").distinct.count
  end


  def total_expense_by_category_by_user(sphere_id, user_id)
    sql = "SELECT sum(e.cost), c.name, u.username from users u, expenses e, categories c where u.id = e.user_id and c.id = e.category_id and sphere_id = #{sphere_id} and u.id = #{user_id} group by u.username, c.name order by c.name;"
    results = ActiveRecord::Base.connection.execute(sql)
  end

  def cat_id_in_sphere(sphere_id)
    Expense.where(sphere_id: sphere_id).select("category_id").distinct
  end

  def total_expense_by_user_by_cat(sphere_id, cat_id)
    sql = "SELECT sum(e.cost), c.name, u.username from users u, expenses e, categories c where u.id = e.user_id and c.id = e.category_id and sphere_id = #{sphere_id} and e.category_id = #{cat_id} group by u.username, c.name order by c.name;"
    results = ActiveRecord::Base.connection.execute(sql)
  end

  def usernames_per_sphere(sphere_id)
    sql = "Select distinct u.id, u.username from users u, connections c where u.id = c.user_id and c.sphere_id = #{sphere_id} order by u.username;"
    results = ActiveRecord::Base.connection.execute(sql)
  end

  def categories_per_sphere(sphere_id)
    sql = "select distinct c.id, c.name from categories c, expenses e where c.id = e.category_id and e.sphere_id = #{sphere_id} order by c.name;"
    results = ActiveRecord::Base.connection.execute(sql)
  end

  def category_sum_per_sphere_user(sphere_id, cat_id, user_id)
    sql = "SELECT sum(e.cost) from users u, expenses e, categories c where u.id = e.user_id and c.id = e.category_id and sphere_id = #{sphere_id} and e.category_id = #{cat_id} and e.user_id = #{user_id} group by u.username, c.name order by c.name;"
    results = ActiveRecord::Base.connection.execute(sql)
  end

  def cat_sum_with_default(sphere_id, cat_id, user_id)
    results = category_sum_per_sphere_user(sphere_id, cat_id, user_id)
    total = 0
      if results == 0
         total = 0
      else
        results.each do |result|
          total = result["sum"]
        end
      end
     total
  end

end
