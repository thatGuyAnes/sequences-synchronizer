require 'pg'
require 'io/console'

print "Enter database name: (EX: pc_temp) "
dbname = gets.chomp
print "Enter username: "
# user = gets.chomp
user = STDIN.noecho(&:gets).chomp
print "Enter password: "
# password = gets.chomp
password = STDIN.noecho(&:gets).chomp

# Connect to the db
conn = PG.connect(dbname: dbname, user: user, password: password)

begin
  # Get the list of tables and their sequences
  # tables_result = conn.exec("SELECT table_name, pg_get_serial_sequence(table_name::regclass::text, 'id') AS sequence_name FROM information_schema.tables WHERE table_schema = 'public'")
  tables_result = conn.exec("SELECT table_name, pg_get_serial_sequence(table_name::regclass::text, 'id') AS sequence_name FROM information_schema.columns WHERE table_schema = 'public' AND column_name = 'id' GROUP BY table_name ")

  tables_result.each do |table|
    table_name = table['table_name']
    sequence_name = table['sequence_name']

    # If there's no associated sequence, skip this table
    next if sequence_name.nil? || sequence_name.empty?

    # Retrieve the maximum ID value from the table
    max_id_result = conn.exec("SELECT MAX(id) AS max_id FROM #{table_name}")
    max_id = max_id_result[0]['max_id']

    # Check If there are records in the table, reset the sequence
    if max_id
      new_value = max_id.to_i + 1
      conn.exec("SELECT setval('#{sequence_name}', #{new_value}, false)")
      puts "#### Sequence '#{sequence_name}' for table '#{table_name}' has been synchronized."
    else
      puts "##### Table '#{table_name}' is empty. No sequence synchronization needed."
    end
  end
ensure

  conn.close if conn # Close connection
end
