; syscall
    sys_read equ 0
    sys_write equ 1
    sys_open equ 2
    sys_close equ 3
    sys_lseek equ 8
    sys_create equ 85
    sys_unlink equ 87
    sys_exit equ 60

    stdin equ 0
    stdout equ 1
    stderr equ 3

; access mode 
    O_RDONLY equ 0q000000
    O_WRONLY equ 0q000001
    O_RDWR equ 0q000002
    O_CREAT equ 0q000100
    O_APPEND equ 0q002000

; create premission mode 
    sys_IRUSR equ 0q400     ; user read premission
    sys_IWUSR equ 0q200     ; user write premission

; user define constant 
    NewLine equ 0xA
    bufferlen equ 256

section .data
    fileNameSrc db "newinput.txt", 0
    FDsrc dq 0 ; file descriptor

    fileNameDes db "newoutput.txt", 0
    FDdes dq 0 ; file descriptor
    error_create db "error in creating file ", NewLine, 0
    error_close db "error in closing file ", NewLine, 0
    error_write db "error in writing file ", NewLine, 0
    error_open db "error in opening file ", NewLine, 0
    error_append db "error in appending file ", NewLine, 0
    error_delete db "error in deleting file ", NewLine, 0
    error_read db "error in reading file ", NewLine, 0
    error_print db "error in printing file ", NewLine, 0
    error_seek db "error in seeking file ", NewLine, 0

    suces_create db "file created and opened for R/W ", NewLine, 0
    suces_close db "file closed ", NewLine, 0
    suces_write db "written to file ", NewLine, 0
    suces_open db "file opend for R/W ", NewLine, 0
    suces_append db "file apened for appending ", NewLine, 0
    suces_delete db "file deleted ", NewLine, 0
    suces_read db "reading file ", NewLine, 0
    suces_seek db "seeking file ", NewLine, 0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ; some notaions that may help us on tokenizing.
    comma db ","
    plus db "+"
    star db "*"
    open_bracket db "["
    close_bracket db "]"
    space db " "
    ptr_word db "ptr"
    byte_word db "byte"
    word_word db "word"
    dword_word db "dword"
    qword_word db "qword"
    stc_word db "stc"
    clc_word db "clc"
    std_word db "std"
    cld_word db "cld"
    bsf_word db "bsf"
    bsr_word db "bsr"
    inc_word db "inc"
    dec_word db "dec"
    syscall_word db "syscall"
    x0_letter db "0x"
    i_letter db "i"
    n_letter db "n"
    c_letter db "c"
    d_letter db "d"
    e_letter db "e"
    length dq 0
    found db 1
    rex dq "0100"
    mod_00 dq "00"
    mod_01 dq "01"
    mod_10 dq "10"
    mod_11 dq "11"
    seq_0 dq "0000"
    seq_1 dq "0001"
    seq_2 dq "0010"
    seq_3 dq "0011"
    seq_4 dq "0100"
    seq_5 dq "0101"
    seq_6 dq "0110"
    seq_7 dq "0111"
    seq_8 dq "1000"
    seq_9 dq "1001"
    seq_a dq "1010"
    seq_b dq "1011"
    seq_c dq "1100"
    seq_d dq "1101"
    seq_e dq "1110"
    seq_f dq "1111"
    seq_0101 dq "0101"
    seq_101 dq "101"
    seq_0000 dq "0000"
    seq_11111001 dq "11111001"
    seq_11111000 dq "11111000"
    seq_11111101 dq "11111101"
    seq_11111100 dq "11111100"
    seq_111111 dq "111111"
    seq_0000111100000101 dq "0000111100000101"
    defined_address_prefix dq "01100111"
    defined_operand_prefix dq "01100110"
    seq_100 dq "100"
    newline dq 0xa
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; registers
    registers_name db "al??", "cl??", "dl??", "bl??", "ah??", "ch??", "dh??", "bh??", "r8b?", "r9b?", "r10b", "r11b", "r12b", "r13b", "r14b", "r15b", "ax??", "cx??", "dx??", "bx??", "sp??", "bp??", "si??", "di??", "r8w?", "r9w?", "r10w", "r11w", "r12w", "r13w", "r14w", "r15w", "eax?", "ecx?", "edx?", "ebx?", "esp?", "ebp?", "esi?", "edi?", "r8d?", "r9d?", "r10d", "r11d", "r12d", "r13d", "r14d", "r15d", "rax?", "rcx?", "rdx?", "rbx?", "rsp?", "rbp?", "rsi?", "rdi?", "r8??", "r9??", "r10?", "r11?", "r12?", "r13?", "r14?", "r15?"
    registers_code db "0000", "0001", "0010", "0011", "0100", "0101", "0110", "0111", "1000", "1001", "1010", "1011", "1100", "1101", "1110", "1111", "0000", "0001", "0010", "0011", "0100", "0101", "0110", "0111", "1000", "1001", "1010", "1011", "1100", "1101", "1110", "1111", "0000", "0001", "0010", "0011", "0100", "0101", "0110", "0111", "1000", "1001", "1010", "1011", "1100", "1101", "1110", "1111", "0000", "0001", "0010", "0011", "0100", "0101", "0110", "0111", "1000", "1001", "1010", "1011", "1100", "1101", "1110", "1111"
    registers_size db "8???", "8???", "8???", "8???", "8???", "8???", "8???", "8???", "8???", "8???", "8???", "8???", "8???", "8???", "8???", "8???", "16??", "16??", "16??", "16??", "16??", "16??", "16??", "16??", "16??", "16??", "16??", "16??", "16??", "16??", "16??", "16??", "32??", "32??", "32??", "32??", "32??", "32??", "32??", "32??", "32??", "32??", "32??", "32??", "32??", "32??", "32??", "32??", "64??", "64??", "64??", "64??", "64??", "64??", "64??", "64??", "64??", "64??", "64??", "64??", "64??", "64??", "64??", "64??"
    operators_name db "add??????", "or???????", "adc??????", "sbb??????", "and??????", "sub??????", "xor??????", "cmp??????", "inc??????",  "dec??????",  
    operators_r db "000000???", "000010???", "000100???", "000110???", "001000???", "001010???", "001100???", "001110???", "111111000", "111111001"
    operators_i db "100000000", "100000001", "100000010", "100000011", "100000100", "100000101", "100000110", "100000111"
    operators_a db "000001???", "000011???", "000101???", "000111???", "001001???", "001011???", "001101???", "001111???"
    number_names db "0???", "1???", "2???", "3???", "4???", "5???", "6???", "7???", "8???", "9???", "a???", "b???", "c???", "d???", "e???", "f???"
    number_codes db "0000", "0001", "0010", "0011", "0100", "0101", "0110", "0111", "1000", "1001", "1010", "1011", "1100", "1101", "1110", "1111"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
section .bss
    finish resq 1
    whole_file resq 10000
    operator_name resq 1
    op1 resq 30
    op2 resq 30
    op_trash resq 30
    disp_trash resq 10
    start_of_line resq 1
    mov_seen resq 1
    search resq 30
    size resq 1
    search_len resq 1
    op1_type resq 1
    op1_name resq 1
    op1_code resq 1
    op1_size resq 1
    op2_type resq 1
    op2_name resq 1
    op2_code resq 1
    op2_size resq 1
    op_size resq 1
    op_name resq 1
    op_code resq 1
    inx_code resq 1
    inx_size resq 1
    bas_code resq 1
    bas_size resq 1
    operand_size resq 1
    address_size resq 1
    mov_len resq 1
    line resq 20
    index resq 1
    mem_size resq 5
    search_limit resq 100
    rex_w resq 1
    rex_r resq 1
    rex_x resq 1
    rex_b resq 1
    opcode resq 5
    operator_code resq 5
    ops resq 1
    d resq 1
    s resq 1
    code_w resq 1
    mod resq 1
    reg resq 5
    rm resq 5
    output resq 30
    output_end resq 1
    sw resq 1
    zero resq 1
    prefix_return resq 2
    swap_box resq 20
    disp resq 10
    data resq 10
    sss resq 5
    inx resq 5
    bas resq 5
    address_prefix resq 5
    operand_prefix resq 5
    len resq 1
    len_seen resq 1
    fill_len resq 1
    gather_pointer resq 1
    reg_by_code_input1 resq 3
    reg_by_code_input2 resq 3
    reg_by_code_output resq 3
    rex_valid resq 1

section .text
global _start
printString:
    push rax
    push rsi
    push rdx
    push rdi

    mov rsi, rdi    ; string to write
    call GetStrlen
    mov rax, sys_write
    mov rdi, stdout
    syscall

    pop rdi
    pop rdx
    pop rsi
    pop rax
    ret

GetStrlen:
    push rbx
    push rcx
    push rax

    xor rcx, rcx
    not rcx
    xor rax, rax
    cld
    repne scasb
    not rcx
    lea rdx, [rcx - 1]  ; length in rdx

    pop rax
    pop rcx
    pop rbx
    ret

; rdi : file name, rsi : file access mode 
; rdx: file permission, do not need
openFile:
    mov rax, sys_open
    mov rsi, O_RDWR
    syscall
    cmp rax, -1     ; file descriptor in rax
    jle openerror
    mov rdi, suces_open
    push rax
    call printString
    pop rax
    ret
openFileA:
    mov rax, sys_open
    mov rsi, 0q002002
    syscall
    cmp rax, -1     ; file descriptor in rax
    jle appenderror
    mov rdi, suces_append
    push rax
    call printString
    pop rax
    ret
openerror:
    mov rdi, error_open
    call printString
    ret
appenderror:
    mov rdi, error_append
    call printString
    ret
; rdi : file descriptor, rsi : buffer, rdx : length
writeFile:
    mov rax, sys_write
    syscall
    cmp rax, -1     ; number of written byte
    jle writeerror
    mov rdi, suces_write
    call printString
    ret
writeerror:
    mov rdi, error_write
    call printString
    ret

; rdi : file descriptor, rsi : buffer, rdx : length
readFile:
    mov rax, sys_read
    syscall
    cmp rax, -1     ; number of read byte
    jle readerror
    mov byte [rsi + rax], 0     ; add a zero
    mov rdi, suces_read
    call printString
    ret
readerror:
    mov rdi, error_read
    call printString
    ret

; rdi : file descriptor
closeFile:
    mov rax, sys_close
    syscall
    cmp rax, -1     ; 0 successful
    jle closeerror
    mov rdi, suces_close
    call printString
    ret
closeerror:
    mov rdi, error_close
    call printString
    ret

_start:
    mov rsi, reg_by_code_input1
    mov rdi, 12
    call empty_
    mov rsi, reg_by_code_input2
    mov rdi, 12
    call empty_    
    mov rsi, reg_by_code_output
    mov rdi, 12
    call empty_
    mov rsi, ops
    mov rdi, 12
    call empty_
    mov rsi, start_of_line
    mov rdi, 12
    call empty_
    mov rsi, finish
    mov rdi, 12
    call empty_
    mov rsi, whole_file
    mov rdi, 300
    call empty_
    mov rsi, operator_name
    mov rdi, 12
    call empty_
    mov rsi, d
    mov rdi, 12
    call empty_
    mov rsi, s
    mov rdi, 12
    call empty_
    mov rsi, op1
    mov rdi, 80
    call empty_
    mov rsi, op2
    mov rdi, 80
    call empty_
    mov rsi, op_trash
    mov rdi, 80
    call empty_
    mov rsi, start_of_line
    mov rdi, 12
    call empty_
    mov rsi, op1_code
    mov rdi, 12
    call empty_
    mov rsi, gather_pointer
    mov rdi, 12
    call empty_
    mov rsi, disp_trash
    mov rdi, 20
    call empty_
    mov rsi, op2_code
    mov rdi, 12
    call empty_
    mov rsi, opcode
    mov rdi, 12
    call empty_
    mov rsi, op_code
    mov rdi, 12
    call empty_
    mov rsi, operand_size
    mov rdi, 12
    call empty_
    mov rsi, inx_code
    mov rdi, 12
    call empty_
    mov rsi, inx_size
    mov rdi, 12
    call empty_
    mov rsi, bas_code
    mov rdi, 12
    call empty_
    mov rsi, bas_size
    mov rdi, 12
    call empty_
    mov rsi, address_size
    mov rdi, 12
    call empty_
    mov rsi, mov_len
    mov rdi, 12
    call empty_
    mov rsi, rex_w
    mov rdi, 12
    call empty_
    mov rsi, rex_r
    mov rdi, 12
    call empty_
    mov rsi, rex_x
    mov rdi, 12
    call empty_
    mov rsi, rex_b
    mov rdi, 12
    call empty_
    mov rsi, operator_code
    mov rdi, 12
    call empty_
    mov rsi, zero
    mov rdi, 12
    call empty_
    mov rsi, reg
    mov rdi, 12
    call empty_
    mov rsi, disp
    mov rdi, 12
    call empty_
    mov rsi, data
    mov rdi, 12
    call empty_
    mov rsi, sss
    mov rdi, 12
    call empty_
    mov rsi, inx
    mov rdi, 12
    call empty_
    mov rsi, bas
    mov rdi, 12
    call empty_
    mov rsi, reg
    mov rdi, 12
    call empty_
    mov rsi, rm
    mov rdi, 12
    call empty_
    mov rsi, rex_valid
    mov rdi, 12
    call empty_
    mov rsi, op_name
    mov rdi, 12
    call empty_
    mov rsi, op_size
    mov rdi, 12
    call empty_
    mov rsi, address_prefix
    mov rdi, 12
    call empty_
    mov rsi, operand_prefix
    mov rdi, 12
    call empty_
    mov rsi, len
    mov rdi, 12
    call empty_

;;;;;;;;;;;;;;;;;   we cleared all memories.   ;;;;;;;;;;;;;;;;;;
    mov rax, output
    mov qword [output_end], rax
    ; output_end as a pointer will go further after each writing and always points to the end of "output"
    mov rdi, fileNameSrc
    call openFile
    mov [FDsrc], rax

    mov rdi, [FDsrc]
    mov rsi, whole_file
    mov rdx, 10000
    call readFile
; now we have all information in "whole_file", and "rbp" as a pointer.
    mov rsi, whole_file
    mov rdi, line
    dec rsi
    dec rdi
line_loop:
    inc rsi
    inc rdi
    mov al, [rsi]
    cmp al, NewLine
    je line_seen
    cmp al, 0x0
    je file_finished
    mov [rdi], al
    jmp line_loop
line_seen:
    inc rsi
; we keep track to where we start again, "[start_of_line]"
    mov qword [start_of_line], rsi
    mov rsi, line
    jmp line_seen_continue
file_finished:
    mov rsi, line
    mov qword [index], rsi
    mov byte [finish], 0x31
line_seen_continue:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;#///////////////////////////////////////////////No Operands///////////////////////////////////////////////
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    mov rsi, search
    mov rdi, 30
    call empty_
    mov rsi, seq_0000111100000101
    mov rdi, search
    mov qword [mov_len], 16
    mov byte [mov_seen], 0x0
    call mov_
    mov rsi, line
    mov qword [search_len], 16
    mov qword [search_limit], 30
    call search_
    cmp rsi, -1
    jne ops0_1

    mov rsi, search
    mov rdi, 30
    call empty_
    mov rsi, seq_11111100
    mov rdi, search
    mov qword [mov_len], 8
    mov byte [mov_seen], 0x0
    call mov_
    mov rsi, line
    mov qword [search_len], 8
    mov qword [search_limit], 30
    call search_
    cmp rsi, -1
    jne ops0_2

    mov rsi, search
    mov rdi, 30
    call empty_
    mov rsi, seq_11111101
    mov rdi, search
    mov qword [mov_len], 8
    mov byte [mov_seen], 0x0
    call mov_
    mov rsi, line
    mov qword [search_len], 8
    mov qword [search_limit], 30
    call search_
    cmp rsi, -1
    jne ops0_3

    mov rsi, search
    mov rdi, 30
    call empty_
    mov rsi, seq_11111000
    mov rdi, search
    mov qword [mov_len], 8
    mov byte [mov_seen], 0x0
    call mov_
    mov rsi, line
    mov qword [search_len], 8
    mov qword [search_limit], 30
    call search_
    cmp rsi, -1
    jne ops0_4

    mov rsi, search
    mov rdi, 30
    call empty_
    mov rsi, seq_11111001
    mov rdi, search
    mov qword [mov_len], 8
    mov byte [mov_seen], 0x0
    call mov_
    mov rsi, line
    mov qword [search_len], 8
    mov qword [search_limit], 30
    call search_
    cmp rsi, -1
    jne ops0_5
    jmp prefix_sec
ops0_1:     ; syscall
    mov rsi, syscall_word
    mov rdi, 7
    call print_as_output
    jmp next_line
ops0_2:     ; cld
    mov rsi, cld_word
    mov rdi, 3
    call print_as_output
    jmp next_line
ops0_3:     ; std
    mov rsi, std_word
    mov rdi, 3
    call print_as_output
    jmp next_line
ops0_4:     ; clc
    mov rsi, clc_word
    mov rdi, 3
    call print_as_output
    jmp next_line
ops0_5:     ; stc
    mov rsi, stc_word
    mov rdi, 3
    call print_as_output
    jmp next_line
;    #----------------------------------------------- PREFIX ----------------------------------------------- 
prefix_sec:
    mov rsi, search
    mov rdi, 30
    call empty_
    mov rsi, defined_operand_prefix
    mov rdi, search
    mov qword [mov_len], 8
    call mov_
    mov rsi, qword [index]
    mov qword [search_len], 8
    mov qword [search_limit], 20
    call search_
    cmp rsi, -1
    je prefix_sec1
    mov byte [operand_prefix], 0x31
    add qword [index], 8
prefix_sec1:
    mov rsi, search
    mov rdi, 30
    call empty_
    mov rsi, defined_address_prefix
    mov rdi, search
    mov qword [mov_len], 8
    call mov_
    mov rsi, qword [index]
    mov qword [search_len], 8
    mov qword [search_limit], 10
    call search_
    cmp rsi, -1
    je rex_sec
    mov byte [operand_prefix], 0x31
    add qword [index], 8
;    #----------------------------------------------- REX ----------------------------------------------- 
rex_sec:
    mov rsi, search
    mov rdi, 30
    call empty_
    mov rsi, rex
    mov rdi, search
    mov qword [mov_len], 4
    call mov_
    mov rsi, qword [index]
    mov qword [search_len], 4
    mov qword [search_limit], 4
    call search_
    cmp rsi, -1
    jne rex_sec1
    mov byte [rex_w], 0x30
    mov byte [rex_r], 0x30
    mov byte [rex_x], 0x30
    mov byte [rex_b], 0x30
    jmp opcode_sec
rex_sec1:
    mov byte [rex_valid], 0x31
    mov rax, qword [index]
    add rax, 4
    xor rbx, rbx
    mov bl, byte [rax]
    mov byte [rex_w], bl
    inc rax
    xor rbx, rbx
    mov bl, byte [rax]
    mov byte [rex_r], bl
    inc rax    
    xor rbx, rbx
    mov bl, byte [rax]
    mov byte [rex_x], bl
    inc rax    
    xor rbx, rbx
    mov bl, byte [rax]
    mov byte [rex_b], bl
    inc rax
    mov qword [index], rax
;    #----------------------------------------------- OPCODE ----------------------------------------------- 
opcode_sec: 
    mov rsi, search
    mov rdi, 30
    call empty_
    mov rsi, seq_111111
    mov rdi, search
    mov qword [mov_len], 6
    call mov_
    mov rsi, qword [index]
    mov qword [search_len], 6
    mov qword [search_limit], 6
    call search_
    cmp rsi, -1
    je opcode_sec1
    mov rsi, seq_111111
    mov rdi, opcode
    mov qword [mov_len], 6
    call mov_
    add qword [index], 6
    xor rbx, rbx
    mov rax, qword [index]
    mov bl, byte [rax]
    mov byte [d], bl
    ; d set
    add qword [index], 1
    xor rbx, rbx
    mov rax, qword [index]
    mov bl, byte [rax]
    mov byte [code_w], bl
    ; code_w set
    add qword [index], 1
    mov byte [ops], 0x31
    jmp mod_reg_rm_sec
opcode_sec1:
    mov rsi, qword [index]
    mov rdi, opcode
    mov qword [mov_len], 14
    call mov_
    add qword [index], 14
    mov rax, qword [index]
    xor rbx, rbx
    mov bl, byte [rax]
    mov byte [d], bl
    inc rax
    xor rbx, rbx
    mov bl, byte [rax]
    mov byte [code_w], bl
    inc rax
    mov qword [index], rax
    mov byte [ops], 0x32
    jmp mod_reg_rm_sec
;    #----------------------------------------------- MOD-REG-RM ----------------------------------------------- 
mod_reg_rm_sec:
    mov rsi, qword [index]
    mov rdi, mod
    mov qword [mov_len], 2
    call mov_
    ; mod set
    add qword [index], 2
    mov rsi, qword [index]
    mov rdi, reg
    mov qword [mov_len], 3
    call mov_
    ; reg set
    add qword [index], 3
    mov rsi, qword [index]
    mov rdi, rm
    mov qword [mov_len], 3
    call mov_
    ; rm set
    add qword [index], 3
;    #----------------------------------------------- SIB ----------------------------------------------- 
sib_sec:
    mov rsi, search
    mov rdi, 30
    call empty_
    mov rsi, seq_100
    mov rdi, search
    mov qword [mov_len], 3
    call mov_
    mov rsi, qword [index]
    mov qword [search_len], 3
    mov qword [search_limit], 3
    call search_
    cmp rsi, -1
    je disp_sec
    mov rsi, qword [index]
    mov rdi, sss
    mov qword [mov_len], 2
    call mov_
    ; ss set
    add qword [index], 2
    mov rsi, qword [index]
    mov rdi, inx
    mov qword [mov_len], 3
    call mov_
    ; inx set
    add qword [index], 3
    mov rsi, qword [index]
    mov rdi, bas
    mov qword [mov_len], 3
    call mov_
    ; bas set
    add qword [index], 3
    jmp disp_sec
;    #----------------------------------------------- DISP ----------------------------------------------- 
disp_sec:
    mov rax, qword [index]
    cmp byte [rax], 0x0
    je which_mod
    mov rsi, qword [index]
    mov rdi, disp
    mov qword [mov_len], 20
    mov byte [mov_seen], 0x0
    call mov_
    ; we also cropped disp
which_mod:  
    cmp byte [ops], 0x32
    je ops2
    cmp byte [ops], 0x31
    je ops1

;    #----------------------------------------------- Binary operands ----------------------------------------------- 
ops2:
    mov rsi, opcode
    mov rdi, 20
    call empty_
    cmp byte [code_w], 0x31
    je ops2_1
    mov rsi, bsf_word
    mov rdi, opcode
    mov qword [mov_len], 3
    call mov_
    jmp ops2_2
ops2_1:
    mov rsi, bsr_word
    mov rdi, opcode
    mov qword [mov_len], 3
    call mov_
ops2_2:
    mov rsi, search
    mov rdi, 20
    call empty_
    mov rsi, mod_11
    mov rdi, search
    mov qword [mov_len], 2
    call mov_
    mov rsi, mod
    mov qword [search_len], 2
    mov qword [search_limit], 2
    call search_
    cmp rsi, -1
    je ops2_3
    mov rsi, search
    mov rdi, 20
    call empty_
    mov rsi, mod_00
    mov rdi, search
    mov qword [mov_len], 2
    call mov_
    mov rsi, mod
    mov qword [search_len], 2
    mov qword [search_limit], 2
    call search_
    cmp rsi, -1
    ;je ;;;;;;;;;;#3
    mov rsi, search
    mov rdi, 20
    call empty_
    mov rsi, mod_00
    mov rdi, search
    mov qword [mov_len], 2
    call mov_
    mov rsi, sss
    mov qword [search_len], 2
    mov qword [search_limit], 2
    call search_
    cmp rsi, -1
    ;je ;;;;;;;;;;#3
    mov rsi, search
    mov rdi, 20
    call empty_
    mov rsi, seq_101
    mov rdi, search
    mov qword [mov_len], 3
    call mov_
    mov rsi, bas
    mov qword [search_len], 3
    mov qword [search_limit], 3
    call search_
    cmp rsi, -1
    ;je ;;;;;;;;;;#3
    mov rsi, search
    mov rdi, 20
    call empty_
    mov rsi, seq_100
    mov rdi, search
    mov qword [mov_len], 3
    call mov_
    mov rsi, inx
    mov qword [search_len], 3
    mov qword [search_limit], 3
    call search_
    cmp rsi, -1
    ;je ;;;;;;;;;;#3
    mov rsi, search
    mov rdi, 20
    call empty_
    mov rsi, seq_100
    mov rdi, search
    mov qword [mov_len], 3
    call mov_
    mov rsi, rm
    mov qword [search_len], 3
    mov qword [search_limit], 3
    call search_
    cmp rsi, -1
    ;je ;;;;;;;;;;#3
    jmp ops2_8
ops2_3: ; #1
    mov rsi, search
    mov rdi, 30
    call empty_
    mov rsi, mod_11
    mov rdi, search
    mov qword [mov_len], 3
    call mov_
    mov rsi, qword [index]
    mov qword [search_len], 3
    mov qword [search_limit], 3
    call search_
    cmp rsi, -1
    jne ops2_4
ops2_4: ; #1-1
    cmp byte [rex_valid], 0x31
    jne ops2_5
    mov byte [size], 0x6
    jmp ops2_7
ops2_5: ; #1-2
    cmp qword [operand_prefix], 0x0
    je ops2_6
    mov byte [size], 0x1
    jmp ops2_7
ops2_6: ; #1-3
    mov byte [size], 0x3
    jmp ops2_7
ops2_7:
    mov rax, reg_by_code_input1
    xor rbx, rbx
    mov bl, byte [rex_r]
    mov byte [rax], blops2:

    inc rax
    mov rsi, reg
    mov rdi, rax
    mov qword [mov_len], 3
    call mov_
    xor rax, rax
    mov al, byte [size]
    mov byte [reg_by_code_input2], al
    call find_reg_by_code
    mov rsi, op_name
    mov rdi, op1
    mov qword [mov_len], 5
    mov byte [mov_seen], 0x0
    call mov_
    ; op1 set
    mov rax, reg_by_code_input1
    xor rbx, rbx
    mov bl, byte [rex_b]
    mov byte [rax], bl
    inc rax
    mov rsi, rm
    mov rdi, rax
    mov qword [mov_len], 3
    call mov_
    xor rax, rax
    mov al, byte [size]
    mov byte [reg_by_code_input2], al
    call find_reg_by_code
    mov rsi, op_name
    mov rdi, op2
    mov qword [mov_len], 5
    mov byte [mov_seen], 0x0
    call mov_
    ; op2 set
    jmp ops2_last
ops2_8: ; #2

ops2_9:
ops2_10:
ops2_11:
ops2_last:


ops1:



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; this function will copy for address rsi to rdi, byte by byte till it sees [mov_seen], with a limit of [mov_len] bytes.
; rsi : address of source
; rdi : address of destination
; mov_seen : will copy until sees this character
; mov_len : will copy until this size
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
mov_:
    mov rbx, [mov_len]
    xor rcx, rcx
mov_loop:
    cmp rcx, rbx
    je return
    mov al, [rsi]
    cmp al, [mov_seen]
    je return
    mov [rdi], al
    inc rsi
    inc rdi
    inc rcx
    jmp mov_loop
return:
    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; next line
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
next_line:
    mov rsi, op_name
    mov rdi, 12
    call empty_
    mov rsi, op_size
    mov rdi, 12
    call empty_
    mov rsi, reg_by_code_input1
    mov rdi, 12
    call empty_
    mov rsi, reg_by_code_input2
    mov rdi, 12
    call empty_    
    mov rsi, reg_by_code_output
    mov rdi, 12
    call empty_
    mov rsi, ops
    mov rdi, 12
    call empty_
    mov rsi, operator_name
    mov rdi, 12
    call empty_
    mov rsi, d
    mov rdi, 12
    call empty_
    mov rsi, s
    mov rdi, 12
    call empty_
    mov rsi, op1
    mov rdi, 80
    call empty_
    mov rsi, op2
    mov rdi, 80
    call empty_
    mov rsi, op_trash
    mov rdi, 80
    call empty_
    mov rsi, op1_code
    mov rdi, 12
    call empty_
    mov rsi, gather_pointer
    mov rdi, 12
    call empty_
    mov rsi, disp_trash
    mov rdi, 20
    call empty_
    mov rsi, op2_code
    mov rdi, 12
    call empty_
    mov rsi, opcode
    mov rdi, 12
    call empty_
    mov rsi, op_code
    mov rdi, 12
    call empty_
    mov rsi, operand_size
    mov rdi, 12
    call empty_
    mov rsi, inx_code
    mov rdi, 12
    call empty_
    mov rsi, inx_size
    mov rdi, 12
    call empty_
    mov rsi, bas_code
    mov rdi, 12
    call empty_
    mov rsi, bas_size
    mov rdi, 12
    call empty_
    mov rsi, address_size
    mov rdi, 12
    call empty_
    mov rsi, mov_len
    mov rdi, 12
    call empty_
    mov rsi, rex_w
    mov rdi, 12
    call empty_
    mov rsi, rex_r
    mov rdi, 12
    call empty_
    mov rsi, rex_x
    mov rdi, 12
    call empty_
    mov rsi, rex_b
    mov rdi, 12
    call empty_
    mov rsi, operator_code
    mov rdi, 12
    call empty_
    mov rsi, zero
    mov rdi, 12
    call empty_
    mov rsi, reg
    mov rdi, 12
    call empty_
    mov rsi, disp
    mov rdi, 12
    call empty_
    mov rsi, data
    mov rdi, 12
    call empty_
    mov rsi, sss
    mov rdi, 12
    call empty_
    mov rsi, inx
    mov rdi, 12
    call empty_
    mov rsi, bas
    mov rdi, 12
    call empty_
    mov rsi, reg
    mov rdi, 12
    call empty_
    mov rsi, rm
    mov rdi, 12
    call empty_
    mov rsi, address_prefix
    mov rdi, 12
    call empty_
    mov rsi, operand_prefix
    mov rdi, 12
    call empty_
    mov rsi, len
    mov rdi, 12
    call empty_
    mov rsi, newline
    mov rdi, 1
    call print_as_output
    mov rsi, line
    mov rdi, 100
    call empty_
    mov rsi, qword [start_of_line]
    dec rsi
    mov rdi, line
    dec rdi
    cmp byte [finish], 0x31
    je exit
    jne line_loop
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; this function will search for [search] starting from rsi to 100 bytes, if it founds it found is 1, else found is 0
; [search] : key to search
; rsi : address to start searching till 100 bytes
; [search_len] : length of search word
; OUTPUT : rsi shows the index and if doesn't find it is -1.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
search_:
    mov rdi, search
    mov rcx, [search_len]
    xor rbx, rbx ; counter for search_len
    xor rdx, rdx ; counter to 100 for not found
search_loop:
    cmp rbx, [search_len]
    je search_found
    cmp rdx, [search_limit]
    je search_not_found
search_loop1:
    mov al, [rsi]
    cmp al, [rdi]
search_loop2:
    jne search_continue
    inc rbx
    inc rdi
    jmp search_continue1
search_continue:
    xor rbx, rbx
    mov rdi, search
search_continue1:
    inc rdx
    inc rsi
    jmp search_loop
search_found:
    mov byte [found], 0x1
    sub rsi, [search_len]
    ret
search_not_found:
    mov byte [found], 0x0
    xor rsi, rsi
    dec rsi
    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; this function will empty an array starting from rsi, till rdi bytes.
; rsi : starting point
; rdi : the amount of bytes we want to empty(0)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
empty_:
    xor rbx, rbx    ; counter to rdi
empty_loop:
    mov byte [rsi], 0
    inc rbx
    inc rsi
    cmp rbx, rdi
    jne empty_loop
    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; rsi : points to op 
; rdi : points to op_type that will fill
; OUTPUT : rsi will change the op_type value
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
operand_type:
    push rdi
    push rsi
    mov rsi, search
    mov rdi, 20
    call empty_
    mov rsi, open_bracket
    mov rdi, search
    mov byte [mov_seen], 0x3F
    mov qword [mov_len], 1
    call mov_ 

    mov qword [search_len], 1
    pop rsi
    push rsi
    mov qword [search_limit], 10
    call search_   
    cmp rsi, -1
    jne operand_type_mem
    ;;
    mov rsi, search
    mov rdi, 20
    call empty_
    mov rsi, x0_letter
    mov rdi, search
    mov byte [mov_seen], 0x3F
    mov qword [mov_len], 2
    call mov_ 
    mov qword [search_len], 2
    mov qword [search_limit], 100
    pop rsi
    push rsi
    call search_   
    cmp rsi, -1
    jne operand_type_imd
    jmp operand_type_reg
operand_type_mem:
    pop rsi
    pop rdi
    mov qword [rdi], 0x6D
    ret
operand_type_imd:
    pop rsi
    pop rdi
    mov qword [rdi], 0x69
    ret
operand_type_reg:
    pop rsi
    pop rdi
    mov qword [rdi], 0x72
    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; [reg_by_code_input1] : the code of register
; [reg_by_code_input2] : the size of register
; OUTPUT : op_name, name of register
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
find_reg_by_code:
find_reg_by_code_1:
    mov al, byte [reg_by_code_input2]
    cmp al, 0x38
    je find_reg_by_code_2
    cmp al, 0x31
    je find_reg_by_code_3
    cmp al, 0x33
    je find_reg_by_code_4
    cmp al, 0x36
    je find_reg_by_code_5
find_reg_by_code_2:
    mov rsi, search
    mov rdi, 20
    call empty_
    mov rsi, qword [reg_by_code_input1]
    mov rdi, search
    mov qword [mov_len], 4
    call mov_
    mov rsi, registers_code
    mov qword [search_len], 4
    mov qword [search_limit], 70
    call search_
    jmp find_reg_by_code_finish
find_reg_by_code_3:
    mov rsi, search
    mov rdi, 20
    call empty_
    mov rsi, qword [reg_by_code_input1]
    mov rdi, search
    mov qword [mov_len], 4
    call mov_
    mov rsi, registers_code
    add rsi, 64
    mov qword [search_len], 4
    mov qword [search_limit], 70
    call search_
    jmp find_reg_by_code_finish
find_reg_by_code_4:
    mov rsi, search
    mov rdi, 20
    call empty_
    mov rsi, qword [reg_by_code_input1]
    mov rdi, search
    mov qword [mov_len], 4
    call mov_
    mov rsi, registers_code
    add rsi, 128
    mov qword [search_len], 4
    mov qword [search_limit], 70
    call search_
    jmp find_reg_by_code_finish
find_reg_by_code_5:
    mov rsi, search
    mov rdi, 20
    call empty_
    mov rsi, qword [reg_by_code_input1]
    mov rdi, search
    mov qword [mov_len], 4
    call mov_
    mov rsi, registers_code
    add rsi, 192
    mov qword [search_len], 4
    mov qword [search_limit], 70
    call search_
    jmp find_reg_by_code_finish
find_reg_by_code_finish:
    mov rax, registers_code
    sub rsi, rax
    add rsi, registers_name
    mov rdi, op_name
    mov qword [mov_len], 5
    mov byte [mov_seen], 0x3F
    call mov_
    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; rsi : points to register_name
; OUTPUT : [op_code]
;        : [op_size]
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
find_reg_by_name:
find_reg_by_name_reg_size:
    push rsi
    xor rax, rax    ; register length
    mov rbx, rsi
find_reg_by_name_reg_size_loop:
    cmp byte [rbx], 0
    je find_reg_by_name_reg_size_loop_finish
    inc rax
    inc rbx
    jmp find_reg_by_name_reg_size_loop
find_reg_by_name_reg_size_loop_finish:
    mov rsi, search
    mov rdi, 20
    call empty_
    pop rsi
    mov rdi, search
    mov byte [mov_seen], 0x3F
    mov qword [mov_len], rax
    push rax
    call mov_
    mov rsi, registers_name
    pop rax
    mov qword [search_len], rax
    mov qword [search_limit], 1000
    call search_
    mov rax, registers_name
    sub rsi, rax
    push rsi
    add rsi, registers_code
    mov rdi, rsi
    mov rdx, op_code
    mov al, [rdi]
    mov [rdx], al
    inc rdi
    inc rdx
    mov al, [rdi]
    mov [rdx], al
    inc rdi
    inc rdx
    mov al, [rdi]
    mov [rdx], al
    inc rdi
    inc rdx
    mov al, [rdi]
    mov [rdx], al
    ; now we have the code in [op_code]
    pop rsi
    add rsi, registers_size
    mov rdx, op_size
    mov al, [rsi]
    mov [op_size], al
    mov rbx, rsi
    ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; rsi : points to operator_name
; rdi : points to where we want [operators_r, operators_i, operators_a]
; OUTPUT : [operator_code] : we have the code there
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
find_operator_by_name:
find_operator_by_name_operator_size:
    push rdi
    push rsi    
    xor rax, rax    ; operator length
    mov rbx, rsi
find_operator_by_name_operator_size_loop:
    cmp byte [rbx], 0
    je find_operator_by_name_operator_size_loop_finish
    inc rax
    inc rbx
    jmp find_operator_by_name_operator_size_loop
find_operator_by_name_operator_size_loop_finish:
    ; now we have operator size in rax
    xor rbx, rbx    ; the counter to 9 
    mov rsi, search
    mov rdi, 20
    call empty_
    pop rsi
    push rsi
    mov rdi, search
    mov byte [mov_seen], 0x3F
    mov qword [mov_len], rax
    push rax
    call mov_
    pop rax
    pop rsi
    mov rsi, operators_name
    mov qword [search_len], rax
    mov qword [search_limit], 1000
    call search_    
    ; now we have found operator in operators_name, by index of rsi
    sub rsi, operators_name
    pop rdi
    add rsi, rdi
    mov rdi, operator_code
    mov qword [mov_len], 9
    mov byte [mov_seen], 0x3F
    call mov_
    mov rax, operator_code
    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; rsi : points to what we want to be wrote
; rdi : number of bytes we want to write
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
print_as_output:
    push rdi
    push rsi
    mov rdi, fileNameDes
    call openFileA
    mov [FDdes], rax
    mov rdi, [FDdes]
    pop rsi
    pop rdx
    call writeFile
    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; rsi : points to what we want to be wrote
; rdi : number of bytes we want to write
; OUTPUT : [output] is the result array, and [output_end] always points to the end of output.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
write_in_output:
    push rdi
    push rsi
    xor rax, rax    ; counter to rdi
write_in_output_loop:
    mov [mov_len], rdi
write_in_output_loop_finish:
    xor rax, rax
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; rsi : points to mem, as [...]
; OUTPUT : disp, ss, inx and bas will be filled
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
find_mem:
    mov rax, op_trash
    push rsi
    mov rsi, swap_box
    mov rdi, 40
    call empty_
    pop rsi
    push rsi
    inc rsi
    mov rdi, swap_box
    mov byte [mov_seen], 0x5D
    mov qword [mov_len], 100
    call mov_
    pop rsi
    push rsi
    mov rdi, 100
    call empty_
    mov rsi, swap_box
    pop rdi
    push rdi
    mov byte [mov_seen], 0x0
    mov qword [mov_len], 100
    call mov_
    mov rsi, swap_box
    mov rdi, 100
    call empty_
    pop rsi
    push rsi
    ; now we deleted brackets from mem
    mov rsi, search
    mov rdi, 30
    call empty_
    mov rsi, x0_letter
    mov rdi, search
    mov qword [mov_len], 2
    call mov_
    pop rsi
    push rsi
    mov qword [search_limit], 40
    mov qword [search_len], 2
    call search_
    cmp rsi, -1
    je find_mem_1   ; means we have no disp
    push rsi
    add rsi, 2
    mov rdi, disp
    mov qword [mov_len], 20
    mov byte [mov_seen], 0x0
    call mov_
    pop rsi
    pop rax
    push rax
    sub rsi, rax    ; length of mem without disp
    push rsi
    mov rsi, swap_box
    mov rdi, 100
    call empty_
    pop rax
    pop rsi
    push rsi
    mov rdi, swap_box
    mov qword [mov_len], rax
    mov byte [mov_seen], 0x0
    call mov_
    pop rsi
    push rsi
    mov rdi, 100
    call empty_
    mov rsi, swap_box
    pop rdi
    push rdi
    mov qword [mov_len], 100
    mov byte [mov_seen], 0x0
    call mov_
    mov rsi, swap_box
    mov rdi, 100
    call empty_
    mov rax, op_trash
    ; now we cropped disp.
find_mem_1:
    mov rsi, search
    mov rdi, 30
    call empty_
    mov rsi, star
    mov rdi, search
    mov qword [mov_len], 1
    call mov_
    pop rsi
    push rsi
    mov qword [search_limit], 40
    mov qword [search_len], 1
    call search_
    cmp rsi, -1
    je find_mem_2     ; means we have no *, so no disp
    push rsi
    inc rsi
    mov rdi, sss
    mov byte [mov_seen], 0x20
    mov qword [mov_len], 40
    call mov_
    pop rsi
    mov rdi, 30
    call empty_     ; now we cropped *4...
find_mem_2:
    mov rsi, search
    mov rdi, 30
    call empty_
    mov rsi, plus
    mov rdi, search
    mov qword [mov_len], 1
    call mov_
    pop rsi
    push rsi
    mov rax, op_trash
    mov qword [search_limit], 40
    mov qword [search_len], 1
    call search_
    cmp rsi, -1
    je find_mem_3     ; means we have no +, so no inx
    push rsi
    add rsi, 2
    mov rdi, inx
    mov byte [mov_seen], 0x0
    mov qword [mov_len], 20
    call mov_
    pop rsi
    dec rsi
    mov rax, op_trash
    sub rsi, rax
    push rsi
    mov rsi, swap_box
    mov rdi, 100
    call empty_
    pop rax
    pop rsi
    push rsi
    mov rdi, swap_box
    mov qword [mov_len], rax
    mov byte [mov_seen], 0x0
    call mov_
    pop rsi
    push rsi
    mov rdi, 50
    call empty_
    mov rsi, swap_box
    pop rdi
    push rdi
    mov qword [mov_len], 100
    mov byte [mov_seen], 0x0
    call mov_
    mov rsi, swap_box
    mov rdi, 100
    call empty_
    pop rsi
    push rsi
find_mem_3:
    cmp qword [sss], 0x0 
    je find_mem_4
    cmp qword [inx], 0x0
    jne find_mem_4  
    ; means if sss and not inx
    mov rsi, op_trash
    mov rdi, inx
    mov byte [mov_seen], 0x0
    mov qword [mov_len], 30
    call mov_
    mov rsi, op_trash
    mov rdi, 50
    call empty_
find_mem_4:
    pop rsi
    cmp qword [op_trash], 0x0
    je find_mem_last
    mov rsi, op_trash
    mov rdi, bas
    mov qword [mov_len], 20
    mov byte [mov_seen], 0x0
    call mov_
    mov rsi, op_trash
    mov rdi, 50
    call empty_
    ret
find_mem_last:
    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; [operand_size]
; [address_size]
; OUTPUT : [prefix_return]
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
prefix:
    mov rax, qword [address_size]
    mov rbx, qword [operand_size]
    sub rbx, rax
    cmp rbx, -3
    je prefix_1
    cmp rbx, 0
    je prefix_2
    cmp rbx, -5
    je prefix_3
    cmp rbx, -2
    je prefix_4
    cmp rbx, 3
    je prefix_6
prefix_1:
    mov rsi, mod_00
    mov rdi, prefix_return
    mov qword [mov_len], 2
    call mov_
    ret
prefix_2:
    mov rax, qword [address_size]
    cmp rax, 0x36
    je prefix_5
    mov rsi, mod_01
    mov rdi, prefix_return
    mov qword [mov_len], 2
    call mov_
    ret
prefix_3:
    mov rsi, mod_10
    mov rdi, prefix_return
    mov qword [mov_len], 2
    call mov_
    ret
prefix_4:
    mov rsi, mod_11
    mov rdi, prefix_return
    mov qword [mov_len], 2
    call mov_
    ret
prefix_5:
    mov rsi, mod_00
    mov rdi, prefix_return
    mov qword [mov_len], 2
    call mov_
    ret
prefix_6:
    mov rsi, mod_01
    mov rdi, prefix_return
    mov qword [mov_len], 2
    call mov_
    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; op1 or mem_size (for imd at 2 ops and 1 ops)
; bas
; inx
; OUTPUT : [adress_prefix], [operand_prefix]
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
find_prefix:
    cmp qword [mem_size], 0x0
    jne find_prefix1
    mov rsi, op1
    call find_reg_by_name
    mov rsi, op_code
    mov rdi, op1_code
    mov qword [mov_len], 4
    call mov_
    mov rsi, op_size
    mov rdi, op1_size
    mov qword [mov_len], 1
    call mov_
    mov rsi, op1_size
    mov rdi, operand_size
    mov qword [mov_len], 1
    call mov_
    jmp find_prefix5
find_prefix1:
    cmp byte [mem_size], 0x62
    je find_prefix2
    cmp byte [mem_size], 0x64
    je find_prefix2
    cmp byte [mem_size], 0x77
    je find_prefix3
    cmp byte [mem_size], 0x71
    je find_prefix4
find_prefix2:
    mov qword [operand_size], 0x33
    jmp find_prefix5
find_prefix3:
    mov qword [operand_size], 0x31
    jmp find_prefix5
find_prefix4:
    mov qword [operand_size], 0x36
    jmp find_prefix5
find_prefix5: ; we have operand_size set.
    cmp qword [bas], 0x0
    je find_prefix6
    mov rsi, bas
    call find_reg_by_name
    mov rsi, op_code
    mov rdi, bas_code
    mov qword [mov_len], 4
    call mov_
    mov rsi, op_size
    mov rdi, bas_size
    mov qword [mov_len], 1
    call mov_
    mov rsi, bas_size
    mov rdi, address_size
    mov qword [mov_len], 1
    call mov_
    jmp find_prefix7
find_prefix6:
    cmp qword [inx], 0x0
    je find_prefix9
    mov rsi, inx
    call find_reg_by_name
    mov rsi, op_code
    mov rdi, inx_code
    mov qword [mov_len], 4
    call mov_
    mov rsi, op_size
    mov rdi, inx_size
    mov qword [mov_len], 1
    call mov_
    mov rsi, inx_size
    mov rdi, address_size
    mov qword [mov_len], 1
    call mov_
find_prefix7:
    call prefix
    cmp byte [prefix_return], 0x31
    jne find_prefix8
    mov rsi, defined_operand_prefix
    mov rdi, operand_prefix
    mov qword [mov_len], 8
    call mov_
find_prefix8:
    mov rax, prefix_return
    inc rax
    cmp byte [rax], 0x31
    jne find_prefix9
    mov rsi, defined_address_prefix
    mov rdi, address_prefix
    mov qword [mov_len], 8
    call mov_
find_prefix9:
    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; rsi
; [len_seen]
; OUTPUT : [len] till sees [len_seen]
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
len_:
    xor rax, rax    ; counter to for [len]
    xor rbx, rbx
len_1:
    mov bl, byte [rsi]
    cmp bl, byte [len_seen]
    je len_2
    inc rax
    inc rsi
    jmp len_1
len_2:
    mov qword [len], rax
    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; fills with 0 starting from rsi to [fill_len] bytes
; rsi
; [fill_len]
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
fill_:
    xor rax, rax
fill_1:
    cmp rax, qword [fill_len]
    je fill_2
    mov byte [rsi], 0x30
    inc rsi
    inc rax
    jmp fill_1
fill_2:
    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; disp
; sss
; bas
; OUTPUT : [mod], [disp]
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
find_disp_mod:
    mov rsi, disp
    mov byte [len_seen], 0x0
    call len_
    mov rsi, mod_00
    mov rdi, mod
    mov qword [mov_len], 2
    call mov_
    mov rsi, seq_0101
    mov rdi, bas
    mov qword [search_len], 4
    mov qword [search_limit], 6
    call search_
    cmp rsi, -1
    jne find_disp_mod1
    jmp find_disp_mod3
find_disp_mod1:
    cmp qword [disp], 0x0
    je find_disp_mod2
    jmp find_disp_mod3
find_disp_mod2:     ; #1 : if bas code 0101 and not disp
    mov rsi, mod_01
    mov rdi, mod
    mov qword [mov_len], 2
    call mov_
    mov rsi, mod_00
    mov rdi, disp
    mov qword [mov_len], 2
    call mov_
    jmp find_disp_mod_last
find_disp_mod3:     ; else #1
    cmp qword [sss], 0x0
    jne find_disp_mod4
    jmp find_disp_mod5
find_disp_mod4:     ; #2 : if ss and not bas
    cmp qword [bas], 0x0
    jne find_disp_mod5
    mov rsi, mod_00
    mov rdi, mod
    mov qword [mov_len], 2
    call mov_    
    ; now we have length of disp at [len]
    xor rax, rax
    mov rax, 8
    sub rax, qword [len]    ; number of zeros needed
    push rax
    mov rsi, swap_box
    mov rdi, 100
    call empty_
    mov rsi, disp
    mov rdi, swap_box
    xor rax, rax
    mov rax, qword [len]
    mov qword [mov_len], rax
    call mov_
    mov rsi, disp
    mov rdi, 16
    call empty_
    pop rax
    push rax
    mov qword [fill_len], rax
    mov rsi, disp
    call fill_
    xor rsi, rsi
    mov rsi, disp
    pop rax
    add rsi, rax
    mov rdi, rsi
    mov rsi, swap_box
    mov rax, qword [len]
    mov qword [mov_len], rax
    call mov_
    mov rax, disp
    jmp find_disp_mod_last
find_disp_mod5:     ; else #2, #3 : if len disp == 2
    cmp qword [len], 2
    jne find_disp_mod6
    mov rsi, mod_01
    mov rdi, mod
    mov qword [mov_len], 2
    call mov_     
    jmp find_disp_mod_last
find_disp_mod6:     ; else #3
    mov rsi, disp
    mov byte [len_seen], 0x0
    call len_
    cmp qword [len], 0
    je find_disp_mod_last1
    mov rsi, mod_10
    mov rdi, mod
    mov qword [mov_len], 2
    call mov_   
    mov rsi, disp
    mov byte [len_seen], 0x0
    call len_
    ; now we have length of disp at [len]
    xor rax, rax
    mov rax, 8
    sub rax, qword [len]    ; number of zeros needed
    push rax
    mov rsi, swap_box
    mov rdi, 100
    call empty_
    mov rsi, disp
    mov rdi, swap_box
    xor rax, rax
    mov rax, qword [len]
    mov qword [mov_len], rax
    call mov_
    mov rsi, disp
    mov rdi, 16
    call empty_
    pop rax
    push rax
    mov qword [fill_len], rax
    mov rsi, disp
    call fill_
    xor rsi, rsi
    mov rsi, disp
    pop rax
    add rsi, rax
    mov rdi, rsi
    mov rsi, swap_box
    mov rax, qword [len]
    mov qword [mov_len], rax
    call mov_
    mov rax, disp
    jmp find_disp_mod_last
find_disp_mod_last:
    call reverse_disp
find_disp_mod_last1:
    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; sss
; OUTPUT : [sss]
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
find_sss:
    mov rax, sss
    cmp qword [sss], 0x32
    je find_sss1
    cmp qword [sss], 0x34
    je find_sss2
    cmp qword [sss], 0x38
    je find_sss3
    mov rsi, mod_00
    mov rdi, sss
    mov qword [mov_len], 2
    call mov_
    ret
find_sss1:
    mov rsi, mod_01
    mov rdi, sss
    mov qword [mov_len], 2
    call mov_
    ret
find_sss2:
    mov rsi, mod_10
    mov rdi, sss
    mov qword [mov_len], 2
    call mov_
    ret
find_sss3:
    mov rsi, mod_11
    mov rdi, sss
    mov qword [mov_len], 2
    call mov_
    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; rsi : points to where we want to make hex
; OUTPUT : [sss]
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
find_sss:
    mov rax, sss
    cmp qword [sss], 0x32
    je find_sss1
    cmp qword [sss], 0x34
    je find_sss2
    cmp qword [sss], 0x38
    je find_sss3
    mov rsi, mod_00
    mov rdi, sss
    mov qword [mov_len], 2
    call mov_
    ret
find_sss1:
    mov rsi, mod_01
    mov rdi, sss
    mov qword [mov_len], 2
    call mov_
    ret
find_sss2:
    mov rsi, mod_10
    mov rdi, sss
    mov qword [mov_len], 2
    call mov_
    ret
find_sss3:
    mov rsi, mod_11
    mov rdi, sss
    mov qword [mov_len], 2
    call mov_
    ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; disp
; OUTPUT : [disp]
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
reverse_disp:
    mov rsi, disp_trash
    mov rdi, 50
    call empty_
    xor r9, r9
    mov rsi, disp
    mov byte [len_seen], 0x0
    call len_
    xor rax, rax
    add rax, qword [len]
    add rax, disp
    sub rax, 2
    push rax
    mov rsi, rax
    mov rdi, disp_trash
    mov qword [mov_len], 2
    call mov_
    add r9, 2
    cmp r9, qword [len]
    je reverse_disp_last
    pop rax
    sub rax, 2
    push rax
    mov rsi, rax
    mov rdi, disp_trash
    add rdi, 2
    mov qword [mov_len], 2
    call mov_
    add r9, 2
    cmp r9, qword [len]
    je reverse_disp_last
    pop rax
    sub rax, 2
    push rax
    mov rsi, rax
    mov rdi, disp_trash
    add rdi, 4
    mov qword [mov_len], 2
    call mov_
    add r9, 2
    cmp r9, qword [len]
    je reverse_disp_last
    pop rax
    sub rax, 2
    push rax
    mov rsi, rax
    mov rdi, disp_trash
    add rdi, 6
    mov qword [mov_len], 2
    call mov_
    add r9, 2
    cmp r9, qword [len]
    je reverse_disp_last
reverse_disp_last:
    pop rax
    mov rsi, disp
    mov rdi, 12
    call empty_
    mov rsi, disp_trash
    mov rdi, disp
    mov qword [mov_len], 20
    mov byte [mov_seen], 0x0
    call mov_
    ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; this function will gather all datas in one memory sequential so it is ready to write
; rsi : points to what we want to gather 
; gather_pointer : points to where we want to push new string (means last )
; OUTPUT : [gather]
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
gather_:
    xor rax, rax
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; rsi : points to where we want to be binary
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
hex_to_bin:
    push rsi
    mov rsi, swap_box
    mov rdi, 100
    call empty_
    pop rsi
    push rsi
    mov rdi, swap_box
    mov qword [mov_len], 30
    mov byte [mov_seen], 0x0
    call mov_
    pop rsi
    push rsi
    mov rdi, 30
    call empty_
    ; now the data is in swap_box
    mov r8, swap_box
hex_to_bin_loop:
    cmp byte [r8], 0x0
    je hex_to_bin_loop_finish
    mov rsi, search
    mov rdi, 50
    call empty_
    mov rsi, r8
    mov rdi, search
    mov qword [mov_len], 1
    call mov_
    mov rsi, number_names
    mov qword [search_len], 1
    mov qword [search_limit], 200
    call search_
    ; now we found index at number_names
    mov rax, number_names
    sub rsi, rax
    add rsi, number_codes
    ; now we have index at number_codes
    pop rdi
    push rdi
    mov qword [mov_len], 4
    call mov_
    pop rdi
    add rdi, 4
    push rdi
    inc r8
    jmp hex_to_bin_loop
hex_to_bin_loop_finish:
    pop rdi
    ret
exit: 