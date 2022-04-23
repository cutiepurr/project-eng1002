% Store menu data in a constant
MENU = ["Beef Pho", 16.20; "Shrimp Cold Roll", 7.00; "Vietnamese Roll", 10.50; "Iced Coffee", 6.50];
[menuRows, menuCols] = size(MENU);

% TODO1: Ask for customer's info: name, phone number, time, orders
name = input("Customer's name: ", "s");
phone = input("Customer's phone number: ", "s");
while isnan(str2double(phone)) || strlength(phone) ~= 10
    phone = input("Please provide a correct format of a phone number ", "s");
end

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

% Handle order
orders=[];
while order ~= 0
    if order <= menuRows && order >= 1
        numDishes = input("Quantity: ");
        orders = [orders; numDishes, MENU(order,1), str2double(MENU(order,2)) * numDishes];
        order = input("Please enter the number of the dish: ");
    else
        order = input("Please enter a valid key: ");
    end
end

% Submit the order
if order == 0
    if isempty(orders)
        disp("Ordered unsucessfully."); 
    else
        disp("Ordered successfully. Here is the receipt:");
        createreceipt(orders);
    end
end

% TODO2: Create a function to display receipt
function receipt = createreceipt(orders)
    arguments
        orders(:,3) string
    end

    % Transfer order to table for better visual
    table = array2table(orders, "VariableNames", ["QTY", "ITEM", "AMT"]); 
    % Calculate total of the receipt
    total = sum(str2double(orders(:,3)));

    % Display receipt
    disp(table)
end