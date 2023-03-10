% Hemligt meddelande input
plaintext = input("Hemligt meddelande: ", "s");
% Kryptering
ciphertext = Hill(plaintext);
% Visa ciphertext
disp(ciphertext)
% Setup
max_attempts = 5;
attempts = 0;
guessed_letter_idx = 1;
guessed_letters = string(zeros(100, 1)); % Börja med storlek 100 (godtycklig siffra)
correct_letter_idx = 1;
correct_letters = string(zeros(100, 1)); % Börja med storlek 100 (godtycklig siffra)
disp("Försök gissa det hemliga meddelandet! Du har " + max_attempts + " försök på dig");
disp("-START-")
% Game loop
while true
    % Låt spelare 2 gissa
    letter = "";
    while true
        guess_input = input("Gissa bokstav: ", "s"); % Ska vi gissa bokstäver eller ord? Kanske spelare 1 ska ge ledtrådar?
        letter = guess_input(1);
        is_number = any(find(string(0:9) == letter));
        if is_number
            disp("Du måste gissa på en bokstav, inte en siffra!")
            continue
        end
        letter_already_guessed = any(find(guessed_letters == letter));
        if letter_already_guessed
            disp("Du måste gissa på en ny bokstav!")
        else
            guessed_letters(guessed_letter_idx) = letter;
            guessed_letter_idx = guessed_letter_idx + 1;
            break
        end
    end

    % Svarade spelare 2 rätt?
    guess_is_successful = any(strfind(plaintext, letter));
    if guess_is_successful
        disp("Snyggt! Du fann bokstaven '" + letter + "'");
        correct_letters(correct_letter_idx) = letter;
        correct_letter_idx = correct_letter_idx + 1;
    else
        disp("Oops! Bokstaven '" + letter + "' finns inte i meddelandet");
        attempts = attempts + 1;
        disp("Du har " + (max_attempts - attempts + 1) + " försök kvar.")
    end

    Print_Guesses(guessed_letters, correct_letters, guessed_letter_idx, correct_letter_idx);

    disp("-------")

    % Har spelare 2 vunnit?
    all_letters_found = true;
    for plaintext_letter = plaintext
        letter_has_been_found = any(find(correct_letters == plaintext_letter));
        all_letters_found = all_letters_found & letter_has_been_found;
    end

    % Hur går vi vidare?
    if all_letters_found
        disp("The code was cracked! Player 2 wins.")
        disp("SECRET MESSAGE: " + plaintext)
        break
    else
        if attempts > max_attempts
            disp("The code couldn't be cracked! Player 1 wins.")
            break
        end
    end
end

disp("The game has ended. Thank you for playing!")

% Kryptera
function result = Hill(plaintext)
    result = plaintext; % Implementera hillchiffer
end

% Skriv ut rätt och fel gissningar
function Print_Guesses(all_guesses, correct_guesses, all_guess_idx, correct_guess_idx)
    fprintf("%s ", "Rätt gissningar: " + correct_guesses(1));
    for correct_letter = correct_guesses(2:correct_guess_idx-1)
        fprintf("%s ", ", " + correct_letter); 
    end
    fprintf('\n');
    if all_guess_idx > correct_guess_idx
        wrong_guesses = setdiff(all_guesses, correct_guesses);
        fprintf("%s ", "Fel gissningar: " + wrong_guesses(1));
        for wrong_letter = wrong_guesses(2:end)
            fprintf("%s ", ", " + wrong_letter); 
        end
        fprintf('\n');
    end
end