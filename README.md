## PostgreSQL Sequence Synchronization Script

A Ruby script helps keep PostgreSQL database sequences in sync with table IDs. It securely connects to your database, prompts for necessary information, and automates the synchronization process.

### Features:

- **Sequence Synchronization:** Automatically adjusts sequences to match table IDs.
- **Secure Access:** Prompts for database credentials with hidden password input.
- **Error Handling:** Gracefully manages potential errors for a smoother execution.

### Requirements:

- Ruby
- PostgreSQL database
- `pg` gem

### Usage:

1. Install Ruby and `pg` gem.
2. Run the script.
3. Follow prompts to input database details.

### Note:

Ensure your PostgreSQL user has necessary permissions.

### Resources:

- [STDIN.noecho](https://ruby-doc.org/stdlib-2.2.1/libdoc/io/console/rdoc/IO.html#method-i-noecho)
- [pg_get_serial_sequence](https://pgpedia.info/p/pg_get_serial_sequence.html#:~:text=pg_get_serial_sequence()%20is%20a%20system,was%20added%20in%20PostgreSQL%208.0)
- [information_schema](https://pgpedia.info/i/information-schema.html)
- [setval](https://pgpedia.info/s/setval.html)

