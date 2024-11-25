# Order Management App

## 1. Introduction
**App Name:** Order Management App

**Objective:**  
A Flutter application to streamline the process of creating and managing orders by allowing users to input order details interactively, with added features for product suggestions, notes, and images.

---

## 2. Project Overview

### Core Features:
**Dynamic Rows for Order Entry:**  
- Editable Order ID.  
- A table with dynamic rows for Quantity and Product inputs.  
- Automatic addition of new rows when all available rows are filled.

**Product Field Functionalities:**  
1. **Suggestions:** Shows product suggestions as the user types.  
2. **Long Press Actions:**  
   - **Add Note:** Attach notes to the product.  
   - **Add Image:** Open the gallery to pick an image.  

**Empty Row Focus:**  
- Clicking on a row with empty fields above automatically focuses on the first empty field.  

**Data Submission:**  
- After filling at least one row, users can:  
   - Clear Data: Reset all entries.  
   - Go to Order Page: Navigate to a summary of order details.  

---

## 3. App Workflow

### Main Screen (Order Entry):
- Displays an editable Order ID field.  
- Shows a dynamic table with two columns: Quantity and Product.  
- New rows are automatically added when all the current rows are filled with valid data (e.g., a quantity and product are provided for all existing rows).
- Product Field Functionalities:  
  - Type to see product suggestions.  
  - Long press to access:  
    - **Add Note:** Opens a text input modal to attach a note.  
    - **Add Image:** Opens the gallery to select an image.  
- Auto-focus behavior ensures the first empty field is filled before proceeding.  
- Enables navigation buttons (Clear Data and Go to Order Page) after at least one row is filled.  

### Order Details Screen:
- Displays a summary of the entered order details.

---

## 5. Features
1. **Dynamic Row Addition**  
   - Users can add unlimited rows using the FAB.  
   - Rows dynamically update the state using GetX.  

2. **Product Field with Advanced Actions**  
   - **Suggestions:** On typing, products are suggested using API data fetched with GetX.  
   - **Add Note:**  
     - Long press opens a modal for note entry.  
     - Notes are attached to the specific product in the backend.  
   - **Add Image:**  
     - Long press opens the gallery.  
     - Image selection is handled via the image_picker package.  

3. **Auto-focus Empty Rows**  
   - Ensures seamless navigation between rows by focusing on the first empty field above the selected row.  

4. **Navigation Buttons**  
   - **Clear Data:** Clears all input fields.  
   - **Go to Order Page:** Transitions to the next screen with order details.  

---

## 6. Technical Highlights
**Responsive Design:**  
- Achieved using `flutter_screenutil` for consistent layouts across devices.  

**State Management:**  
- GetX simplifies reactive state updates, API calls, and navigation.  

**Gallery Access:**  
- Integrated using the `image_picker` library for seamless image selection.  

---
