% Store menu data in a constant
MENU = ["Beef Pho", 16.20; "Shrimp Cold Roll", 7.00; "Vietnamese Roll", 10.50; "Iced Coffee", 6.50];
[menuRows, menuCols] = size(MENU);

% TODO1: Ask for customer's info: name, phone number, time, orders
name = input("Customer's name: ", "s");
phone = input("Customer's phone number: ", "s");

% Display menu
disp("=============MENU=============");
for i = 1: menuRows
    fprintf("(%d): %s - $%.2f\n", i, MENU(i,1), MENU(i,2));
end
fprintf("==============================\n\n");

% Give instruction and take order
disp("***INSTRUCTION***")
disp("To order a dish, please enter the number associated with that dish.");
fprintf("To finish the order, press key 0.\n\n");
order = input("Please enter the number of the dish: ");


% TODO2: Create a function to display receipt
