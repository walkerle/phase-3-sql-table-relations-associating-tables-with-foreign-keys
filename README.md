# Outline

1. Why do we need to relate tables? give an example
2. How to relate table: foreign key, what is it/code along

# Table Relations

## Objectives

1. Understand why we need to relate tables to one another. 
2. Learn how to relate table data to data from another table using foreign keys. 

## Why Relate Tables?

It's hard to imagine an application that saves data but doesn't relate it. For example––a Facebook user is associated to other users via "friendships", an Amazon user has a shopping cart full of items, a blog's author has many posts and posts might in turn have many tags. All of these examples require different datasets to be related or associated to one another. 

## Relating Tables with Foreign Keys

SQLite makes relating tables easy with the use of foreign keys. To associate one table to another, give one table a column called "foreign key" with a type of `INTEGER` and insert the primary key of another table row into that column. In other words, if we have a blogging app, we might have a users table and a posts table. Posts belong to the user that wrote that post. So, the posts table would have a foreign key column. An individual post's foreign key value would be the primary key ID of the user who authored that post. 

This is a little confusing, so let's build out our own example together. 

### Code Along I: Relating Cats to Owners


Let's revisit our `pets_database.db` and our `cats` table. Cd into the directory that contains your pet's database and type: `sqlite3 pets_database.db` to connect to our database. 

#### Step 1: Creating the Owners Table

First, we need to create our owners table. An owner should have an ID that is a primary key integer and a name that is text: 

```sql
sqlite> CREATE TABLE owners (id INTEGER PRIMARY KEY, name TEXT);
```

Now that we have our owners table, we can add a foreign key column to the pets table. 

#### Step 2: Add Foreign Key to Pets Table

Use the following statement to add this column: 

```sql
ALTER TABLE cats ADD COLUMN owner_id INTEGER;
```

Check your `cats` schema with `.schema` and you should see the following: 

```sql
CREATE TABLE cats (
id INTEGER PRIMARY KEY,
name TEXT,
age INTEGER,
breed TEXT,
owner_id INTEGER);
```

Great, now we're ready to associate cats to their owners by creating an owner and assigning that owner's ID to certain cat's `owner_id` column. 

#### Step 3: Associating Cats to Owners

First, let's make a new owner: 

```sql
INSERT INTO owners (name) VALUES ("mugumogu");
```

Check that we did that correctly with the following statement: 

```sql
SELECT * FROM owners;
```

You should see the following: 


```sql
1 | mugumogu
```

Mugumogu is the owner of both Hana and Maru. Let's create our associations: 

```sql
UPDATE cats SET owner_id = 1 WHERE name = "Maru";
UPDATE cats SET owner_id = 1 WHERE name = "Hana";
```

Let's check out our updated `pets` table: 

```sql
SELECT * FROM cats WHERE owner_id = 1;
```

This should return:

```sql
1 | Maru | 3 | Scottish Fold | 1
2 | Hana | 1 | Tabby         | 1
```

### Establishing Foreign Key: Determining Which Table Gets a "foreign key" Column

Why did we decide to give our `pets` table the foreign key column and not the `owners` table? Similarly, in the example from the beginning of this exercise, why would we give a `posts` table a foreign key of `user_id` and not the other way around? 

Let's look at what would happen if we tried to add cats directly to the `owners` table.

Adding the first cat, "Maru", to the owner "mugumogu" would look something like this: 

| id | name | cat_id|
|----|------|-------|
| 1  | mugumogu | 1 |

So far so good. But what happens when we need to add a second cat, "Hana", to the same owner?

| id | name | cat_id1| cat_id2 |
|----|------|-------|----------|
| 1  | mugumogu | 1 | 2        |

What if this owner get *yet another cat?* We'd have to keep growing our table horizontally, potentially forever. That is not efficient, or organized. 

We can also think about the relationship between our owners and our cats in the context of a "has many" and "belongs to" relationship. An owner can have many cats, but (for the purposes of this example), a cat can only belong to one owner. Similarly, an user can have many posts that they've written but each post was written by and therefore belongs to only one user. 

The thing that "has many" is considered to be the parent. The thing that "belongs to" we'll call the child. The child table gets the foreign key column, the value of which is the primary key of that data's/row's parent. 
