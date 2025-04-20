import pyodbc

class Database:
    def __init__(self, connection_string):
        self.connection = pyodbc.connect(connection_string)
        self.cursor = self.connection.cursor()

    def execute(self, query, parameters=None):
        """
        Executes a SQL query with parameter substitution.
        
        Args:
            query (str): SQL query with ? placeholders
            parameters (iterable): Values to substitute for placeholders
            
        Yields:
            Rows from SELECT queries
            
        Raises:
            ValueError: If number of parameters doesn't match number of placeholders
            Exception: For other database errors
        """
        try:
            # Count the number of placeholders in the query
            placeholder_count = query.count('?')
            
            # Validate parameters
            if parameters is not None:
                if len(parameters) != placeholder_count:
                    raise ValueError(
                        f"Parameter count mismatch. Query has {placeholder_count} placeholders "
                        f"but {len(parameters)} parameters were provided"
                    )
            elif placeholder_count > 0:
                raise ValueError(
                    f"Query has {placeholder_count} placeholders but no parameters were provided"
                )
            
            # Execute the query
            if parameters:
                self.cursor.execute(query, parameters)
            else:
                self.cursor.execute(query)
            
            # For SELECT queries, yield results
            if query.strip().upper().startswith('SELECT'):
                for row in self.cursor:
                    yield row
            else:
                self.connection.commit()
                
        except Exception as e:
            self.connection.rollback()
            raise e
            
    def close(self):
        """Close the database connection."""
        try:
            if self.cursor:
                self.cursor.close()
            if self.connection:
                self.connection.close()
        except Exception as e:
            print(f"Error closing connection: {e}")

    # Context manager support
    def __enter__(self):
        return self
        
    def __exit__(self, exc_type, exc_val, exc_tb):
        self.close()

class Passenger:
    def __init__(self, first_name, last_name, gender, age_bracket, nationality, phone, document_type, document_number):
        self.first_name = first_name
        self.last_name = last_name
        self.gender = gender
        self.age_bracket = age_bracket
        self.nationality = nationality
        self.phone = phone
        self.document_type = document_type
        self.document_number = document_number

    def to_dict(self):
        return {
            "first_name": self.first_name,
            "last_name": self.last_name,
            "gender": self.gender,
            "age_bracket": self.age_bracket,
            "nationality": self.nationality,
            "phone": self.phone,
            "document_type": self.document_type,
            "document_number": self.document_number,
        }
