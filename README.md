# Journal App

## Overview

The **Journal App** is a comprehensive task and category management platform designed to streamline the organization of daily tasks and projects. It allows users to create a personalized account, within which they can craft, modify, and categorize tasks for enhanced productivity and task tracking.

## User Stories

### Account Management

- **User Story #9:** As a User, Iwant to create my account so that I can have my own credentials
- **User Story #10:** As a User, Iwant to login my account so that I can access my account and link my own tasks

### Category Management

- **User Story #1:** As a User, Iwant to create a category that can be used to organize my tasks
- **User Story #2:** As a User, Iwant to edit a category to update the category's details
- **User Story #3:** As a User, Iwant to view a category to show the category detail
- **User Story #11**: As a user, I want to delete a category to better organize my tasks

### Task Management

- **User Story #4:** As a User, Iwant to create a task for a specific category so that i can organize tasks quicker
- **User Story #5:** As a User, Iwant to edit a task to Update tasks details
- **User Story #6:** As a User, Iwant to view a task to show tasks details.
- **User Story #7:** As a User, Iwant to delete a task to lessen my unnecessary daily tasks
- **User Story #8:** As a User, Iwant to view a task for today for me to remind what are my priorities for today
- **User Story #12**: :As a user, I want to mark a task as completed so that I can get that dopamine hit

### Enhanced Features

- **Filtering Today's Tasks:** Users can filter tasks scheduled for today based on their status: all tasks, active (incomplete) tasks, and completed tasks. Additionally, there's a feature to clear all completed tasks, aiding in maintaining a focused and uncluttered view of daily objectives.
- **Category Search:** A search functionality within the categories section allows users to quickly find specific categories by name, streamlining the management and access to associated tasks.
- **Category Pagination:** Category pagination offers users a seamless browsing experience by organizing categories into easily navigable pages. By presenting categories in manageable chunks, users can swiftly explore without feeling overwhelmed. This refined feature streamlines navigation, ensuring users effortlessly discover relevant content while maintaining clarity and efficiency. With intuitive pagination controls, users can swiftly locate desired categories, enhancing overall usability and satisfaction.

## **Live Demo**

Check out the live demo of the app in the link below:

[Journal App](https://mysite-pldf.onrender.com)

## **Getting Started**

### **Prerequisites**

The setups steps expect the Builds listed above to be installed on the system

### **Instructions**

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

- Clone the repository and navigate to main app directory for Ubunto

```bash
git clone git@github.com:Dng120696/Journal-App-Batch-32.git
cd Journal-App-Batch-32
```

- Clone the repository and navigate to main app directory for Windows

```bash
git clone https://github.com/Dng120696/Journal-App-Batch-32.git
cd Journal-App-Batch-32
```

- Install libraries and dependencies

```bash
bundle install
```

- Initialize the database

```bash
rails db:create
rails db:migrate
```

- Run the server

```bash
./bin/dev
```

## **System dependencies**

### **Gems**

- Devise 4.8.1
- tailwindcss-rails 2.3
- will_paginate 4.0
