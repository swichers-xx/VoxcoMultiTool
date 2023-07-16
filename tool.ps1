import tkinter as tk
from tkinter import messagebox
import subprocess
import pyodbc 

def create_connection(server, database, username, password):
    conn = pyodbc.connect('DRIVER={ODBC Driver 17 for SQL Server};SERVER='+
                        server+';DATABASE='+database+';UID='+username+';PWD='+ password)
    return conn.cursor()

def run_sql_command(cursor, command):
    try:
        cursor.execute(command)
        messagebox.showinfo("Success", "SQL command executed successfully")
    except Exception as e:
        messagebox.showerror("Error", str(e))

def run_powershell_command(command):
    try:
        process = subprocess.Popen(["powershell",command], stdout=subprocess.PIPE)
        result = process.communicate()[0]
        messagebox.showinfo("Success", "PowerShell command executed successfully")
    except Exception as e:
        messagebox.showerror("Error", str(e))

def main():
    # Create a new tkinter window
    window = tk.Tk()

    # Create a new entry field for the SQL command
    sql_entry = tk.Entry(window)
    sql_entry.pack()

    # Create a new button that runs the SQL command when clicked
    sql_button = tk.Button(window, text="Run SQL command", command=lambda: run_sql_command(cursor, sql_entry.get()))
    sql_button.pack()

    # Create a new entry field for the PowerShell command
    powershell_entry = tk.Entry(window)
    powershell_entry.pack()

    # Create a new button that runs the PowerShell command when clicked
    powershell_button = tk.Button(window, text="Run PowerShell command", command=lambda: run_powershell_command(powershell_entry.get()))
    powershell_button.pack()

    # Connect to the database
    cursor = create_connection("server", "database", "username", "password")

    # Start the tkinter event loop
    window.mainloop()

if __name__ == "__main__":
    main()
