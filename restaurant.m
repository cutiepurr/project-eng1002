% Store menu data in a constant
MENU = ["Beef Pho", 16.20; "Shrimp Cold Roll", 7.00; "Vietnamese Roll", 10.50; "Iced Coffee", 6.50];
[menuRows, menuCols] = size(MENU);

% TODO1: Ask for customer's info: name, phone number, time, orders
name = input("Customer's name: ", "s");
phone = input("Customer's phone number: ", "s");
while isnan(str2double(phone)) || strlength(phone) ~= 10
    phone = input("Please provide a correct format of a phone number ", "s");
end

% display menu and instruction
displayMenu(MENU);
displayInstruction();

% ask for order
order = input("Please enter dish number: ");

% Handle order
orders=[];
while order ~= 0
    if order <= menuRows && order >= 1
        numDishes = input("Quantity: ");
        orders = [orders; numDishes, MENU(order,1), str2double(MENU(order,2)) * numDishes];
        order = input("Please enter dish number: ");
    else
        order = input("Please enter a valid key: ");
    end
end

% Submit the order
if order == 0
    if isempty(orders)
        disp("Ordered unsucessfully."); 
    else
        disp("Your Order (Quantity - Item): ");
        disp(orders(:,1:2));
        createreceipt(orders, name, phone);
    end
end

% display menu
function [] = displayMenu(menu)
    disp("=============MENU=============");
    for i = 1: size(menu,1)
        fprintf("(%d): %s - $%.2f\n", i, menu(i,1), menu(i,2));
    end
    fprintf("==============================\n\n");
end

% display instruction
function [] = displayInstruction()
    disp("***INSTRUCTION***")
    disp("To order a dish, please enter the number associated with that dish.");
    fprintf("To finish the order, press key 0.\n\n");
end

% TODO2: Create a function to display receipt
function [] = createreceipt(orders, customerName, customerPhone)
    arguments
        orders(:,3) string
        customerName string
        customerPhone string
    end
    % Record time of completing order
    currentTime = datetime("now");

    % Calculate total of the receipt
    total = sum(str2double(orders(:,3)));
    
    disp("Rendering receipt...")

    % format head, body, and tail of the receipt
    headFormat = "_________________________________________\n" + ...
        "                Vietnamese\n               Restaurant\n\n" + ...
        "                 RECEIPT\n" + ...
        "   %s\nCustomer: %s\nPhone Number: %s\n\n";
    tailFormat = "\nTotal: $%.2f\n" + ...
        "                THANK YOU!\n" + ...
        "_________________________________________";
    orderFormat = format(orders);
    
    % save receipt as txt file
    receiptFilename = sprintf("%s.txt", currentTime);
    receiptFile = fopen(receiptFilename,"w");
    fprintf(receiptFile, headFormat,  currentTime, upper(customerName), customerPhone);
    fprintf(receiptFile, orderFormat);
    fprintf(receiptFile, tailFormat, total);
    fclose(receiptFile);
    fprintf("Receipt saved as %s.txt", currentTime);
end

% format order
function [orderFormat] = format(orders)
    orderFormat = "";
    for i=1:size(orders, 1)
        quantity = orders(i, 1);
        item = orders(i, 2);
        amt = orders(i, 3);
        
        % format quantity string
        quantity = quantity + " x\t";

        % format item string
        spaceNeeded = 20 - strlength(item);
        for j=1:spaceNeeded
            item = item + " ";
        end

        % format amt string
        amt = sprintf("$%.2f", amt);

        orderFormat = orderFormat + quantity + item + amt + "\n";
    end
end