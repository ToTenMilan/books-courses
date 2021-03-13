class Minions < ActiveRecord::Migration[6.1]
  def up
    create_table :minions do |t|
      t.references :thing
      10.times do |i|
        t.string "mcol#{i}"
      end
    end

    execute <<-END
      insert into minions(thing_id,
                          mcol0, mcol1, mcol2, mcol3, mcol4,
                          mcol5, mcol6, mcol7, mcol8, mcol9) (
        select
          things.id,
          rpad('x', 100, 'x'), rpad('x', 100, 'x'), rpad('x', 100, 'x'),
          rpad('x', 100, 'x'), rpad('x', 100, 'x'), rpad('x', 100, 'x'),
          rpad('x', 100, 'x'), rpad('x', 100, 'x'), rpad('x', 100, 'x'),
          rpad('x', 100, 'x')
        from things, generate_series(1, 10)
      );
    END
  end

  def down
    drop_table :minions
  end
end
