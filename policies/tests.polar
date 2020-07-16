
#### TEST
?= allow(new User { name: "alice"}, "view", new Expense {  id: 0});
###


# TEST: As an accountant, deirdre can view expenses in the same location
?= allow(new User { name: "deirdre"}, "view", new Expense { id: 0 });
#


# TEST: As an admin of ACME, Bhavik can view expenses in the org
?= allow(new User { name: "bhavik" }, "view", new Expense { id: 0 });


# TEST: Now Cora can view the expense because Cora manager Bhavik who manager Alice
?= allow(new User { name: "cora"}, "view", new Expense { id: 0 });


### Test the policies work
?= role(new User{name: "alice"}, "employee");
?= role(new User{name: "ebrahim"}, "employee");
?= role(new User{name: "ebrahim"}, "accountant");
### 
