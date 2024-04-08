# Task Management App

This is a simple Flutter application for managing tasks.
## Getting Started

1. Clone this repository to your local machine:
   Github Clone-https://github.com/Traicywhitney/flutter_task_sharedpreference.git



Sure, here's a brief overview of the functionality of the provided Flutter application:

Task Management Application: This application helps users manage their tasks by allowing them to add, view, update, and delete tasks.

Task Screen (TaskList):

Displays a list of tasks.
* Users can add a new task by tapping the floating action button.
* Each task item in the list shows the title, description, and completion status.
* Long-pressing on a task item opens the update details screen.

Task Details Screen:

* Users can view and edit the details of a task on this screen.
* The screen includes text fields for entering or updating the title and description of the task.
* Users can save the changes by tapping the "Save" button.
* Error handling and validation are implemented to ensure that the title and description fields are not empty before saving.

Update Details Screen:

* Similar to the Task Details Screen, but also includes a delete button.
* Users can delete the task by tapping the delete button, which prompts for confirmation.
* Upon deletion, the task is removed from the list, and a success message is displayed.

Shared Preferences:

* Task data is stored locally using the shared_preferences package, allowing tasks to persist across app sessions.
* Task data is saved as a list of JSON strings in the shared preferences.

Styling and Toast Messages:

* The application UI is styled using colors defined in the code and the flutter_styled_toast package.
* Toast messages are displayed to provide feedback on task creation, update, and deletion.