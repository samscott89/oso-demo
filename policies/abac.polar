# Users can view expenses they submitted
allow(actor: User, "view", resource: Expense) if
    resource.submitted_by = actor.name;


# Accountants can view expenses from their location
allow(actor: User, "view", resource: Expense) if
    role(actor, "accountant") and
    actor.location = resource.location;


### RBAC Hierarchy
# Expense > Project > Team > Organization

# Project admins can view expenses of the project
allow(actor: User, "view", resource: Expense) if
    role(actor, "admin", new Project { id: resource.project_id });

# Project roles inherit from Team roles
role(actor: User, role, project: Project) if
    role(actor, role, new Team { id: project.team_id });

# Team roles inherit from Organization roles
role(actor: User, role, team: Team) if
    role(actor, role, new Organization { id: team.organization_id });


# Management hierarchies
allow(actor: User, "view", resource: Expense) if
    manages(actor, employee) and
    employee isa User{ name: resource.submitted_by };

manages(manager: User, employee) if
    employee = manager.employees() or
    manages(manager.employees(), employee);

# If ENV="development" is set as an environment variable
# Then allow all
allow(_user, _action, _resource) if
    new Env{}.var("ENV") = "development";
