module main

import sqlite
import os

[table: 'words']
struct Word {
	id  int    [primary; sql: serial]
	eng string [nonull]
	ger string [nonull]
}

fn main() {
		mut db := sqlite.connect('data.db') ! defer {
		db.close() or { panic(err) }
	}

	sql db {
		create table Word
	}

	menu(mut db)
}

fn menu(mut db sqlite.DB) {
	print("\nVictonary\n\n")
	print("Menu:\n  1. Add a word\n  2. Listing\n  3. Editing\n  4. Searching\n  5. Deleting\n  9. Exit\nWähle eine Option: ")

	match os.input('') {
		'1' { add_word(mut db) }
		'2' { list_menu(mut db) }
		'3' { edit_menu(mut db) }
		'4' { search_menu(mut db) }
		'5' { delete_menu(mut db) }
		'9' { program_exit(mut db) }
		else { menu(mut db) }
	}

	menu(mut db)
}

fn add_word(mut db sqlite.DB) {
	print("Füge ein Wort hinzu:\n")
	print("English: ")
	eng := os.input('')
	print("German: ")
	ger := os.input('')

	new_word := Word{eng: eng, ger: ger}
	sql db {
		insert new_word into Word
	}
}

fn list_menu(mut db sqlite.DB) {
	print("\nList Menu:\n  1. List all words\n  2. List words by ID\n  3. List words by English\n  4. List words by German\n  9. Back\nWähle eine Option: ")

	match os.input('') {
		'1' { list_all(mut db) }
		'2' { list_by_id(mut db) }
		'3' { list_by_eng(mut db) }
		'4' { list_by_ger(mut db) }
		'9' { menu(mut db) }
		else { list_menu(mut db) }
	}

	menu(mut db)
}

fn list_all(mut db sqlite.DB) {
	print('\n')
	mut rows, err := db.exec('SELECT * FROM words')
	for row in rows {
		print("{row.vals[0]}: {row.vals[1]} - {row.vals[2]}")
		print('\n')
	}
}

fn list_by_id(mut db sqlite.DB) {
	print("List by ID:\n")
	print("ID: ")
	id := os.input('')

	mut rows, err := db.exec('SELECT * FROM words WHERE id = {id}')
	for row in rows {
		print("{row.vals[0]}: {row.vals[1]} - {row.vals[2]}")
		print('\n')
	}
}

fn list_by_eng(mut db sqlite.DB) {
	print("List by English:\n")
	print("English: ")
	eng := os.input('')

	mut rows, err := db.exec('SELECT * FROM words WHERE eng = {eng}')
	for row in rows {
		print("{row.vals[0]}: {row.vals[1]} - {row.vals[2]}")
		print('\n')
	}
}

fn list_by_ger(mut db sqlite.DB) {
	print("List by German:\n")
	print("German: ")
	ger := os.input('')

	mut rows, err := db.exec('SELECT * FROM words WHERE ger = {ger}')
	for row in rows {
		print("{row.vals[0]}: {row.vals[1]} - {row.vals[2]}")
		print('\n')
	}
}

fn edit_menu(mut db sqlite.DB) {
	print("\nEdit Menu:\n  1. Edit word by ID\n  2. Edit word by English\n  3. Edit word by German\n  9. Back\nWähle eine Option: ")

	match os.input('') {
		'1' { edit_by_id(mut db) }
		'2' { edit_by_eng(mut db) }
		'3' { edit_by_ger(mut db) }
		'9' { menu(mut db) }
		else { edit_menu(mut db) }
	}

	menu(mut db)
}

fn edit_by_id(mut db sqlite.DB) {
	print("Edit by ID:\n")
	print("ID: ")
	id := os.input('')

	mut rows, err := db.exec('SELECT * FROM words WHERE id = {id}')
	for row in rows {
		print("{row.vals[0]}: {row.vals[1]} - {row.vals[2]}")
		print('\n')
	}

	print("English: ")
	eng := os.input('')
	print("German: ")
	ger := os.input('')
	db.exec('UPDATE words SET eng = {eng}, ger = {ger} WHERE id = {id}')
}

fn edit_by_eng(mut db sqlite.DB) {
	print("Edit by English:\n")
	print("English: ")
	eng := os.input('')

	mut rows, err := db.exec('SELECT * FROM words WHERE eng = {eng}')
	for row in rows {
		print("{row.vals[0]}: {row.vals[1]} - {row.vals[2]}")
		print('\n')
	}

	print("ID: ")
	id := os.input('')
	print("German: ")
	ger := os.input('')
	db.exec('UPDATE words SET id = {id}, ger = {ger} WHERE eng = {eng}')
}

fn edit_by_ger(mut db sqlite.DB) {
	print("Edit by German:\n")
	print ("German: ")
	ger := os.input('')

	mut rows, err := db.exec('SELECT * FROM words WHERE ger = {ger}')

	for row in rows {
		print("{row.vals[0]}: {row.vals[1]} - {row.vals[2]}")
		print('\n')
	}

	print("ID: ")
	id := os.input('')
	print("English: ")
	eng := os.input('')
	db.exec('UPDATE words SET id = {id}, eng = {eng} WHERE ger = {ger}')
}

fn search_menu (mut db sqlite.DB) {
	print("\nSearch Menu:\n  1. Search by ID\n  2. Search by English\n  3. Search by German\n  9. Back\nWähle eine Option: ")

	match os.input('') {
		'1' { search_by_id(mut db) }
		'2' { search_by_eng(mut db) }
		'3' { search_by_ger(mut db) }
		'9' { menu(mut db) }
		else { search_menu(mut db) }
	}

	menu(mut db)
}

fn search_by_id(mut db sqlite.DB) {
	print("Search by ID:\n")
	print("ID: ")
	id := os.input('')

	mut rows, err := db.exec('SELECT * FROM words WHERE id = {id}')
	for row in rows {
		print("{row.vals[0]}: {row.vals[1]} - {row.vals[2]}")
		print('\n')
	}
}

fn search_by_eng(mut db sqlite.DB) {
	print("Search by English:\n")
	print("English: ")
	eng := os.input('')

	mut rows, err := db.exec('SELECT * FROM words WHERE eng = {eng}')
	for row in rows {
		print("{row.vals[0]}: {row.vals[1]} - {row.vals[2]}")
		print('\n')
	}
}

fn search_by_ger(mut db sqlite.DB) {
	print("Search by German:\n")
	print("German: ")
	ger := os.input('')

	mut rows, err := db.exec('SELECT * FROM words WHERE ger = {ger}')
	for row in rows {
		print("{row.vals[0]}: {row.vals[1]} - {row.vals[2]}")
		print('\n')
	}
}

fn delete_menu(mut db sqlite.DB) {
	print("\nDelete Menu:\n  1. Delete word by ID\n  2. Delete word by English\n  3. Delete word by German\n  9. Back\nWähle eine Option: ")

	match os.input('') {
		'1' { delete_by_id(mut db) }
		//'2' { delete_by_eng(mut db) }
		//'3' { delete_by_ger(mut db) }
		'9' { menu(mut db) }
		else { delete_menu(mut db) }
	}

	menu(mut db)
}

fn delete_by_id(mut db sqlite.DB) {
	print("Gib die ID des zu löschenden Wortes an: ")
	id := os.input('')

	db.exec('DELETE FROM words WHERE id = {id}')
}

fn program_exit(mut db sqlite.DB) {
	println("Programm beendet")
	exit(0)
}
