--Name: Chris Gunter
--Date: February 16, 2018

--Purpose: This program finds Palendromes.
--Input is read through a file by standard input by each line.
--Each line is processed through different stages to determine if it
-- is a palendrome.
--Input is assumed to be valid.
--Sample input:
--eve
--!eve!
--Eve
--Corresponding output:
--Palindrome as entered.
--Palindrome as entered.
--Palindrome when converted to upper case.

--Help recieved: The Algorithm for reversing the string was used on
--rosettacode.org

with ada.text_io, ada.characters.handling;
use ada.text_io, ada.characters.handling;
procedure pal_finder is

   ---------------------------------------------------------
   -- Purpose: Reverses a string
   -- Parameters: txt: string to be reversed.
   -- Precondition:
   -- Postcondition: Returns txt in reverse.
   ---------------------------------------------------------
   function reverseString (txt : String) return String is
      resultString : String (txt'Range);
   begin
      for i in txt'range loop
         resultString(resultString'last - i + txt'first) := txt(i);
      end loop;
      return resultString;
   end reverseString;

   -------------------------------------------------------------------
   -- Purpose: Converts string to uppercase then determines palindrome.
   -- Parameters: txt: String to be capitalized.
   -- Precondition:
   -- Postcondtion: Returns a boolean signifying palindrome.
   -------------------------------------------------------------------
   function toCapitals (txt : String) return Boolean is
      resultString: String (txt'range);
      txtCopy: String := txt;
      key: Boolean := false;
   begin
      resultString := To_Upper(txt);
      txtCopy := To_Upper(txt);
      resultString := reverseString(resultString);
      if(txtCopy = resultString) then
         key := true;
      end if;
      return key;
   end toCapitals;

   -----------------------------------------------------------------
   -- Purpose: Removes characters from string.
   -- Parameters: txt: String to be modified.
   -- Precondition:
   -- Postcondition: Returns a boolean signifying palindrome.
   -----------------------------------------------------------------
   function removeChars (txt : String) return Boolean is
      type symbols is ('!','@','#','$','%','^','&',' ','*');
      copyTxt: String := txt;
      evenTxt: String(1..copyTxt'length-1);
      normTxt: String(txt'range);
      evenTxtCopy: String(1..copyTxt'length-1);
      normTxtCopy: String(txt'range);
      switcher: Boolean := false;
      key: Boolean := false;
      Even_Num: Integer := 2;
   begin
      if copyTxt'length mod Even_Num = 0 then --determine even to odd
         for i in copyTxt'range loop
            if copyTxt(i) in '!'..'*' then
               copyTxt(i) := '|';    --sets all symbols to |
            elsif copyTxt(i) = ' ' then
               copyTxt(i) := '|';
            end if;
         end loop;
         evenTxt := copyTxt(1..copyTxt'length-1); --turns even odd.
         switcher := true;
      else
         normTxt := copyTxt;
      end if;
      if switcher then
         evenTxtCopy := reverseString(evenTxt);
      else                                       -- which set to use
         normTxtCopy := reverseString(normTxt);
      end if;
      if normTxt = normTxtCopy or evenTxt = evenTxtCopy then
         key := true;
      end if;
      return key;
   end removeChars;

   ---------------------------------------------------------------------
   -- Purpose to determine the state of a palindrome
   -- Parameters: txt, stateSet: String for palindrome and set for state.
   -- Precondition:
   -- Postcondition: Modifies the state.
   ---------------------------------------------------------------------
   procedure palindrome (txt : String; stateSet : out Integer) is
      reverseTxt: String := reverseString(txt);
      upperTxt: Boolean := toCapitals(txt);
      --remChars: Boolean := removeChars(txt);
      State_One: Integer := 1;
      State_Two: Integer := 2;
      --State_Three: Intger := 3;
      begin
      if txt = reverseTxt then
         stateSet := State_One;
      elsif upperTxt then
         stateSet := State_Two;
      --There was an elsif here to use the removeChars method.
      --But it does not work. The only case that worked was the last
      --one.
      end if;
   end palindrome;

begin
   while not End_Of_File loop
      declare --could not figure out how to do it the way taught.
              --but after 3 or 4 hours found this way worked.
         str: String := ada.text_io.get_line;
         setNum: Integer := 0;
         State_One: Integer := 1;
         State_Two: Integer := 2;
      begin
         put_line("String: """ & str & """");
         palindrome(str,setNum);
         if setNum = State_One then
            put_line("Status: Palindrome as entered.");
         elsif setNum = State_Two then
            put_line("Status: Palindrome when converted to upper case.");
         end if;
         put_line("");
      end;
   end loop;
end pal_finder;
