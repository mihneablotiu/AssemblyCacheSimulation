section .text
    global rotp
    
;; void rotp(char *ciphertext, char *plaintext, char *key, int len);
rotp_algo:
    xor eax, eax
nextChar:
    ; Taking the characters in the key
    ; in inverse order
    mov al, byte[edi + ecx - 1]

    ; xor with the corespondent byte
    ; from the plaintext
    xor al, byte[esi]

    ; Storing the result
    mov byte[edx], al

    ; Updating the indexes/addresses
    ; for the next step
    inc esi
    dec al
    inc edx

    loop nextChar
    ret

rotp:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     edx, [ebp + 8]  ; ciphertext
    mov     esi, [ebp + 12] ; plaintext
    mov     edi, [ebp + 16] ; key
    mov     ecx, [ebp + 20] ; len
    ;; DO NOT MODIFY

    ;; TODO: Implment rotp
    ;; FREESTYLE STARTS HERE

    ; Calling the function that 
    ; calculates the ciphertext
    call rotp_algo
    
    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY