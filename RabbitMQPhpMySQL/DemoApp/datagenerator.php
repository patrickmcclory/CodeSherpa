<?PHP

    function generateRandomString($length = 5) {
        $characters = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
        $randomString = '';
        for ($i = 0; $i < $length; $i++) {
            $randomString .= $characters[rand(0, strlen($characters) - 1)];
        }
        return $randomString;
    }
    
    $uniqueID = uniqid('',true);
    $randomChar1 = generateRandomString();
    $randomChar2 = generaterandomstring();
    
    $insertStatement = "INSERT INTO dataStore /nVALUES('".$uniqueID."', '".$randomChar1."', '".$randomChar2."')";
    
?>