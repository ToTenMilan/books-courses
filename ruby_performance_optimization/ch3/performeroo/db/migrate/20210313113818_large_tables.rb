class LargeTables < ActiveRecord::Migration[6.1]
  def up
    create_table :things do |t|
      10.times do |i|
        t.string "col#{i}"
      end
    end

    execute <<-END
      insert into things(col0, col1, col2, col3, col4,
                         col5, col6, col7, col8, col9) (
        select
          rpad('x', 100, 'x'), rpad('x', 100, 'x'), rpad('x', 100, 'x'),
          rpad('x', 100, 'x'), rpad('x', 100, 'x'), rpad('x', 100, 'x'),
          rpad('x', 100, 'x'), rpad('x', 100, 'x'), rpad('x', 100, 'x'),
          rpad('x', 100, 'x')
        from generate_series(1, 10000)
      );
    END
  end

  def down
    drop_table :things
  end
end
