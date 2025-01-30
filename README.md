To execute this **mini compiler** (Lexer and Parser) on **Mac, Windows, and Linux**, follow these steps:

---

## **🔹 1. Install Required Tools**
You need **Flex** (Lexical Analyzer) and **Bison** (Parser Generator).

### **📌 MacOS**
Use Homebrew to install:
```sh
brew install flex bison
```
Mac's built-in `bison` is outdated, so ensure you use Homebrew’s version:
```sh
export PATH="$(brew --prefix bison)/bin:$PATH"
```

### **📌 Windows**
- Install **MSYS2** from [https://www.msys2.org/](https://www.msys2.org/)
- Open **MSYS2 terminal** and install Flex & Bison:
  ```sh
  pacman -S flex bison
  ```
- Alternatively, you can use **Cygwin** and install Flex & Bison from the installer.

### **📌 Linux (Ubuntu, Debian, Fedora)**
For Debian-based systems (Ubuntu, Kali, etc.):
```sh
sudo apt update && sudo apt install flex bison -y
```
For Fedora:
```sh
sudo dnf install flex bison -y
```

---

## **🔹 2. Compile the Mini Compiler**
### **Step 1: Generate the Lexer**
```sh
flex final.l
```
This generates `lex.yy.c`.

### **Step 2: Generate the Parser**
```sh
bison -d final.y
```
This produces:
- `final.tab.c` (Parser Implementation)
- `final.tab.h` (Token Definitions)

### **Step 3: Compile the C Files**
```sh
gcc -o final lex.yy.c final.tab.c -ll
```
- `-o final` → Output executable named `final`
- `-ll` → Links `libfl` (Flex library)

For **MacOS**, if you face issues, try:
```sh
gcc -o final lex.yy.c final.tab.c -ll -Wall
```

For **Windows (MinGW users)**:
```sh
gcc -o final.exe lex.yy.c final.tab.c -ll
```

---

## **🔹 3. Run the Compiler**
Run the compiled executable and input code **directly in the terminal**.

For **Mac/Linux**:
```sh
./final
```
For **Windows**:
```sh
./final.exe
```

Now, type your **C-like code** (e.g., variable declarations, loops, conditionals).  
To **end input**, press **Ctrl+D** (Mac/Linux) or **Ctrl+Z + Enter** (Windows).

### **Example Input**
```c
int a;
a = 5;
if (a > 3) { 
    a = 10; 
} else { 
    a = 2; 
}
```
### **Expected Output**
```
Valid Syntax
```

---

## **🔹 4. Debugging Errors**
If you enter **incorrect syntax**, the parser should **print the error with line numbers**.

**Example Input (with errors):**
```c
int a
a = 5;
if (a > 3 {  // Missing ')'
    a = 10;
}
```
**Expected Output:**
```
Syntax Error at line 3: syntax error
```

---

## **🔹 5. Running from a File**
Instead of typing manually, you can **redirect input from a file**.

1. **Create a test file (`test.txt`)**:
   ```c
   int a;
   a = 5;
   if (a > 3) { 
       a = 10; 
   } else { 
       a = 2; 
   }
   ```
   
2. **Run the parser with the file as input**:
   ```sh
   ./final < test.txt
   ```
   **Expected Output:**
   ```
   Valid Syntax
   ```
