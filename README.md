# oso demo

## Python

Outline:

In the terminal, run

```py
cd py
python3.8
>>> from app import *
>>> oso = load_oso()
```

You now have a few things to play around with to see the structure of the application.

We have a hardcoded list of users:

```py
>>> USERS
{'alice': {'role': 'employee', 'location': 'NYC'}, 'bhavik': {'role': 'employee', 'location': 'London'}, 'cora': {'role': 'employee', 'location': 'Berlin'}, 'deirdre': {'role': 'accountant', 'location': 'NYC'}, 'ebrahim': {'role': 'accountant', 'location': 'London'}, 'frantz': {'role': 'accountant', 'location': 'Berlin'}, 'greta': {'role': 'admin', 'location': 'NYC'}, 'han': {'role': 'admin', 'location': 'London'}, 'iqbal': {'role': 'admin', 'location': 'Berlin'}}
```

Which can be accessed through the `User` class:

```py
>>> User.by_name("bhavik")
<app.User object at 0x7fae2e0dfc10>
>>> User.by_name("bhavik").role
'employee'
```

There are other classes defined in the `app.py` file, such as the `Expense` class that we will use shortly.

Finally, we have an `oso` instance -- the authorization runtime embedded in our application -- that we can
query with authorization questions (e.g., "Can Alice view a particular expense?")

## Quick example of oso in action

```py
# should return true because Alice submitted Expense{id: 0}
oso.allow(User.by_name("alice"), "view", Expense.by_id(0))
# should return false because Bhavik can't see expenses submitted by Alice.
oso.allow(User.by_name("bhavik"), "view", Expense.by_id(0))
```

Could you describe what just happened?

## Your turn to drive

Next you're going to write your own policy and see it enforced.

1. Create a new policy file in the `py` directory.
2. Load the file into our existing oso instance.
3. Write a rule allowing Alice to view any expense with an amount less than 1000.
4. Check that the rule is working:
    ```py
    # should return true because Expense{id: 1} has an amount < 1000.
    oso.allow(User.by_name("alice"), "view", Expense.by_id(1)) 
    # should return false because Expense{id: 2} has an amount > 1000.
    oso.allow(User.by_name("alice"), "view", Expense.by_id(2))
    ```
