import sys

def number_letter(name, value:str):
    return {"text": name, "value": value}

letter_numbers = {
        "o": [number_letter("one", "1")],
        "t": [number_letter("two", "2"), number_letter("three", "3")],
        "f": [number_letter("four", "4"), number_letter("five","5")],
        "s": [number_letter("six", "6"),number_letter("seven","7")],
        "e": [number_letter("eight", "8")],
        "n": [number_letter("nine", "9")]
        }


def Main():
    if len(sys.argv) < 2:
        print("Invalid file path!")
        exit(1)
    file_path = sys.argv[1]
    f = open(file_path, "r")
    result = 0

    for line in f:
        first_num = ""
        last_num = ""        
        index = 0
        while index < len(line):
            char = line[index]
            if char.isdigit():
                if first_num == "":
                    first_num = char
                    last_num = char
                else:
                    last_num = char
            else:
                if char in letter_numbers:
                    numbersList = letter_numbers[char]
                    for ln in numbersList:
                        ln_length = len(ln["text"])
                        word = line[index: index + ln_length]
                        if word == ln["text"]:
                            if first_num == "":
                                first_num = ln["value"]
                                last_num = ln["value"]
                            else:
                                last_num = ln["value"]
                            break
            index += 1
        num = int(first_num+last_num)
        result = result + num
    f.close()


    print(f"sum of all of the calibration = {result}")



if __name__ == "__main__":
    Main()