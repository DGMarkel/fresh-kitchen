Fresh Kitchen

Fresh Kitchen tracks food expiration dates in your kitchen.  It is searchable by expiration date, food type - vegetable, meat, beverage, and dry goods - as well as storage type - refrigerator, freezer, and pantry.

Development Goals:

Given the time I have allotted for this project, creating a content management system with so many tables and models may be too ambitious.

As such, my first priority is to create a working app that achieves the following:

  Users can create new accounts and log in with a secure password.
	**Users can have accounts on Freshdirect, Amazon, and other grocery delivery sites**
	Users have a food inventory
	Users have food in the following categories:
    Vegetables
    Meat
    Dry Goods
    Beverages
  Food belongs to users
  Food has an expiration date
	When food expires, Users will be notified.
  **If Users have grocery delivery service, they will be asked if they’d like to place an order for expired foods**
  User index will display four subdirectories: one for each food type.
  Each food index will display all foods belong to that food category.
	Food will be displayed in order according to expiration date
  **Each index page will include a list of expired foods**

  ** = wish list items

If I accomplish the above quickly, I’d like to test out a more sophisticated version of Fresh Kitchen, wherein food types are subcategorized into storage types.  

  I am quickly mapping out how I think this might work below:  

    Users will have Refrigerator, Freezer, and Pantry.
    Storage types belong to users
    Users have many storage_foods (i.e., refrigerator_vegetables, freezer_meats, pantry_beverages)
    Users have many foods through storage types		

Tentative Schema for Full App - Wishlist Items Included

    User
    	Has name
    	Has password
    Has a food inventory
    		Vegetables
    		Meat
    		Pantry Items
    		Beverages
    **Has many storage methods:
    		Refrigerator
    		Pantry
    		Freezer**

    Vegetables
      Belongs to user
      Has name
      Has quantity
      Has expiration date
      **Has storage category:
      	Refrigerated
      	Frozen
      	Pantry**

    Meat
    	Belongs to user
    	Has name
    	Has quantity
    	Has expiration date
    	**Has storage type
    		Refrigerated
    		Frozen**

    Beverages
    	Belongs to user
    	Has name
    	Has quantity
    	Has expiration date
    	**Has storage type
    		Refrigerated
    		Frozen
    		Pantry**

    Dry Goods
    	Belongs to User
    	Has name
    	Has quantity
    	Has expiration date
