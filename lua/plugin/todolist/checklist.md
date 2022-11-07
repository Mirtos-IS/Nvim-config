
Checklist for property is being ignore, so two things that should be happening are not:

1. when creating a project, it should be using the checklist choosen, not the default
2. when changing the default, old/in progress projects shouldn't be updated

When creating a project with default checklist, we don't lock to expired/completed or started
projects. We don't even have a good way to do it rn.

    2 possible solutions:

1. All projects have their checklist saved, even default. when changing property's default,
it checks and changes all future projects

2. leave how it is rn and check for projects that have being started/expired/completed and
save the old default as their checklist


2 seems better, less work

needs to:
    1. check for non-update projects
    2. save them before changing default
    3. keep the code how it is rn
