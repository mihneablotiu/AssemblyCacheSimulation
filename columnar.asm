section .data
    extern len_cheie, len_haystack
    counter_len dd 0 ; current position in the order array
    counter dd 0 ; the number of positions in the oreder array

section .text
    global columnar_transposition

codingTransposition:

    ; Starting from the first position in the
    ; order array
    mov dword[counter_len], 0

coding:

    ; Comparing the current position with
    ; the number of positions in the order array
    mov eax, dword[counter_len]
    cmp eax, [counter]
    jle order

back:
    ; Putting at the next address the coresponding
    ; value of the plaintext by iterating from
    ; len_cheie in len_cheie positions with
    ; an offset without exiting the dimension 
    ; of the text
    mov dl, byte[esi + ecx] 
    mov byte[ebx], dl
    inc ebx
    add ecx, [len_cheie]
    cmp ecx, [len_haystack]
    jge continue
    jmp back

continue:
    add dword[counter_len], 1
    cmp eax, [counter]
    jnz coding
    ret

order:

    ; If there are still unconsidered columns
    ; we are setting ECX as the next index
    mov ecx, dword[edi + 4 * eax]
    jmp back

;; void columnar_transposition(int key[], char *haystack, char *ciphertext);
columnar_transposition:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha 

    mov edi, [ebp + 8]   ;key
    mov esi, [ebp + 12]  ;haystack
    mov ebx, [ebp + 16]  ;ciphertext
    ;; DO NOT MODIFY

    ;; TODO: Implment columnar_transposition
    ;; FREESTYLE STARTS HERE

    ; calculating the number of positions 
    ; in the oreder array
    mov eax, [len_cheie]
    mov dword[counter], eax
    sub dword[counter], 1

    ; Calling the function that realises
    ; the coding
    call codingTransposition

    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY