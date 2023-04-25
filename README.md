# Desktop

[![pub package](https://img.shields.io/pub/v/desktop.svg)](https://pub.dartlang.org/packages/desktop)

Minimal Desktop widgets for Flutter.

* Navigation
  * Breadcrumb
  * Nav
  * Tab
  * Tree
* Data
  * List table
  * Date form field
  * Text form field
* Dialogs
  * Dialog
  * Message
  * Tooltip
  * Date picker
* Input
  * Button
  * Context menu
  * Dropdown menu
  * Hyperlink
  * Slider
  * Checkbox
  * Radio
  * Toggle switch
* Status
  * Progress indicator
* Text
  * Text field
  * Selectable text
* Scrollbar

## Gallery

### Navigation

| Breadcrumb | Nav |
| ---------- | --- |
| ![breadcrumb](assets/breadcrumb.PNG "Breadcrumb") | ![nav_vertical](assets/nav_vertical.PNG "Nav vertical") |

| Nav Horizontal | Nav Horizontal Menu |
| -------------- | ------------------- |
| ![nav_horizontal](assets/nav_horizontal.PNG "Nav horizontal") | ![nav_horizontal_menu](assets/nav_horizontal_menu.PNG "Nav horizontal with menu") |

| Tree | Custom Tree |
| ---- | ----------- |
| ![tree](assets/tree.PNG "Tree") | ![tree_custom](assets/tree_custom.PNG "Custom tree") |

| Tab | Custom Tab |
| --- | ---------- |
| ![tab](assets/tab.PNG "Tab") | ![tab_custom](assets/tab_custom.PNG "Custom tab") |

| Tab Menu | Tab Controlled |
| -------- | -------------- |
| ![tab_menu](assets/tab_menu.PNG "Tab with menu") | ![tab_controlled](assets/tab_controlled.PNG "Controlled tab") |

| Tab Positioned Bottom | Tab Positioned Left |
| --------------------- | ------------------- |
| ![tab_positioned_bottom](assets/tab_positioned_bottom.PNG "Tab positioned bottom") | ![tab_positioned_left](assets/tab_positioned_left.PNG "Tab positioned left") |

| Tab Positioned Right | Tab Positioned Rigth Menu |
| -------------------- | ------------------------- |
| ![tab_positioned_right](assets/tab_positioned_right.PNG) | ![tab_positioned_right_menu](assets/tab_positioned_right_menu.PNG "Tab positioned right with menu") |

### Data

| List Table | List Table Borderless |
| ---------- | --------------------- |
| ![list_table](assets/list_table.PNG "List table") | ![list_table_borderless](assets/list_table_borderless.PNG "List table without borders") |

| Text Form Field | Date Form Field |
| --------------- | --------------- |
| ![text_form_field](assets/text_form_field.PNG "Text form field") | ![date_form_field](assets/date_form_field.PNG "Date form field") |

### Dialogs

| Dialog | Date Picker |
| ------ | ------- |
| ![dialog](assets/dialog.PNG "Dialog") | ![date_picker](assets/date_picker.PNG "Date picker") |
| ![dialog_dismissible](assets/dialog_dismissible.PNG "Dialog dismissible") |  |

| Tooltip | Message |
| ------- | ------- |
| ![tooltip](assets/tooltip.PNG "Tooltip") | ![message_error](assets/message_error.PNG "Message error") |
|  | ![message_info](assets/message_info.PNG "Message info") |
|  | ![message_success](assets/message_success.PNG "Message success") |
|  | ![message_warning](assets/message_warning.PNG "Message warning") |

### Input

| Button | Context Menu |
| ------ | ------------ |
| ![button](assets/button.PNG "Button") | ![context_menu](assets/context_menu.PNG "Context menu") |
| ![buton_text_icon](assets/buton_text_icon.PNG "Button with text and icon") |
| ![button_filled](assets/button_filled.PNG "Filled button") |

| Drop Down Menu | Hyperlink |
| -------------- | --------- |
| ![drop_down_menu](assets/drop_down_menu.PNG "Drop down menu") | ![hyperlink](assets/hyperlink.PNG "Hyperlink") |

| Slider | Checkbox |
| ------ | -------- |
| ![slider](assets/slider.PNG "Slider") | ![checkbox](assets/checkbox.PNG "Checkbox") |

| Radio | Toggle Switch |
| ----- | ------------- |
| ![radio](assets/radio.PNG "Radio") | ![toggle_switch](assets/toggle_switch.PNG "Toggle switch") |

### Status

| Linear Progress Indicator | Circular Progress Indicator |
| ------------------------- | --------------------------- |
| ![linear_progress_bar](assets/linear_progress_bar.PNG "Linear progress bar") | ![circular_progress](assets/circular_progress.PNG "Circular progress") |

### Text

| Text Field | Selectable Text |
| ---------- | --------------- |
| ![text_field](assets/text_field.PNG "Text field") | ![selectable_text](assets/selectable_text.PNG "Selectable text") |

See [Gallery](https://adrianos42.github.io/desktop/), for more examples.

## Example

```dart
DesktopApp(
  theme: ThemeData(
    brightness: Brightness.dark,
    primaryColor: PrimaryColors.royalBlue.primaryColor,
  ),
  home: Nav(
    trailingMenu: [
      NavItem(
        title: 'settings',
        builder: (context) => NavDialog(
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(32.0),
            width: 600.0,
            child: Text(
              'Settings page',
              style: textTheme.subtitle,
            ),
          ),
        ),
        icon: Icons.settings,
      ),
    ],
    items: [
      NavItem(
        builder: (context) => Center(
            child: Text(
          'Home',
          style: textTheme.title,
        )),
        title: 'Home',
        icon: Icons.today,
      ),
      NavItem(
        builder: (context) => Center(
            child: Text(
          'Library',
          style: textTheme.title,
        )),
        title: 'Library',
        icon: Icons.today,
      ),
    ],
  ),
)
```

## Project structure

* `desktop` - The main package.
* `docs` - The folder with the html page built by the `docs_web` component.
* `docs_web` - The implementation of `desktop` documentation.
