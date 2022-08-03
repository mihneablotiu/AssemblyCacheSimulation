; This is your structure
struc  my_date
    .day: resw 1
    .month: resw 1
    .year: resd 1
endstruc

section .text
    global ages

section .data
    counter dd 0 ; How many ages we calculated until now
    day dd 0 ; The day of the current != present date
    month dd 0 ; The month of the current != present date
    year dd 0 ; The year of the current != present date
    age dd 0 ; The calculated, final age

calcAges:
    xor eax, eax
    
    ; Starting from the first date
    mov dword[counter], 0

continue:
    ; EBX is the index of the dates
    mov ebx, dword[counter]

    ; Storing in EAX the value of the year from the current index
    mov eax, dword[edi + my_date_size * ebx + my_date.year]

    ; Storing it in year
    mov dword[year], eax

    ; Storing the present year in EAX
    mov eax, dword[esi + my_date.year]

    ; If the present year is grater than the value from the
    ; current index, then we can calculate the age 
    cmp eax, dword[year]
    jg calculate

    ; Else, it means that we need to return 0 and
    ; we move to the next index
    mov dword[age], 0
    mov eax, dword[age]
    mov dword[ecx], eax
    add ecx, 4
    add dword[counter], 1
    cmp [counter], edx
    jnz continue
    ret

back:
    ; Writing the result after calculating in the
    ; normal conditions
    mov eax, dword[age]
    mov dword[ecx], eax
    add ecx, 4
    add dword[counter], 1
    cmp [counter], edx
    jnz continue
    ret

calculate:
    ; We calculate the age as the difference between
    ; the present year and the born year
    sub eax, dword[year]
    mov dword[age], eax

    ; Comparing the present month with the born month
    mov ax, word[edi + my_date_size * ebx + my_date.month]
    mov word[month], ax
    mov ax, word[esi + my_date.month]

    ; If the present month is less than the index one
    ; we need to substract 1 from the age, if they are
    ; equal we need to compare the days else we just go
    ; back in order to write the answer
    cmp ax, word[month]
    jl under
    je here
    jmp back

here:  
    ; Comparing the present day with the index one
    ; similarly as comparing the months
    mov ax, word[edi + my_date_size * ebx + my_date.day]
    mov word[day], ax
    mov ax, word[esi + my_date.day]
    cmp ax, word[day]
    jl under
    jmp back

under:
    ; Substracting one from the final age if needed
    sub dword[age], 1
    jmp back

; void ages(int len, struct my_date* present, struct my_date* dates, int* all_ages);
ages:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]  ; len
    mov     esi, [ebp + 12] ; present
    mov     edi, [ebp + 16] ; dates
    mov     ecx, [ebp + 20] ; all_ages
    ;; DO NOT MODIFY

    ;; TODO: Implement ages
    ;; FREESTYLE STARTS HERE

    ; Calling the function that calculates
    ; the ages of all the dates and stores
    ; them in the all_ages array
    call calcAges

    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY
